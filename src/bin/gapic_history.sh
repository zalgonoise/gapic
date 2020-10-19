#!/bin/zsh
#   Copyright 2020 ZalgoNoise
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.


# Request history JSON builder

histGenRequest() {
    local currentTimestamp=`date +%s`$((`date +%N`/1000000))
    export requestId=`echo -n ${currentTimestamp} \
    | sha1sum \
    | awk '{print $1}'`

    jq -cn  \
    --arg rid ${requestId} \
    --arg ts ${currentTimestamp} \
    --arg cid ${1} \
    --arg atk ${2} \
    --arg rtk ${3} \
    --arg res ${4} \
    --arg met ${5} \
    --arg hmt ${6} \
    --arg url ${7} \
    '{ requestId: $rid, timestamp: $ts, auth: { clientId: $cid, accessToken: $atk, refreshToken: $rtk, curl: null, response: null}, request: { resource: $res, method: $met, httpMethod: $hmt, url: $url, headers: [], curl: null }, response: null}' \
    | read requestPayload

    export requestPayload
}

histListBuild() {
    jq -c "${1}=[${1}[],${2}]" \
    | read -r requestPayload

    export requestPayload
}

histUpdatePayload() {
    jq -c "${1}=${2}" \
    | read -r requestPayload

    export requestPayload
}


histNewEntry() {
    if ! [[ -f ${2}${3} ]]
    then 
        echo "[${1}]" \
        | jq \
        > ${2}${3}
    else
        cat ${2}${3} \
        | jq -c \
        | read -r savedPayload

        echo ${savedPayload} \
        | histListBuild "." "${1}"
        
        if [[ `echo ${requestPayload} | jq -c ` ]]
        then
            echo ${requestPayload} \
            | jq \
            > ${2}${3}
        fi
    fi
}

histUpdateToken() {
    cat ${gapicLogDir}${gapicReqLog} \
    | jq \
    --arg replace ${3} -c \
    "map((select(.requestId == ${1}) | ${2}) |=  \$replace)" \
    | read -r newPayload

    if [[ `echo ${newPayload} | jq -c ` ]]
    then
        echo ${newPayload} \
        | jq \
        > ${gapicLogDir}${gapicReqLog}
    fi

    unset newPayload

}

histUpdateJson() {
    cat ${gapicLogDir}${gapicReqLog} \
    | jq \
    -c \
    "map((select(.requestId == ${1}) | ${2}) |=  ${3})" \
    | read -r newPayload

    if [[ `echo ${newPayload} | jq -c ` ]]
    then
        echo ${newPayload} \
        | jq \
        > ${gapicLogDir}${gapicReqLog}
    fi

    unset newPayload

}


histReplayRequest() {
    if [[ `echo ${1} | jq -r '.tags'` != "null" ]] \
    && [[ `echo ${1} | jq -r '.tags.replay'` == "true" ]]
    then
        export origReqId=`echo ${1} | jq -r '.tags.origin'`
    else
        export origReqId=`echo ${1} | jq -r '.requestId'`

    fi

    export CLIENTID=`echo ${1} | jq -r '.auth.clientId' `
    export fileRef=`echo ${CLIENTID//-/ } | awk '{print $1}'`
    export CLIENTSECRET=`cat ${credPath}/${fileRef} | jq -r '.clientSecret'`
    export ACCESSTOKEN=`echo ${1} | jq -r '.auth.accessToken'`
    export REFRESHTOKEN=`echo ${1} | jq -r '.auth.refreshToken'`

    
    if [[ `echo ${1} | jq -r '.auth.response.scope'` == 'null'  ]]
    then
        export requestScope=`cat ${credPath}/${fileRef} | jq -r ".authScopes[] | select(.refreshToken == \"${REFRESHTOKEN}\") | .scopeUrl" `
    else
        export requestScope=`echo ${1} | jq -r '.auth.response.scope'`
    fi

    local reqResource=`echo ${1} | jq -r '.request.resource'`
    local reqMethod=`echo ${1} | jq -r '.request.method'`
    local met=`echo ${1} | jq -r '.request.httpMethod'`
    local url=`echo ${1} | jq -r '.request.url'`

    local headersCounter=( `echo ${1} | jq '.request.headers | keys[] ' ` )

    if [[ ${#headersCounter[@]} -eq 2 ]] \
    && [[ `echo ${1} | jq ".request.headers[${headersCounter[1]}]"` =~ "Authorization: Bearer " ]] \
    && [[ `echo ${1} | jq ".request.headers[${headersCounter[2]}]"` == '"Accept: application/json"' ]]
    then

        execRequest() {
            if [[ -z ${requestId} ]]
            then 
                histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${reqResource}" "${reqMethod}" "${met}" "${url}"

                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "${sentAuthRequest}"

                    echo  \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi
    
                echo ${requestPayload} \
                | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""
                
                echo ${requestPayload} \
                | histListBuild ".request.headers" "\"Accept: application/json\""

                histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"
            else
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi


            curl -s \
            --request ${met} \
            ${(Q)url} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

            histUpdateJson "\"${requestId}\"" ".tags" "{\"replay\":true,\"origin\":\"${origReqId}\"}"          
            histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          
            histUpdateToken "\"${requestId}\"" ".request.curl" "curl -s --request ${met} ${(Q)url} --header 'Authorization: Bearer ${ACCESSTOKEN}' --header 'Accept: application/json' --compressed"          

        }

        execRequest

        if ! [[ -z ${outputJson} ]]
        then
            gapicPostExec
        else
            echo -e "# No JSON output, please debug.\n\n"
        fi
        

    fi
}

