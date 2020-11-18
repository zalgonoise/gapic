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


gapicSets=( asps channels chromeosdevices customers domainAliases domains groups members mobiledevices orgunits privileges roleAssignments roles schemas tokens twoStepVerification users verificationCodes )

asps=( asps_delete asps_get asps_list )
channels=( channels_stop )
chromeosdevices=( chromeosdevices_action chromeosdevices_get chromeosdevices_list chromeosdevices_moveDevicesToOu chromeosdevices_patch chromeosdevices_update )
customers=( customers_get customers_patch customers_update )
domainAliases=( domainAliases_delete domainAliases_get domainAliases_insert domainAliases_list )
domains=( domains_delete domains_get domains_insert domains_list )
groups=( groups_delete groups_get groups_insert groups_list groups_patch groups_update )
members=( members_delete members_get members_hasMember members_insert members_list members_patch members_update )
mobiledevices=( mobiledevices_action mobiledevices_delete mobiledevices_get mobiledevices_list )
orgunits=( orgunits_delete orgunits_get orgunits_insert orgunits_list orgunits_patch orgunits_update )
privileges=( privileges_list )
roleAssignments=( roleAssignments_delete roleAssignments_get roleAssignments_insert roleAssignments_list )
roles=( roles_delete roles_get roles_insert roles_list roles_patch roles_update )
schemas=( schemas_delete schemas_get schemas_insert schemas_list schemas_patch schemas_update )
tokens=( tokens_delete tokens_get tokens_list )
twoStepVerification=( twoStepVerification_turnOff )
users=( users_delete users_get users_insert users_list users_makeAdmin users_patch users_signOut users_undelete users_update users_watch )
verificationCodes=( verificationCodes_generate verificationCodes_invalidate verificationCodes_list )

asps_delete() {

    apiQueryRef=( `echo asps delete` )


    codeIdMeta=( 
        'integer'
        'The unique ID of the ASP to be deleted.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.codeId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.codeId)[] | .[]' ` ]]
            then
                checkParams asps_delete codeId "false"
            else
                getParams "asps_delete" "codeId"
            fi
        else
            getParams "asps_delete" "codeId"
        fi
    else
        genParamConfig
        getParams "asps_delete" "codeId"
    fi

    #    declare -g "ASPS_DELETE_codeId=${codeId}"


    
    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams asps_delete userKey "false"
            else
                getParams "asps_delete" "userKey"
            fi
        else
            getParams "asps_delete" "userKey"
        fi
    else
        genParamConfig
        getParams "asps_delete" "userKey"
    fi

    #    declare -g "ASPS_DELETE_userKey=${userKey}"


    

    ASPS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/asps/${codeId}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ASPS_DELETE_URL} =~ "pageToken=" ]]
            then                
                ASPS_DELETE_URL+=\&pageToken=${1}
            else 
                ASPS_DELETE_URL=`echo -n ${ASPS_DELETE_URL} | sed "s/$(echo ${ASPS_DELETE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "DELETE" "${ASPS_DELETE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request DELETE \
            ${ASPS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request DELETE \
            ${ASPS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request DELETE \"${ASPS_DELETE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${ASPS_DELETE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


asps_get() {

    apiQueryRef=( `echo asps get` )


    codeIdMeta=( 
        'integer'
        'The unique ID of the ASP.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.codeId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.codeId)[] | .[]' ` ]]
            then
                checkParams asps_get codeId "false"
            else
                getParams "asps_get" "codeId"
            fi
        else
            getParams "asps_get" "codeId"
        fi
    else
        genParamConfig
        getParams "asps_get" "codeId"
    fi

    #    declare -g "ASPS_GET_codeId=${codeId}"


    
    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams asps_get userKey "false"
            else
                getParams "asps_get" "userKey"
            fi
        else
            getParams "asps_get" "userKey"
        fi
    else
        genParamConfig
        getParams "asps_get" "userKey"
    fi

    #    declare -g "ASPS_GET_userKey=${userKey}"


    

    ASPS_GET_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/asps/${codeId}?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ASPS_GET_URL} =~ "pageToken=" ]]
            then                
                ASPS_GET_URL+=\&pageToken=${1}
            else 
                ASPS_GET_URL=`echo -n ${ASPS_GET_URL} | sed "s/$(echo ${ASPS_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${ASPS_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${ASPS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${ASPS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${ASPS_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ASPS_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


asps_list() {

    apiQueryRef=( `echo asps list` )


    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams asps_list userKey "false"
            else
                getParams "asps_list" "userKey"
            fi
        else
            getParams "asps_list" "userKey"
        fi
    else
        genParamConfig
        getParams "asps_list" "userKey"
    fi

    #    declare -g "ASPS_LIST_userKey=${userKey}"


    

    ASPS_LIST_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/asps?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ASPS_LIST_URL} =~ "pageToken=" ]]
            then                
                ASPS_LIST_URL+=\&pageToken=${1}
            else 
                ASPS_LIST_URL=`echo -n ${ASPS_LIST_URL} | sed "s/$(echo ${ASPS_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${ASPS_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${ASPS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${ASPS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${ASPS_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ASPS_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


channels_stop() {

    apiQueryRef=( `echo channels stop` )



    CHANNELS_STOP_URL="https://www.googleapis.com/admin/directory_v1/channels/stop?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Channel.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Channel"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${CHANNELS_STOP_URL} =~ "pageToken=" ]]
            then                
                CHANNELS_STOP_URL+=\&pageToken=${1}
            else 
                CHANNELS_STOP_URL=`echo -n ${CHANNELS_STOP_URL} | sed "s/$(echo ${CHANNELS_STOP_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${CHANNELS_STOP_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${CHANNELS_STOP_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${CHANNELS_STOP_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${CHANNELS_STOP_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${CHANNELS_STOP_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


chromeosdevices_action() {

    apiQueryRef=( `echo chromeosdevices action` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams chromeosdevices_action customerId "false"
            else
                getParams "chromeosdevices_action" "customerId"
            fi
        else
            getParams "chromeosdevices_action" "customerId"
        fi
    else
        genParamConfig
        getParams "chromeosdevices_action" "customerId"
    fi

    #    declare -g "CHROMEOSDEVICES_ACTION_customerId=${customerId}"


    
    resourceIdMeta=( 
        'string'
        'Immutable ID of Chrome OS Device'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.resourceId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.resourceId)[] | .[]' ` ]]
            then
                checkParams chromeosdevices_action resourceId "false"
            else
                getParams "chromeosdevices_action" "resourceId"
            fi
        else
            getParams "chromeosdevices_action" "resourceId"
        fi
    else
        genParamConfig
        getParams "chromeosdevices_action" "resourceId"
    fi

    #    declare -g "CHROMEOSDEVICES_ACTION_resourceId=${resourceId}"


    

    CHROMEOSDEVICES_ACTION_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/${resourceId}/action?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.ChromeOsDeviceAction.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "ChromeOsDeviceAction"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${CHROMEOSDEVICES_ACTION_URL} =~ "pageToken=" ]]
            then                
                CHROMEOSDEVICES_ACTION_URL+=\&pageToken=${1}
            else 
                CHROMEOSDEVICES_ACTION_URL=`echo -n ${CHROMEOSDEVICES_ACTION_URL} | sed "s/$(echo ${CHROMEOSDEVICES_ACTION_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${CHROMEOSDEVICES_ACTION_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${CHROMEOSDEVICES_ACTION_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${CHROMEOSDEVICES_ACTION_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${CHROMEOSDEVICES_ACTION_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${CHROMEOSDEVICES_ACTION_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


chromeosdevices_get() {

    apiQueryRef=( `echo chromeosdevices get` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams chromeosdevices_get customerId "false"
            else
                getParams "chromeosdevices_get" "customerId"
            fi
        else
            getParams "chromeosdevices_get" "customerId"
        fi
    else
        genParamConfig
        getParams "chromeosdevices_get" "customerId"
    fi

    #    declare -g "CHROMEOSDEVICES_GET_customerId=${customerId}"


    
    deviceIdMeta=( 
        'string'
        'Immutable ID of Chrome OS Device'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.deviceId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.deviceId)[] | .[]' ` ]]
            then
                checkParams chromeosdevices_get deviceId "false"
            else
                getParams "chromeosdevices_get" "deviceId"
            fi
        else
            getParams "chromeosdevices_get" "deviceId"
        fi
    else
        genParamConfig
        getParams "chromeosdevices_get" "deviceId"
    fi

    #    declare -g "CHROMEOSDEVICES_GET_deviceId=${deviceId}"


    

    CHROMEOSDEVICES_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/${deviceId}?key=${CLIENTID}"

    optParams=( projection )

    projectionMeta=(
        'string'
        'Restrict information returned to a set of selected fields.'
        '["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams chromeosdevices_get ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    CHROMEOSDEVICES_GET_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "chromeosdevices_get" "${option}" "true"
                                CHROMEOSDEVICES_GET_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "chromeosdevices_get" "${option}" "true"
                            CHROMEOSDEVICES_GET_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "chromeosdevices_get" "${option}" "true"
                        CHROMEOSDEVICES_GET_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${CHROMEOSDEVICES_GET_URL} =~ "pageToken=" ]]
            then                
                CHROMEOSDEVICES_GET_URL+=\&pageToken=${1}
            else 
                CHROMEOSDEVICES_GET_URL=`echo -n ${CHROMEOSDEVICES_GET_URL} | sed "s/$(echo ${CHROMEOSDEVICES_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${CHROMEOSDEVICES_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${CHROMEOSDEVICES_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${CHROMEOSDEVICES_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${CHROMEOSDEVICES_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${CHROMEOSDEVICES_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


chromeosdevices_list() {

    apiQueryRef=( `echo chromeosdevices list` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams chromeosdevices_list customerId "false"
            else
                getParams "chromeosdevices_list" "customerId"
            fi
        else
            getParams "chromeosdevices_list" "customerId"
        fi
    else
        genParamConfig
        getParams "chromeosdevices_list" "customerId"
    fi

    #    declare -g "CHROMEOSDEVICES_LIST_customerId=${customerId}"


    

    CHROMEOSDEVICES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos?key=${CLIENTID}"

    optParams=( orderBy projection sortOrder )

    orderByMeta=(
        'string'
        'Column to use for sorting results'
        '["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )

    projectionMeta=(
        'string'
        'Restrict information returned to a set of selected fields.'
        '["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    sortOrderMeta=(
        'string'
        'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
        '["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams chromeosdevices_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    CHROMEOSDEVICES_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "chromeosdevices_list" "${option}" "true"
                                CHROMEOSDEVICES_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "chromeosdevices_list" "${option}" "true"
                            CHROMEOSDEVICES_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "chromeosdevices_list" "${option}" "true"
                        CHROMEOSDEVICES_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi

    inpParams=( maxResults orgUnitPath pageToken query )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return.'
    )

    orgUnitPathMeta=(
        'string'
        'Full path of the organizational unit or its ID'
    )

    pageTokenMeta=(
        'string'
        'Token to specify next page in the list'
    )

    queryMeta=(
        'string'
        'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams chromeosdevices_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    CHROMEOSDEVICES_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "chromeosdevices_list" "${option}" "true"
                                CHROMEOSDEVICES_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "chromeosdevices_list" "${option}" "true"
                            CHROMEOSDEVICES_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "chromeosdevices_list" "${option}" "true"
                        CHROMEOSDEVICES_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${CHROMEOSDEVICES_LIST_URL} =~ "pageToken=" ]]
            then                
                CHROMEOSDEVICES_LIST_URL+=\&pageToken=${1}
            else 
                CHROMEOSDEVICES_LIST_URL=`echo -n ${CHROMEOSDEVICES_LIST_URL} | sed "s/$(echo ${CHROMEOSDEVICES_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${CHROMEOSDEVICES_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${CHROMEOSDEVICES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${CHROMEOSDEVICES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${CHROMEOSDEVICES_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${CHROMEOSDEVICES_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


chromeosdevices_moveDevicesToOu() {

    apiQueryRef=( `echo chromeosdevices moveDevicesToOu` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams chromeosdevices_moveDevicesToOu customerId "false"
            else
                getParams "chromeosdevices_moveDevicesToOu" "customerId"
            fi
        else
            getParams "chromeosdevices_moveDevicesToOu" "customerId"
        fi
    else
        genParamConfig
        getParams "chromeosdevices_moveDevicesToOu" "customerId"
    fi

    #    declare -g "CHROMEOSDEVICES_MOVEDEVICESTOOU_customerId=${customerId}"


    
    orgUnitPathMeta=( 
        'string'
        'Full path of the target organizational unit or its ID'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.orgUnitPath)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.orgUnitPath)[] | .[]' ` ]]
            then
                checkParams chromeosdevices_moveDevicesToOu orgUnitPath "false"
            else
                getParams "chromeosdevices_moveDevicesToOu" "orgUnitPath"
            fi
        else
            getParams "chromeosdevices_moveDevicesToOu" "orgUnitPath"
        fi
    else
        genParamConfig
        getParams "chromeosdevices_moveDevicesToOu" "orgUnitPath"
    fi

    #    declare -g "CHROMEOSDEVICES_MOVEDEVICESTOOU_orgUnitPath=${orgUnitPath}"


    

    CHROMEOSDEVICES_MOVEDEVICESTOOU_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/moveDevicesToOu?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.ChromeOsMoveDevicesToOu.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "ChromeOsMoveDevicesToOu"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${CHROMEOSDEVICES_MOVEDEVICESTOOU_URL} =~ "pageToken=" ]]
            then                
                CHROMEOSDEVICES_MOVEDEVICESTOOU_URL+=\&pageToken=${1}
            else 
                CHROMEOSDEVICES_MOVEDEVICESTOOU_URL=`echo -n ${CHROMEOSDEVICES_MOVEDEVICESTOOU_URL} | sed "s/$(echo ${CHROMEOSDEVICES_MOVEDEVICESTOOU_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${CHROMEOSDEVICES_MOVEDEVICESTOOU_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${CHROMEOSDEVICES_MOVEDEVICESTOOU_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${CHROMEOSDEVICES_MOVEDEVICESTOOU_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${CHROMEOSDEVICES_MOVEDEVICESTOOU_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${CHROMEOSDEVICES_MOVEDEVICESTOOU_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


chromeosdevices_patch() {

    apiQueryRef=( `echo chromeosdevices patch` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams chromeosdevices_patch customerId "false"
            else
                getParams "chromeosdevices_patch" "customerId"
            fi
        else
            getParams "chromeosdevices_patch" "customerId"
        fi
    else
        genParamConfig
        getParams "chromeosdevices_patch" "customerId"
    fi

    #    declare -g "CHROMEOSDEVICES_PATCH_customerId=${customerId}"


    
    deviceIdMeta=( 
        'string'
        'Immutable ID of Chrome OS Device'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.deviceId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.deviceId)[] | .[]' ` ]]
            then
                checkParams chromeosdevices_patch deviceId "false"
            else
                getParams "chromeosdevices_patch" "deviceId"
            fi
        else
            getParams "chromeosdevices_patch" "deviceId"
        fi
    else
        genParamConfig
        getParams "chromeosdevices_patch" "deviceId"
    fi

    #    declare -g "CHROMEOSDEVICES_PATCH_deviceId=${deviceId}"


    

    CHROMEOSDEVICES_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/${deviceId}?key=${CLIENTID}"

    optParams=( projection )

    projectionMeta=(
        'string'
        'Restrict information returned to a set of selected fields.'
        '["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams chromeosdevices_patch ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    CHROMEOSDEVICES_PATCH_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "chromeosdevices_patch" "${option}" "true"
                                CHROMEOSDEVICES_PATCH_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "chromeosdevices_patch" "${option}" "true"
                            CHROMEOSDEVICES_PATCH_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "chromeosdevices_patch" "${option}" "true"
                        CHROMEOSDEVICES_PATCH_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.ChromeOsDevice.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "ChromeOsDevice"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${CHROMEOSDEVICES_PATCH_URL} =~ "pageToken=" ]]
            then                
                CHROMEOSDEVICES_PATCH_URL+=\&pageToken=${1}
            else 
                CHROMEOSDEVICES_PATCH_URL=`echo -n ${CHROMEOSDEVICES_PATCH_URL} | sed "s/$(echo ${CHROMEOSDEVICES_PATCH_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PATCH" "${CHROMEOSDEVICES_PATCH_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PATCH \
            ${CHROMEOSDEVICES_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PATCH \
            ${CHROMEOSDEVICES_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PATCH \"${CHROMEOSDEVICES_PATCH_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${CHROMEOSDEVICES_PATCH_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


chromeosdevices_update() {

    apiQueryRef=( `echo chromeosdevices update` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams chromeosdevices_update customerId "false"
            else
                getParams "chromeosdevices_update" "customerId"
            fi
        else
            getParams "chromeosdevices_update" "customerId"
        fi
    else
        genParamConfig
        getParams "chromeosdevices_update" "customerId"
    fi

    #    declare -g "CHROMEOSDEVICES_UPDATE_customerId=${customerId}"


    
    deviceIdMeta=( 
        'string'
        'Immutable ID of Chrome OS Device'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.deviceId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.deviceId)[] | .[]' ` ]]
            then
                checkParams chromeosdevices_update deviceId "false"
            else
                getParams "chromeosdevices_update" "deviceId"
            fi
        else
            getParams "chromeosdevices_update" "deviceId"
        fi
    else
        genParamConfig
        getParams "chromeosdevices_update" "deviceId"
    fi

    #    declare -g "CHROMEOSDEVICES_UPDATE_deviceId=${deviceId}"


    

    CHROMEOSDEVICES_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/${deviceId}?key=${CLIENTID}"

    optParams=( projection )

    projectionMeta=(
        'string'
        'Restrict information returned to a set of selected fields.'
        '["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams chromeosdevices_update ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    CHROMEOSDEVICES_UPDATE_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "chromeosdevices_update" "${option}" "true"
                                CHROMEOSDEVICES_UPDATE_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "chromeosdevices_update" "${option}" "true"
                            CHROMEOSDEVICES_UPDATE_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "chromeosdevices_update" "${option}" "true"
                        CHROMEOSDEVICES_UPDATE_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.ChromeOsDevice.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "ChromeOsDevice"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${CHROMEOSDEVICES_UPDATE_URL} =~ "pageToken=" ]]
            then                
                CHROMEOSDEVICES_UPDATE_URL+=\&pageToken=${1}
            else 
                CHROMEOSDEVICES_UPDATE_URL=`echo -n ${CHROMEOSDEVICES_UPDATE_URL} | sed "s/$(echo ${CHROMEOSDEVICES_UPDATE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PUT" "${CHROMEOSDEVICES_UPDATE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PUT \
            ${CHROMEOSDEVICES_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PUT \
            ${CHROMEOSDEVICES_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PUT \"${CHROMEOSDEVICES_UPDATE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${CHROMEOSDEVICES_UPDATE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


customers_get() {

    apiQueryRef=( `echo customers get` )


    customerKeyMeta=( 
        'string'
        'Id of the customer to be retrieved'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerKey)[] | .[]' ` ]]
            then
                checkParams customers_get customerKey "false"
            else
                getParams "customers_get" "customerKey"
            fi
        else
            getParams "customers_get" "customerKey"
        fi
    else
        genParamConfig
        getParams "customers_get" "customerKey"
    fi

    #    declare -g "CUSTOMERS_GET_customerKey=${customerKey}"


    

    CUSTOMERS_GET_URL="https://www.googleapis.com/admin/directory/v1/customers/${customerKey}?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${CUSTOMERS_GET_URL} =~ "pageToken=" ]]
            then                
                CUSTOMERS_GET_URL+=\&pageToken=${1}
            else 
                CUSTOMERS_GET_URL=`echo -n ${CUSTOMERS_GET_URL} | sed "s/$(echo ${CUSTOMERS_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${CUSTOMERS_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${CUSTOMERS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${CUSTOMERS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${CUSTOMERS_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${CUSTOMERS_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


customers_patch() {

    apiQueryRef=( `echo customers patch` )


    customerKeyMeta=( 
        'string'
        'Id of the customer to be updated'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerKey)[] | .[]' ` ]]
            then
                checkParams customers_patch customerKey "false"
            else
                getParams "customers_patch" "customerKey"
            fi
        else
            getParams "customers_patch" "customerKey"
        fi
    else
        genParamConfig
        getParams "customers_patch" "customerKey"
    fi

    #    declare -g "CUSTOMERS_PATCH_customerKey=${customerKey}"


    

    CUSTOMERS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customers/${customerKey}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Customer.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Customer"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${CUSTOMERS_PATCH_URL} =~ "pageToken=" ]]
            then                
                CUSTOMERS_PATCH_URL+=\&pageToken=${1}
            else 
                CUSTOMERS_PATCH_URL=`echo -n ${CUSTOMERS_PATCH_URL} | sed "s/$(echo ${CUSTOMERS_PATCH_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PATCH" "${CUSTOMERS_PATCH_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PATCH \
            ${CUSTOMERS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PATCH \
            ${CUSTOMERS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PATCH \"${CUSTOMERS_PATCH_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${CUSTOMERS_PATCH_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


customers_update() {

    apiQueryRef=( `echo customers update` )


    customerKeyMeta=( 
        'string'
        'Id of the customer to be updated'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerKey)[] | .[]' ` ]]
            then
                checkParams customers_update customerKey "false"
            else
                getParams "customers_update" "customerKey"
            fi
        else
            getParams "customers_update" "customerKey"
        fi
    else
        genParamConfig
        getParams "customers_update" "customerKey"
    fi

    #    declare -g "CUSTOMERS_UPDATE_customerKey=${customerKey}"


    

    CUSTOMERS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customers/${customerKey}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Customer.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Customer"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${CUSTOMERS_UPDATE_URL} =~ "pageToken=" ]]
            then                
                CUSTOMERS_UPDATE_URL+=\&pageToken=${1}
            else 
                CUSTOMERS_UPDATE_URL=`echo -n ${CUSTOMERS_UPDATE_URL} | sed "s/$(echo ${CUSTOMERS_UPDATE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PUT" "${CUSTOMERS_UPDATE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PUT \
            ${CUSTOMERS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PUT \
            ${CUSTOMERS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PUT \"${CUSTOMERS_UPDATE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${CUSTOMERS_UPDATE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


domainAliases_delete() {

    apiQueryRef=( `echo domainAliases delete` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams domainAliases_delete customer "false"
            else
                getParams "domainAliases_delete" "customer"
            fi
        else
            getParams "domainAliases_delete" "customer"
        fi
    else
        genParamConfig
        getParams "domainAliases_delete" "customer"
    fi

    #    declare -g "DOMAINALIASES_DELETE_customer=${customer}"


    
    domainAliasNameMeta=( 
        'string'
        'Name of domain alias to be retrieved.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.domainAliasName)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.domainAliasName)[] | .[]' ` ]]
            then
                checkParams domainAliases_delete domainAliasName "false"
            else
                getParams "domainAliases_delete" "domainAliasName"
            fi
        else
            getParams "domainAliases_delete" "domainAliasName"
        fi
    else
        genParamConfig
        getParams "domainAliases_delete" "domainAliasName"
    fi

    #    declare -g "DOMAINALIASES_DELETE_domainAliasName=${domainAliasName}"


    

    DOMAINALIASES_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domainaliases/${domainAliasName}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${DOMAINALIASES_DELETE_URL} =~ "pageToken=" ]]
            then                
                DOMAINALIASES_DELETE_URL+=\&pageToken=${1}
            else 
                DOMAINALIASES_DELETE_URL=`echo -n ${DOMAINALIASES_DELETE_URL} | sed "s/$(echo ${DOMAINALIASES_DELETE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "DELETE" "${DOMAINALIASES_DELETE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request DELETE \
            ${DOMAINALIASES_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request DELETE \
            ${DOMAINALIASES_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request DELETE \"${DOMAINALIASES_DELETE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${DOMAINALIASES_DELETE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


domainAliases_get() {

    apiQueryRef=( `echo domainAliases get` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams domainAliases_get customer "false"
            else
                getParams "domainAliases_get" "customer"
            fi
        else
            getParams "domainAliases_get" "customer"
        fi
    else
        genParamConfig
        getParams "domainAliases_get" "customer"
    fi

    #    declare -g "DOMAINALIASES_GET_customer=${customer}"


    
    domainAliasNameMeta=( 
        'string'
        'Name of domain alias to be retrieved.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.domainAliasName)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.domainAliasName)[] | .[]' ` ]]
            then
                checkParams domainAliases_get domainAliasName "false"
            else
                getParams "domainAliases_get" "domainAliasName"
            fi
        else
            getParams "domainAliases_get" "domainAliasName"
        fi
    else
        genParamConfig
        getParams "domainAliases_get" "domainAliasName"
    fi

    #    declare -g "DOMAINALIASES_GET_domainAliasName=${domainAliasName}"


    

    DOMAINALIASES_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domainaliases/${domainAliasName}?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${DOMAINALIASES_GET_URL} =~ "pageToken=" ]]
            then                
                DOMAINALIASES_GET_URL+=\&pageToken=${1}
            else 
                DOMAINALIASES_GET_URL=`echo -n ${DOMAINALIASES_GET_URL} | sed "s/$(echo ${DOMAINALIASES_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${DOMAINALIASES_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${DOMAINALIASES_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${DOMAINALIASES_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${DOMAINALIASES_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${DOMAINALIASES_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


domainAliases_insert() {

    apiQueryRef=( `echo domainAliases insert` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams domainAliases_insert customer "false"
            else
                getParams "domainAliases_insert" "customer"
            fi
        else
            getParams "domainAliases_insert" "customer"
        fi
    else
        genParamConfig
        getParams "domainAliases_insert" "customer"
    fi

    #    declare -g "DOMAINALIASES_INSERT_customer=${customer}"


    

    DOMAINALIASES_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domainaliases?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.DomainAlias.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "DomainAlias"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${DOMAINALIASES_INSERT_URL} =~ "pageToken=" ]]
            then                
                DOMAINALIASES_INSERT_URL+=\&pageToken=${1}
            else 
                DOMAINALIASES_INSERT_URL=`echo -n ${DOMAINALIASES_INSERT_URL} | sed "s/$(echo ${DOMAINALIASES_INSERT_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${DOMAINALIASES_INSERT_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${DOMAINALIASES_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${DOMAINALIASES_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${DOMAINALIASES_INSERT_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${DOMAINALIASES_INSERT_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


domainAliases_list() {

    apiQueryRef=( `echo domainAliases list` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams domainAliases_list customer "false"
            else
                getParams "domainAliases_list" "customer"
            fi
        else
            getParams "domainAliases_list" "customer"
        fi
    else
        genParamConfig
        getParams "domainAliases_list" "customer"
    fi

    #    declare -g "DOMAINALIASES_LIST_customer=${customer}"


    

    DOMAINALIASES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domainaliases?key=${CLIENTID}"

    inpParams=( parentDomainName )

    parentDomainNameMeta=(
        'string'
        'Name of the parent domain for which domain aliases are to be fetched.'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams domainAliases_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    DOMAINALIASES_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "domainAliases_list" "${option}" "true"
                                DOMAINALIASES_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "domainAliases_list" "${option}" "true"
                            DOMAINALIASES_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "domainAliases_list" "${option}" "true"
                        DOMAINALIASES_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${DOMAINALIASES_LIST_URL} =~ "pageToken=" ]]
            then                
                DOMAINALIASES_LIST_URL+=\&pageToken=${1}
            else 
                DOMAINALIASES_LIST_URL=`echo -n ${DOMAINALIASES_LIST_URL} | sed "s/$(echo ${DOMAINALIASES_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${DOMAINALIASES_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${DOMAINALIASES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${DOMAINALIASES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${DOMAINALIASES_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${DOMAINALIASES_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


domains_delete() {

    apiQueryRef=( `echo domains delete` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams domains_delete customer "false"
            else
                getParams "domains_delete" "customer"
            fi
        else
            getParams "domains_delete" "customer"
        fi
    else
        genParamConfig
        getParams "domains_delete" "customer"
    fi

    #    declare -g "DOMAINS_DELETE_customer=${customer}"


    
    domainNameMeta=( 
        'string'
        'Name of domain to be deleted'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.domainName)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.domainName)[] | .[]' ` ]]
            then
                checkParams domains_delete domainName "false"
            else
                getParams "domains_delete" "domainName"
            fi
        else
            getParams "domains_delete" "domainName"
        fi
    else
        genParamConfig
        getParams "domains_delete" "domainName"
    fi

    #    declare -g "DOMAINS_DELETE_domainName=${domainName}"


    

    DOMAINS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domains/${domainName}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${DOMAINS_DELETE_URL} =~ "pageToken=" ]]
            then                
                DOMAINS_DELETE_URL+=\&pageToken=${1}
            else 
                DOMAINS_DELETE_URL=`echo -n ${DOMAINS_DELETE_URL} | sed "s/$(echo ${DOMAINS_DELETE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "DELETE" "${DOMAINS_DELETE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request DELETE \
            ${DOMAINS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request DELETE \
            ${DOMAINS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request DELETE \"${DOMAINS_DELETE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${DOMAINS_DELETE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


domains_get() {

    apiQueryRef=( `echo domains get` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams domains_get customer "false"
            else
                getParams "domains_get" "customer"
            fi
        else
            getParams "domains_get" "customer"
        fi
    else
        genParamConfig
        getParams "domains_get" "customer"
    fi

    #    declare -g "DOMAINS_GET_customer=${customer}"


    
    domainNameMeta=( 
        'string'
        'Name of domain to be retrieved'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.domainName)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.domainName)[] | .[]' ` ]]
            then
                checkParams domains_get domainName "false"
            else
                getParams "domains_get" "domainName"
            fi
        else
            getParams "domains_get" "domainName"
        fi
    else
        genParamConfig
        getParams "domains_get" "domainName"
    fi

    #    declare -g "DOMAINS_GET_domainName=${domainName}"


    

    DOMAINS_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domains/${domainName}?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${DOMAINS_GET_URL} =~ "pageToken=" ]]
            then                
                DOMAINS_GET_URL+=\&pageToken=${1}
            else 
                DOMAINS_GET_URL=`echo -n ${DOMAINS_GET_URL} | sed "s/$(echo ${DOMAINS_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${DOMAINS_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${DOMAINS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${DOMAINS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${DOMAINS_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${DOMAINS_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


domains_insert() {

    apiQueryRef=( `echo domains insert` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams domains_insert customer "false"
            else
                getParams "domains_insert" "customer"
            fi
        else
            getParams "domains_insert" "customer"
        fi
    else
        genParamConfig
        getParams "domains_insert" "customer"
    fi

    #    declare -g "DOMAINS_INSERT_customer=${customer}"


    

    DOMAINS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domains?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Domains.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Domains"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${DOMAINS_INSERT_URL} =~ "pageToken=" ]]
            then                
                DOMAINS_INSERT_URL+=\&pageToken=${1}
            else 
                DOMAINS_INSERT_URL=`echo -n ${DOMAINS_INSERT_URL} | sed "s/$(echo ${DOMAINS_INSERT_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${DOMAINS_INSERT_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${DOMAINS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${DOMAINS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${DOMAINS_INSERT_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${DOMAINS_INSERT_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


domains_list() {

    apiQueryRef=( `echo domains list` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams domains_list customer "false"
            else
                getParams "domains_list" "customer"
            fi
        else
            getParams "domains_list" "customer"
        fi
    else
        genParamConfig
        getParams "domains_list" "customer"
    fi

    #    declare -g "DOMAINS_LIST_customer=${customer}"


    

    DOMAINS_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domains?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${DOMAINS_LIST_URL} =~ "pageToken=" ]]
            then                
                DOMAINS_LIST_URL+=\&pageToken=${1}
            else 
                DOMAINS_LIST_URL=`echo -n ${DOMAINS_LIST_URL} | sed "s/$(echo ${DOMAINS_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${DOMAINS_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${DOMAINS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${DOMAINS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${DOMAINS_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${DOMAINS_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


groups_delete() {

    apiQueryRef=( `echo groups delete` )


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)[] | .[]' ` ]]
            then
                checkParams groups_delete groupKey "false"
            else
                getParams "groups_delete" "groupKey"
            fi
        else
            getParams "groups_delete" "groupKey"
        fi
    else
        genParamConfig
        getParams "groups_delete" "groupKey"
    fi

    #    declare -g "GROUPS_DELETE_groupKey=${groupKey}"


    

    GROUPS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${GROUPS_DELETE_URL} =~ "pageToken=" ]]
            then                
                GROUPS_DELETE_URL+=\&pageToken=${1}
            else 
                GROUPS_DELETE_URL=`echo -n ${GROUPS_DELETE_URL} | sed "s/$(echo ${GROUPS_DELETE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "DELETE" "${GROUPS_DELETE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request DELETE \
            ${GROUPS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request DELETE \
            ${GROUPS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request DELETE \"${GROUPS_DELETE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${GROUPS_DELETE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


groups_get() {

    apiQueryRef=( `echo groups get` )


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)[] | .[]' ` ]]
            then
                checkParams groups_get groupKey "false"
            else
                getParams "groups_get" "groupKey"
            fi
        else
            getParams "groups_get" "groupKey"
        fi
    else
        genParamConfig
        getParams "groups_get" "groupKey"
    fi

    #    declare -g "GROUPS_GET_groupKey=${groupKey}"


    

    GROUPS_GET_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${GROUPS_GET_URL} =~ "pageToken=" ]]
            then                
                GROUPS_GET_URL+=\&pageToken=${1}
            else 
                GROUPS_GET_URL=`echo -n ${GROUPS_GET_URL} | sed "s/$(echo ${GROUPS_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${GROUPS_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${GROUPS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${GROUPS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${GROUPS_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${GROUPS_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


groups_insert() {

    apiQueryRef=( `echo groups insert` )



    GROUPS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/groups?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Group.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Group"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${GROUPS_INSERT_URL} =~ "pageToken=" ]]
            then                
                GROUPS_INSERT_URL+=\&pageToken=${1}
            else 
                GROUPS_INSERT_URL=`echo -n ${GROUPS_INSERT_URL} | sed "s/$(echo ${GROUPS_INSERT_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${GROUPS_INSERT_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${GROUPS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${GROUPS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${GROUPS_INSERT_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${GROUPS_INSERT_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


groups_list() {

    apiQueryRef=( `echo groups list` )



    GROUPS_LIST_URL="https://www.googleapis.com/admin/directory/v1/groups?key=${CLIENTID}"

    optParams=( orderBy sortOrder )

    orderByMeta=(
        'string'
        'Column to use for sorting results'
        '["orderByUndefined","email"]'
    )

    sortOrderMeta=(
        'string'
        'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
        '["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams groups_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    GROUPS_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "groups_list" "${option}" "true"
                                GROUPS_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "groups_list" "${option}" "true"
                            GROUPS_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "groups_list" "${option}" "true"
                        GROUPS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi

    inpParams=( customer domain maxResults pageToken query userKey )

    customerMeta=(
        'string'
        'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )

    domainMeta=(
        'string'
        'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return. Max allowed value is 200.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify next page in the list'
    )

    queryMeta=(
        'string'
        'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )

    userKeyMeta=(
        'string'
        'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams groups_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    GROUPS_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "groups_list" "${option}" "true"
                                GROUPS_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "groups_list" "${option}" "true"
                            GROUPS_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "groups_list" "${option}" "true"
                        GROUPS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${GROUPS_LIST_URL} =~ "pageToken=" ]]
            then                
                GROUPS_LIST_URL+=\&pageToken=${1}
            else 
                GROUPS_LIST_URL=`echo -n ${GROUPS_LIST_URL} | sed "s/$(echo ${GROUPS_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${GROUPS_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${GROUPS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${GROUPS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${GROUPS_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${GROUPS_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


groups_patch() {

    apiQueryRef=( `echo groups patch` )


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group. If ID, it should match with id of group object'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)[] | .[]' ` ]]
            then
                checkParams groups_patch groupKey "false"
            else
                getParams "groups_patch" "groupKey"
            fi
        else
            getParams "groups_patch" "groupKey"
        fi
    else
        genParamConfig
        getParams "groups_patch" "groupKey"
    fi

    #    declare -g "GROUPS_PATCH_groupKey=${groupKey}"


    

    GROUPS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Group.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Group"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${GROUPS_PATCH_URL} =~ "pageToken=" ]]
            then                
                GROUPS_PATCH_URL+=\&pageToken=${1}
            else 
                GROUPS_PATCH_URL=`echo -n ${GROUPS_PATCH_URL} | sed "s/$(echo ${GROUPS_PATCH_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PATCH" "${GROUPS_PATCH_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PATCH \
            ${GROUPS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PATCH \
            ${GROUPS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PATCH \"${GROUPS_PATCH_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${GROUPS_PATCH_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


groups_update() {

    apiQueryRef=( `echo groups update` )


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group. If ID, it should match with id of group object'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)[] | .[]' ` ]]
            then
                checkParams groups_update groupKey "false"
            else
                getParams "groups_update" "groupKey"
            fi
        else
            getParams "groups_update" "groupKey"
        fi
    else
        genParamConfig
        getParams "groups_update" "groupKey"
    fi

    #    declare -g "GROUPS_UPDATE_groupKey=${groupKey}"


    

    GROUPS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Group.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Group"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${GROUPS_UPDATE_URL} =~ "pageToken=" ]]
            then                
                GROUPS_UPDATE_URL+=\&pageToken=${1}
            else 
                GROUPS_UPDATE_URL=`echo -n ${GROUPS_UPDATE_URL} | sed "s/$(echo ${GROUPS_UPDATE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PUT" "${GROUPS_UPDATE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PUT \
            ${GROUPS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PUT \
            ${GROUPS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PUT \"${GROUPS_UPDATE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${GROUPS_UPDATE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


members_delete() {

    apiQueryRef=( `echo members delete` )


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)[] | .[]' ` ]]
            then
                checkParams members_delete groupKey "false"
            else
                getParams "members_delete" "groupKey"
            fi
        else
            getParams "members_delete" "groupKey"
        fi
    else
        genParamConfig
        getParams "members_delete" "groupKey"
    fi

    #    declare -g "MEMBERS_DELETE_groupKey=${groupKey}"


    
    memberKeyMeta=( 
        'string'
        'Email or immutable ID of the member'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.memberKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.memberKey)[] | .[]' ` ]]
            then
                checkParams members_delete memberKey "false"
            else
                getParams "members_delete" "memberKey"
            fi
        else
            getParams "members_delete" "memberKey"
        fi
    else
        genParamConfig
        getParams "members_delete" "memberKey"
    fi

    #    declare -g "MEMBERS_DELETE_memberKey=${memberKey}"


    

    MEMBERS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members/${memberKey}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${MEMBERS_DELETE_URL} =~ "pageToken=" ]]
            then                
                MEMBERS_DELETE_URL+=\&pageToken=${1}
            else 
                MEMBERS_DELETE_URL=`echo -n ${MEMBERS_DELETE_URL} | sed "s/$(echo ${MEMBERS_DELETE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "DELETE" "${MEMBERS_DELETE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request DELETE \
            ${MEMBERS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request DELETE \
            ${MEMBERS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request DELETE \"${MEMBERS_DELETE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${MEMBERS_DELETE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


members_get() {

    apiQueryRef=( `echo members get` )


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)[] | .[]' ` ]]
            then
                checkParams members_get groupKey "false"
            else
                getParams "members_get" "groupKey"
            fi
        else
            getParams "members_get" "groupKey"
        fi
    else
        genParamConfig
        getParams "members_get" "groupKey"
    fi

    #    declare -g "MEMBERS_GET_groupKey=${groupKey}"


    
    memberKeyMeta=( 
        'string'
        'Email or immutable ID of the member'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.memberKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.memberKey)[] | .[]' ` ]]
            then
                checkParams members_get memberKey "false"
            else
                getParams "members_get" "memberKey"
            fi
        else
            getParams "members_get" "memberKey"
        fi
    else
        genParamConfig
        getParams "members_get" "memberKey"
    fi

    #    declare -g "MEMBERS_GET_memberKey=${memberKey}"


    

    MEMBERS_GET_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members/${memberKey}?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${MEMBERS_GET_URL} =~ "pageToken=" ]]
            then                
                MEMBERS_GET_URL+=\&pageToken=${1}
            else 
                MEMBERS_GET_URL=`echo -n ${MEMBERS_GET_URL} | sed "s/$(echo ${MEMBERS_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${MEMBERS_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${MEMBERS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${MEMBERS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${MEMBERS_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${MEMBERS_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


members_hasMember() {

    apiQueryRef=( `echo members hasMember` )


    groupKeyMeta=( 
        'string'
        'Identifies the group in the API request. The value can be the group'\''s email address, group alias, or the unique group ID.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)[] | .[]' ` ]]
            then
                checkParams members_hasMember groupKey "false"
            else
                getParams "members_hasMember" "groupKey"
            fi
        else
            getParams "members_hasMember" "groupKey"
        fi
    else
        genParamConfig
        getParams "members_hasMember" "groupKey"
    fi

    #    declare -g "MEMBERS_HASMEMBER_groupKey=${groupKey}"


    
    memberKeyMeta=( 
        'string'
        'Identifies the user member in the API request. The value can be the user'\''s primary email address, alias, or unique ID.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.memberKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.memberKey)[] | .[]' ` ]]
            then
                checkParams members_hasMember memberKey "false"
            else
                getParams "members_hasMember" "memberKey"
            fi
        else
            getParams "members_hasMember" "memberKey"
        fi
    else
        genParamConfig
        getParams "members_hasMember" "memberKey"
    fi

    #    declare -g "MEMBERS_HASMEMBER_memberKey=${memberKey}"


    

    MEMBERS_HASMEMBER_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/hasMember/${memberKey}?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${MEMBERS_HASMEMBER_URL} =~ "pageToken=" ]]
            then                
                MEMBERS_HASMEMBER_URL+=\&pageToken=${1}
            else 
                MEMBERS_HASMEMBER_URL=`echo -n ${MEMBERS_HASMEMBER_URL} | sed "s/$(echo ${MEMBERS_HASMEMBER_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${MEMBERS_HASMEMBER_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${MEMBERS_HASMEMBER_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${MEMBERS_HASMEMBER_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${MEMBERS_HASMEMBER_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${MEMBERS_HASMEMBER_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


members_insert() {

    apiQueryRef=( `echo members insert` )


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)[] | .[]' ` ]]
            then
                checkParams members_insert groupKey "false"
            else
                getParams "members_insert" "groupKey"
            fi
        else
            getParams "members_insert" "groupKey"
        fi
    else
        genParamConfig
        getParams "members_insert" "groupKey"
    fi

    #    declare -g "MEMBERS_INSERT_groupKey=${groupKey}"


    

    MEMBERS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Member.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Member"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${MEMBERS_INSERT_URL} =~ "pageToken=" ]]
            then                
                MEMBERS_INSERT_URL+=\&pageToken=${1}
            else 
                MEMBERS_INSERT_URL=`echo -n ${MEMBERS_INSERT_URL} | sed "s/$(echo ${MEMBERS_INSERT_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${MEMBERS_INSERT_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${MEMBERS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${MEMBERS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${MEMBERS_INSERT_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${MEMBERS_INSERT_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


members_list() {

    apiQueryRef=( `echo members list` )


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)[] | .[]' ` ]]
            then
                checkParams members_list groupKey "false"
            else
                getParams "members_list" "groupKey"
            fi
        else
            getParams "members_list" "groupKey"
        fi
    else
        genParamConfig
        getParams "members_list" "groupKey"
    fi

    #    declare -g "MEMBERS_LIST_groupKey=${groupKey}"


    

    MEMBERS_LIST_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members?key=${CLIENTID}"

    inpParams=( includeDerivedMembership maxResults pageToken roles )

    includeDerivedMembershipMeta=(
        'boolean'
        'Whether to list indirect memberships. Default: false.'
    )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return. Max allowed value is 200.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify next page in the list'
    )

    rolesMeta=(
        'string'
        'Comma separated role values to filter list results on.'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams members_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    MEMBERS_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "members_list" "${option}" "true"
                                MEMBERS_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "members_list" "${option}" "true"
                            MEMBERS_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "members_list" "${option}" "true"
                        MEMBERS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${MEMBERS_LIST_URL} =~ "pageToken=" ]]
            then                
                MEMBERS_LIST_URL+=\&pageToken=${1}
            else 
                MEMBERS_LIST_URL=`echo -n ${MEMBERS_LIST_URL} | sed "s/$(echo ${MEMBERS_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${MEMBERS_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${MEMBERS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${MEMBERS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${MEMBERS_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${MEMBERS_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


members_patch() {

    apiQueryRef=( `echo members patch` )


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group. If ID, it should match with id of group object'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)[] | .[]' ` ]]
            then
                checkParams members_patch groupKey "false"
            else
                getParams "members_patch" "groupKey"
            fi
        else
            getParams "members_patch" "groupKey"
        fi
    else
        genParamConfig
        getParams "members_patch" "groupKey"
    fi

    #    declare -g "MEMBERS_PATCH_groupKey=${groupKey}"


    
    memberKeyMeta=( 
        'string'
        'Email or immutable ID of the user. If ID, it should match with id of member object'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.memberKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.memberKey)[] | .[]' ` ]]
            then
                checkParams members_patch memberKey "false"
            else
                getParams "members_patch" "memberKey"
            fi
        else
            getParams "members_patch" "memberKey"
        fi
    else
        genParamConfig
        getParams "members_patch" "memberKey"
    fi

    #    declare -g "MEMBERS_PATCH_memberKey=${memberKey}"


    

    MEMBERS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members/${memberKey}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Member.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Member"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${MEMBERS_PATCH_URL} =~ "pageToken=" ]]
            then                
                MEMBERS_PATCH_URL+=\&pageToken=${1}
            else 
                MEMBERS_PATCH_URL=`echo -n ${MEMBERS_PATCH_URL} | sed "s/$(echo ${MEMBERS_PATCH_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PATCH" "${MEMBERS_PATCH_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PATCH \
            ${MEMBERS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PATCH \
            ${MEMBERS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PATCH \"${MEMBERS_PATCH_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${MEMBERS_PATCH_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


members_update() {

    apiQueryRef=( `echo members update` )


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group. If ID, it should match with id of group object'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.groupKey)[] | .[]' ` ]]
            then
                checkParams members_update groupKey "false"
            else
                getParams "members_update" "groupKey"
            fi
        else
            getParams "members_update" "groupKey"
        fi
    else
        genParamConfig
        getParams "members_update" "groupKey"
    fi

    #    declare -g "MEMBERS_UPDATE_groupKey=${groupKey}"


    
    memberKeyMeta=( 
        'string'
        'Email or immutable ID of the user. If ID, it should match with id of member object'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.memberKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.memberKey)[] | .[]' ` ]]
            then
                checkParams members_update memberKey "false"
            else
                getParams "members_update" "memberKey"
            fi
        else
            getParams "members_update" "memberKey"
        fi
    else
        genParamConfig
        getParams "members_update" "memberKey"
    fi

    #    declare -g "MEMBERS_UPDATE_memberKey=${memberKey}"


    

    MEMBERS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members/${memberKey}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Member.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Member"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${MEMBERS_UPDATE_URL} =~ "pageToken=" ]]
            then                
                MEMBERS_UPDATE_URL+=\&pageToken=${1}
            else 
                MEMBERS_UPDATE_URL=`echo -n ${MEMBERS_UPDATE_URL} | sed "s/$(echo ${MEMBERS_UPDATE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PUT" "${MEMBERS_UPDATE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PUT \
            ${MEMBERS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PUT \
            ${MEMBERS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PUT \"${MEMBERS_UPDATE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${MEMBERS_UPDATE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


mobiledevices_action() {

    apiQueryRef=( `echo mobiledevices action` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams mobiledevices_action customerId "false"
            else
                getParams "mobiledevices_action" "customerId"
            fi
        else
            getParams "mobiledevices_action" "customerId"
        fi
    else
        genParamConfig
        getParams "mobiledevices_action" "customerId"
    fi

    #    declare -g "MOBILEDEVICES_ACTION_customerId=${customerId}"


    
    resourceIdMeta=( 
        'string'
        'Immutable ID of Mobile Device'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.resourceId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.resourceId)[] | .[]' ` ]]
            then
                checkParams mobiledevices_action resourceId "false"
            else
                getParams "mobiledevices_action" "resourceId"
            fi
        else
            getParams "mobiledevices_action" "resourceId"
        fi
    else
        genParamConfig
        getParams "mobiledevices_action" "resourceId"
    fi

    #    declare -g "MOBILEDEVICES_ACTION_resourceId=${resourceId}"


    

    MOBILEDEVICES_ACTION_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/mobile/${resourceId}/action?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.MobileDeviceAction.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "MobileDeviceAction"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${MOBILEDEVICES_ACTION_URL} =~ "pageToken=" ]]
            then                
                MOBILEDEVICES_ACTION_URL+=\&pageToken=${1}
            else 
                MOBILEDEVICES_ACTION_URL=`echo -n ${MOBILEDEVICES_ACTION_URL} | sed "s/$(echo ${MOBILEDEVICES_ACTION_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${MOBILEDEVICES_ACTION_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${MOBILEDEVICES_ACTION_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${MOBILEDEVICES_ACTION_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${MOBILEDEVICES_ACTION_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${MOBILEDEVICES_ACTION_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


mobiledevices_delete() {

    apiQueryRef=( `echo mobiledevices delete` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams mobiledevices_delete customerId "false"
            else
                getParams "mobiledevices_delete" "customerId"
            fi
        else
            getParams "mobiledevices_delete" "customerId"
        fi
    else
        genParamConfig
        getParams "mobiledevices_delete" "customerId"
    fi

    #    declare -g "MOBILEDEVICES_DELETE_customerId=${customerId}"


    
    resourceIdMeta=( 
        'string'
        'Immutable ID of Mobile Device'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.resourceId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.resourceId)[] | .[]' ` ]]
            then
                checkParams mobiledevices_delete resourceId "false"
            else
                getParams "mobiledevices_delete" "resourceId"
            fi
        else
            getParams "mobiledevices_delete" "resourceId"
        fi
    else
        genParamConfig
        getParams "mobiledevices_delete" "resourceId"
    fi

    #    declare -g "MOBILEDEVICES_DELETE_resourceId=${resourceId}"


    

    MOBILEDEVICES_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/mobile/${resourceId}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${MOBILEDEVICES_DELETE_URL} =~ "pageToken=" ]]
            then                
                MOBILEDEVICES_DELETE_URL+=\&pageToken=${1}
            else 
                MOBILEDEVICES_DELETE_URL=`echo -n ${MOBILEDEVICES_DELETE_URL} | sed "s/$(echo ${MOBILEDEVICES_DELETE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "DELETE" "${MOBILEDEVICES_DELETE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request DELETE \
            ${MOBILEDEVICES_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request DELETE \
            ${MOBILEDEVICES_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request DELETE \"${MOBILEDEVICES_DELETE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${MOBILEDEVICES_DELETE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


mobiledevices_get() {

    apiQueryRef=( `echo mobiledevices get` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams mobiledevices_get customerId "false"
            else
                getParams "mobiledevices_get" "customerId"
            fi
        else
            getParams "mobiledevices_get" "customerId"
        fi
    else
        genParamConfig
        getParams "mobiledevices_get" "customerId"
    fi

    #    declare -g "MOBILEDEVICES_GET_customerId=${customerId}"


    
    resourceIdMeta=( 
        'string'
        'Immutable ID of Mobile Device'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.resourceId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.resourceId)[] | .[]' ` ]]
            then
                checkParams mobiledevices_get resourceId "false"
            else
                getParams "mobiledevices_get" "resourceId"
            fi
        else
            getParams "mobiledevices_get" "resourceId"
        fi
    else
        genParamConfig
        getParams "mobiledevices_get" "resourceId"
    fi

    #    declare -g "MOBILEDEVICES_GET_resourceId=${resourceId}"


    

    MOBILEDEVICES_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/mobile/${resourceId}?key=${CLIENTID}"

    optParams=( projection )

    projectionMeta=(
        'string'
        'Restrict information returned to a set of selected fields.'
        '["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams mobiledevices_get ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    MOBILEDEVICES_GET_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "mobiledevices_get" "${option}" "true"
                                MOBILEDEVICES_GET_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "mobiledevices_get" "${option}" "true"
                            MOBILEDEVICES_GET_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "mobiledevices_get" "${option}" "true"
                        MOBILEDEVICES_GET_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${MOBILEDEVICES_GET_URL} =~ "pageToken=" ]]
            then                
                MOBILEDEVICES_GET_URL+=\&pageToken=${1}
            else 
                MOBILEDEVICES_GET_URL=`echo -n ${MOBILEDEVICES_GET_URL} | sed "s/$(echo ${MOBILEDEVICES_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${MOBILEDEVICES_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${MOBILEDEVICES_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${MOBILEDEVICES_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${MOBILEDEVICES_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${MOBILEDEVICES_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


mobiledevices_list() {

    apiQueryRef=( `echo mobiledevices list` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams mobiledevices_list customerId "false"
            else
                getParams "mobiledevices_list" "customerId"
            fi
        else
            getParams "mobiledevices_list" "customerId"
        fi
    else
        genParamConfig
        getParams "mobiledevices_list" "customerId"
    fi

    #    declare -g "MOBILEDEVICES_LIST_customerId=${customerId}"


    

    MOBILEDEVICES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/mobile?key=${CLIENTID}"

    optParams=( orderBy projection sortOrder )

    orderByMeta=(
        'string'
        'Column to use for sorting results'
        '["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )

    projectionMeta=(
        'string'
        'Restrict information returned to a set of selected fields.'
        '["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    sortOrderMeta=(
        'string'
        'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
        '["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams mobiledevices_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    MOBILEDEVICES_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "mobiledevices_list" "${option}" "true"
                                MOBILEDEVICES_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "mobiledevices_list" "${option}" "true"
                            MOBILEDEVICES_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "mobiledevices_list" "${option}" "true"
                        MOBILEDEVICES_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi

    inpParams=( maxResults pageToken query )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return. Max allowed value is 100.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify next page in the list'
    )

    queryMeta=(
        'string'
        'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams mobiledevices_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    MOBILEDEVICES_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "mobiledevices_list" "${option}" "true"
                                MOBILEDEVICES_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "mobiledevices_list" "${option}" "true"
                            MOBILEDEVICES_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "mobiledevices_list" "${option}" "true"
                        MOBILEDEVICES_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${MOBILEDEVICES_LIST_URL} =~ "pageToken=" ]]
            then                
                MOBILEDEVICES_LIST_URL+=\&pageToken=${1}
            else 
                MOBILEDEVICES_LIST_URL=`echo -n ${MOBILEDEVICES_LIST_URL} | sed "s/$(echo ${MOBILEDEVICES_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${MOBILEDEVICES_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${MOBILEDEVICES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${MOBILEDEVICES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${MOBILEDEVICES_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${MOBILEDEVICES_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


orgunits_delete() {

    apiQueryRef=( `echo orgunits delete` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams orgunits_delete customerId "false"
            else
                getParams "orgunits_delete" "customerId"
            fi
        else
            getParams "orgunits_delete" "customerId"
        fi
    else
        genParamConfig
        getParams "orgunits_delete" "customerId"
    fi

    #    declare -g "ORGUNITS_DELETE_customerId=${customerId}"


    
    orgUnitPathMeta=( 
        'string'
        'Full path of the organizational unit or its ID'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.orgUnitPath)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.orgUnitPath)[] | .[]' ` ]]
            then
                checkParams orgunits_delete orgUnitPath "false"
            else
                getParams "orgunits_delete" "orgUnitPath"
            fi
        else
            getParams "orgunits_delete" "orgUnitPath"
        fi
    else
        genParamConfig
        getParams "orgunits_delete" "orgUnitPath"
    fi

    #    declare -g "ORGUNITS_DELETE_orgUnitPath=${orgUnitPath}"


    

    ORGUNITS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits/${orgunitsId}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ORGUNITS_DELETE_URL} =~ "pageToken=" ]]
            then                
                ORGUNITS_DELETE_URL+=\&pageToken=${1}
            else 
                ORGUNITS_DELETE_URL=`echo -n ${ORGUNITS_DELETE_URL} | sed "s/$(echo ${ORGUNITS_DELETE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "DELETE" "${ORGUNITS_DELETE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request DELETE \
            ${ORGUNITS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request DELETE \
            ${ORGUNITS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request DELETE \"${ORGUNITS_DELETE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${ORGUNITS_DELETE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


orgunits_get() {

    apiQueryRef=( `echo orgunits get` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams orgunits_get customerId "false"
            else
                getParams "orgunits_get" "customerId"
            fi
        else
            getParams "orgunits_get" "customerId"
        fi
    else
        genParamConfig
        getParams "orgunits_get" "customerId"
    fi

    #    declare -g "ORGUNITS_GET_customerId=${customerId}"


    
    orgUnitPathMeta=( 
        'string'
        'Full path of the organizational unit or its ID'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.orgUnitPath)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.orgUnitPath)[] | .[]' ` ]]
            then
                checkParams orgunits_get orgUnitPath "false"
            else
                getParams "orgunits_get" "orgUnitPath"
            fi
        else
            getParams "orgunits_get" "orgUnitPath"
        fi
    else
        genParamConfig
        getParams "orgunits_get" "orgUnitPath"
    fi

    #    declare -g "ORGUNITS_GET_orgUnitPath=${orgUnitPath}"


    

    ORGUNITS_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits/${orgunitsId}?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ORGUNITS_GET_URL} =~ "pageToken=" ]]
            then                
                ORGUNITS_GET_URL+=\&pageToken=${1}
            else 
                ORGUNITS_GET_URL=`echo -n ${ORGUNITS_GET_URL} | sed "s/$(echo ${ORGUNITS_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${ORGUNITS_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${ORGUNITS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${ORGUNITS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${ORGUNITS_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ORGUNITS_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


orgunits_insert() {

    apiQueryRef=( `echo orgunits insert` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams orgunits_insert customerId "false"
            else
                getParams "orgunits_insert" "customerId"
            fi
        else
            getParams "orgunits_insert" "customerId"
        fi
    else
        genParamConfig
        getParams "orgunits_insert" "customerId"
    fi

    #    declare -g "ORGUNITS_INSERT_customerId=${customerId}"


    

    ORGUNITS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.OrgUnit.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "OrgUnit"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ORGUNITS_INSERT_URL} =~ "pageToken=" ]]
            then                
                ORGUNITS_INSERT_URL+=\&pageToken=${1}
            else 
                ORGUNITS_INSERT_URL=`echo -n ${ORGUNITS_INSERT_URL} | sed "s/$(echo ${ORGUNITS_INSERT_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${ORGUNITS_INSERT_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${ORGUNITS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${ORGUNITS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${ORGUNITS_INSERT_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${ORGUNITS_INSERT_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


orgunits_list() {

    apiQueryRef=( `echo orgunits list` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams orgunits_list customerId "false"
            else
                getParams "orgunits_list" "customerId"
            fi
        else
            getParams "orgunits_list" "customerId"
        fi
    else
        genParamConfig
        getParams "orgunits_list" "customerId"
    fi

    #    declare -g "ORGUNITS_LIST_customerId=${customerId}"


    

    ORGUNITS_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits?key=${CLIENTID}"

    optParams=( type )

    typeMeta=(
        'string'
        'Whether to return all sub-organizations or just immediate children'
        '["typeUndefined","all","children"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams orgunits_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    ORGUNITS_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "orgunits_list" "${option}" "true"
                                ORGUNITS_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "orgunits_list" "${option}" "true"
                            ORGUNITS_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "orgunits_list" "${option}" "true"
                        ORGUNITS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi

    inpParams=( orgUnitPath )

    orgUnitPathMeta=(
        'string'
        'the URL-encoded organizational unit'\''s path or its ID'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams orgunits_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    ORGUNITS_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "orgunits_list" "${option}" "true"
                                ORGUNITS_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "orgunits_list" "${option}" "true"
                            ORGUNITS_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "orgunits_list" "${option}" "true"
                        ORGUNITS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ORGUNITS_LIST_URL} =~ "pageToken=" ]]
            then                
                ORGUNITS_LIST_URL+=\&pageToken=${1}
            else 
                ORGUNITS_LIST_URL=`echo -n ${ORGUNITS_LIST_URL} | sed "s/$(echo ${ORGUNITS_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${ORGUNITS_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${ORGUNITS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${ORGUNITS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${ORGUNITS_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ORGUNITS_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


orgunits_patch() {

    apiQueryRef=( `echo orgunits patch` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams orgunits_patch customerId "false"
            else
                getParams "orgunits_patch" "customerId"
            fi
        else
            getParams "orgunits_patch" "customerId"
        fi
    else
        genParamConfig
        getParams "orgunits_patch" "customerId"
    fi

    #    declare -g "ORGUNITS_PATCH_customerId=${customerId}"


    
    orgUnitPathMeta=( 
        'string'
        'Full path of the organizational unit or its ID'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.orgUnitPath)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.orgUnitPath)[] | .[]' ` ]]
            then
                checkParams orgunits_patch orgUnitPath "false"
            else
                getParams "orgunits_patch" "orgUnitPath"
            fi
        else
            getParams "orgunits_patch" "orgUnitPath"
        fi
    else
        genParamConfig
        getParams "orgunits_patch" "orgUnitPath"
    fi

    #    declare -g "ORGUNITS_PATCH_orgUnitPath=${orgUnitPath}"


    

    ORGUNITS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits/${orgunitsId}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.OrgUnit.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "OrgUnit"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ORGUNITS_PATCH_URL} =~ "pageToken=" ]]
            then                
                ORGUNITS_PATCH_URL+=\&pageToken=${1}
            else 
                ORGUNITS_PATCH_URL=`echo -n ${ORGUNITS_PATCH_URL} | sed "s/$(echo ${ORGUNITS_PATCH_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PATCH" "${ORGUNITS_PATCH_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PATCH \
            ${ORGUNITS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PATCH \
            ${ORGUNITS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PATCH \"${ORGUNITS_PATCH_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${ORGUNITS_PATCH_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


orgunits_update() {

    apiQueryRef=( `echo orgunits update` )


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customerId)[] | .[]' ` ]]
            then
                checkParams orgunits_update customerId "false"
            else
                getParams "orgunits_update" "customerId"
            fi
        else
            getParams "orgunits_update" "customerId"
        fi
    else
        genParamConfig
        getParams "orgunits_update" "customerId"
    fi

    #    declare -g "ORGUNITS_UPDATE_customerId=${customerId}"


    
    orgUnitPathMeta=( 
        'string'
        'Full path of the organizational unit or its ID'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.orgUnitPath)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.orgUnitPath)[] | .[]' ` ]]
            then
                checkParams orgunits_update orgUnitPath "false"
            else
                getParams "orgunits_update" "orgUnitPath"
            fi
        else
            getParams "orgunits_update" "orgUnitPath"
        fi
    else
        genParamConfig
        getParams "orgunits_update" "orgUnitPath"
    fi

    #    declare -g "ORGUNITS_UPDATE_orgUnitPath=${orgUnitPath}"


    

    ORGUNITS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits/${orgunitsId}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.OrgUnit.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "OrgUnit"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ORGUNITS_UPDATE_URL} =~ "pageToken=" ]]
            then                
                ORGUNITS_UPDATE_URL+=\&pageToken=${1}
            else 
                ORGUNITS_UPDATE_URL=`echo -n ${ORGUNITS_UPDATE_URL} | sed "s/$(echo ${ORGUNITS_UPDATE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PUT" "${ORGUNITS_UPDATE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PUT \
            ${ORGUNITS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PUT \
            ${ORGUNITS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PUT \"${ORGUNITS_UPDATE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${ORGUNITS_UPDATE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


privileges_list() {

    apiQueryRef=( `echo privileges list` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams privileges_list customer "false"
            else
                getParams "privileges_list" "customer"
            fi
        else
            getParams "privileges_list" "customer"
        fi
    else
        genParamConfig
        getParams "privileges_list" "customer"
    fi

    #    declare -g "PRIVILEGES_LIST_customer=${customer}"


    

    PRIVILEGES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles/ALL/privileges?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${PRIVILEGES_LIST_URL} =~ "pageToken=" ]]
            then                
                PRIVILEGES_LIST_URL+=\&pageToken=${1}
            else 
                PRIVILEGES_LIST_URL=`echo -n ${PRIVILEGES_LIST_URL} | sed "s/$(echo ${PRIVILEGES_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${PRIVILEGES_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${PRIVILEGES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${PRIVILEGES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${PRIVILEGES_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${PRIVILEGES_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


roleAssignments_delete() {

    apiQueryRef=( `echo roleAssignments delete` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams roleAssignments_delete customer "false"
            else
                getParams "roleAssignments_delete" "customer"
            fi
        else
            getParams "roleAssignments_delete" "customer"
        fi
    else
        genParamConfig
        getParams "roleAssignments_delete" "customer"
    fi

    #    declare -g "ROLEASSIGNMENTS_DELETE_customer=${customer}"


    
    roleAssignmentIdMeta=( 
        'string'
        'Immutable ID of the role assignment.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.roleAssignmentId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.roleAssignmentId)[] | .[]' ` ]]
            then
                checkParams roleAssignments_delete roleAssignmentId "false"
            else
                getParams "roleAssignments_delete" "roleAssignmentId"
            fi
        else
            getParams "roleAssignments_delete" "roleAssignmentId"
        fi
    else
        genParamConfig
        getParams "roleAssignments_delete" "roleAssignmentId"
    fi

    #    declare -g "ROLEASSIGNMENTS_DELETE_roleAssignmentId=${roleAssignmentId}"


    

    ROLEASSIGNMENTS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roleassignments/${roleAssignmentId}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ROLEASSIGNMENTS_DELETE_URL} =~ "pageToken=" ]]
            then                
                ROLEASSIGNMENTS_DELETE_URL+=\&pageToken=${1}
            else 
                ROLEASSIGNMENTS_DELETE_URL=`echo -n ${ROLEASSIGNMENTS_DELETE_URL} | sed "s/$(echo ${ROLEASSIGNMENTS_DELETE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "DELETE" "${ROLEASSIGNMENTS_DELETE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request DELETE \
            ${ROLEASSIGNMENTS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request DELETE \
            ${ROLEASSIGNMENTS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request DELETE \"${ROLEASSIGNMENTS_DELETE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${ROLEASSIGNMENTS_DELETE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


roleAssignments_get() {

    apiQueryRef=( `echo roleAssignments get` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams roleAssignments_get customer "false"
            else
                getParams "roleAssignments_get" "customer"
            fi
        else
            getParams "roleAssignments_get" "customer"
        fi
    else
        genParamConfig
        getParams "roleAssignments_get" "customer"
    fi

    #    declare -g "ROLEASSIGNMENTS_GET_customer=${customer}"


    
    roleAssignmentIdMeta=( 
        'string'
        'Immutable ID of the role assignment.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.roleAssignmentId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.roleAssignmentId)[] | .[]' ` ]]
            then
                checkParams roleAssignments_get roleAssignmentId "false"
            else
                getParams "roleAssignments_get" "roleAssignmentId"
            fi
        else
            getParams "roleAssignments_get" "roleAssignmentId"
        fi
    else
        genParamConfig
        getParams "roleAssignments_get" "roleAssignmentId"
    fi

    #    declare -g "ROLEASSIGNMENTS_GET_roleAssignmentId=${roleAssignmentId}"


    

    ROLEASSIGNMENTS_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roleassignments/${roleAssignmentId}?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ROLEASSIGNMENTS_GET_URL} =~ "pageToken=" ]]
            then                
                ROLEASSIGNMENTS_GET_URL+=\&pageToken=${1}
            else 
                ROLEASSIGNMENTS_GET_URL=`echo -n ${ROLEASSIGNMENTS_GET_URL} | sed "s/$(echo ${ROLEASSIGNMENTS_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${ROLEASSIGNMENTS_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${ROLEASSIGNMENTS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${ROLEASSIGNMENTS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${ROLEASSIGNMENTS_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ROLEASSIGNMENTS_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


roleAssignments_insert() {

    apiQueryRef=( `echo roleAssignments insert` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams roleAssignments_insert customer "false"
            else
                getParams "roleAssignments_insert" "customer"
            fi
        else
            getParams "roleAssignments_insert" "customer"
        fi
    else
        genParamConfig
        getParams "roleAssignments_insert" "customer"
    fi

    #    declare -g "ROLEASSIGNMENTS_INSERT_customer=${customer}"


    

    ROLEASSIGNMENTS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roleassignments?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.RoleAssignment.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "RoleAssignment"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ROLEASSIGNMENTS_INSERT_URL} =~ "pageToken=" ]]
            then                
                ROLEASSIGNMENTS_INSERT_URL+=\&pageToken=${1}
            else 
                ROLEASSIGNMENTS_INSERT_URL=`echo -n ${ROLEASSIGNMENTS_INSERT_URL} | sed "s/$(echo ${ROLEASSIGNMENTS_INSERT_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${ROLEASSIGNMENTS_INSERT_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${ROLEASSIGNMENTS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${ROLEASSIGNMENTS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${ROLEASSIGNMENTS_INSERT_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${ROLEASSIGNMENTS_INSERT_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


roleAssignments_list() {

    apiQueryRef=( `echo roleAssignments list` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams roleAssignments_list customer "false"
            else
                getParams "roleAssignments_list" "customer"
            fi
        else
            getParams "roleAssignments_list" "customer"
        fi
    else
        genParamConfig
        getParams "roleAssignments_list" "customer"
    fi

    #    declare -g "ROLEASSIGNMENTS_LIST_customer=${customer}"


    

    ROLEASSIGNMENTS_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roleassignments?key=${CLIENTID}"

    inpParams=( maxResults pageToken roleId userKey )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify the next page in the list.'
    )

    roleIdMeta=(
        'string'
        'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )

    userKeyMeta=(
        'string'
        'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams roleAssignments_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    ROLEASSIGNMENTS_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "roleAssignments_list" "${option}" "true"
                                ROLEASSIGNMENTS_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "roleAssignments_list" "${option}" "true"
                            ROLEASSIGNMENTS_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "roleAssignments_list" "${option}" "true"
                        ROLEASSIGNMENTS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ROLEASSIGNMENTS_LIST_URL} =~ "pageToken=" ]]
            then                
                ROLEASSIGNMENTS_LIST_URL+=\&pageToken=${1}
            else 
                ROLEASSIGNMENTS_LIST_URL=`echo -n ${ROLEASSIGNMENTS_LIST_URL} | sed "s/$(echo ${ROLEASSIGNMENTS_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${ROLEASSIGNMENTS_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${ROLEASSIGNMENTS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${ROLEASSIGNMENTS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${ROLEASSIGNMENTS_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ROLEASSIGNMENTS_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


roles_delete() {

    apiQueryRef=( `echo roles delete` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams roles_delete customer "false"
            else
                getParams "roles_delete" "customer"
            fi
        else
            getParams "roles_delete" "customer"
        fi
    else
        genParamConfig
        getParams "roles_delete" "customer"
    fi

    #    declare -g "ROLES_DELETE_customer=${customer}"


    
    roleIdMeta=( 
        'string'
        'Immutable ID of the role.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.roleId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.roleId)[] | .[]' ` ]]
            then
                checkParams roles_delete roleId "false"
            else
                getParams "roles_delete" "roleId"
            fi
        else
            getParams "roles_delete" "roleId"
        fi
    else
        genParamConfig
        getParams "roles_delete" "roleId"
    fi

    #    declare -g "ROLES_DELETE_roleId=${roleId}"


    

    ROLES_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles/${roleId}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ROLES_DELETE_URL} =~ "pageToken=" ]]
            then                
                ROLES_DELETE_URL+=\&pageToken=${1}
            else 
                ROLES_DELETE_URL=`echo -n ${ROLES_DELETE_URL} | sed "s/$(echo ${ROLES_DELETE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "DELETE" "${ROLES_DELETE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request DELETE \
            ${ROLES_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request DELETE \
            ${ROLES_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request DELETE \"${ROLES_DELETE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${ROLES_DELETE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


roles_get() {

    apiQueryRef=( `echo roles get` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams roles_get customer "false"
            else
                getParams "roles_get" "customer"
            fi
        else
            getParams "roles_get" "customer"
        fi
    else
        genParamConfig
        getParams "roles_get" "customer"
    fi

    #    declare -g "ROLES_GET_customer=${customer}"


    
    roleIdMeta=( 
        'string'
        'Immutable ID of the role.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.roleId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.roleId)[] | .[]' ` ]]
            then
                checkParams roles_get roleId "false"
            else
                getParams "roles_get" "roleId"
            fi
        else
            getParams "roles_get" "roleId"
        fi
    else
        genParamConfig
        getParams "roles_get" "roleId"
    fi

    #    declare -g "ROLES_GET_roleId=${roleId}"


    

    ROLES_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles/${roleId}?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ROLES_GET_URL} =~ "pageToken=" ]]
            then                
                ROLES_GET_URL+=\&pageToken=${1}
            else 
                ROLES_GET_URL=`echo -n ${ROLES_GET_URL} | sed "s/$(echo ${ROLES_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${ROLES_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${ROLES_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${ROLES_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${ROLES_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ROLES_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


roles_insert() {

    apiQueryRef=( `echo roles insert` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams roles_insert customer "false"
            else
                getParams "roles_insert" "customer"
            fi
        else
            getParams "roles_insert" "customer"
        fi
    else
        genParamConfig
        getParams "roles_insert" "customer"
    fi

    #    declare -g "ROLES_INSERT_customer=${customer}"


    

    ROLES_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Role.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Role"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ROLES_INSERT_URL} =~ "pageToken=" ]]
            then                
                ROLES_INSERT_URL+=\&pageToken=${1}
            else 
                ROLES_INSERT_URL=`echo -n ${ROLES_INSERT_URL} | sed "s/$(echo ${ROLES_INSERT_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${ROLES_INSERT_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${ROLES_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${ROLES_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${ROLES_INSERT_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${ROLES_INSERT_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


roles_list() {

    apiQueryRef=( `echo roles list` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams roles_list customer "false"
            else
                getParams "roles_list" "customer"
            fi
        else
            getParams "roles_list" "customer"
        fi
    else
        genParamConfig
        getParams "roles_list" "customer"
    fi

    #    declare -g "ROLES_LIST_customer=${customer}"


    

    ROLES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles?key=${CLIENTID}"

    inpParams=( maxResults pageToken )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify the next page in the list.'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams roles_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    ROLES_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "roles_list" "${option}" "true"
                                ROLES_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "roles_list" "${option}" "true"
                            ROLES_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "roles_list" "${option}" "true"
                        ROLES_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ROLES_LIST_URL} =~ "pageToken=" ]]
            then                
                ROLES_LIST_URL+=\&pageToken=${1}
            else 
                ROLES_LIST_URL=`echo -n ${ROLES_LIST_URL} | sed "s/$(echo ${ROLES_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${ROLES_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${ROLES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${ROLES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${ROLES_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ROLES_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


roles_patch() {

    apiQueryRef=( `echo roles patch` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams roles_patch customer "false"
            else
                getParams "roles_patch" "customer"
            fi
        else
            getParams "roles_patch" "customer"
        fi
    else
        genParamConfig
        getParams "roles_patch" "customer"
    fi

    #    declare -g "ROLES_PATCH_customer=${customer}"


    
    roleIdMeta=( 
        'string'
        'Immutable ID of the role.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.roleId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.roleId)[] | .[]' ` ]]
            then
                checkParams roles_patch roleId "false"
            else
                getParams "roles_patch" "roleId"
            fi
        else
            getParams "roles_patch" "roleId"
        fi
    else
        genParamConfig
        getParams "roles_patch" "roleId"
    fi

    #    declare -g "ROLES_PATCH_roleId=${roleId}"


    

    ROLES_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles/${roleId}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Role.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Role"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ROLES_PATCH_URL} =~ "pageToken=" ]]
            then                
                ROLES_PATCH_URL+=\&pageToken=${1}
            else 
                ROLES_PATCH_URL=`echo -n ${ROLES_PATCH_URL} | sed "s/$(echo ${ROLES_PATCH_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PATCH" "${ROLES_PATCH_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PATCH \
            ${ROLES_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PATCH \
            ${ROLES_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PATCH \"${ROLES_PATCH_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${ROLES_PATCH_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


roles_update() {

    apiQueryRef=( `echo roles update` )


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.customer)[] | .[]' ` ]]
            then
                checkParams roles_update customer "false"
            else
                getParams "roles_update" "customer"
            fi
        else
            getParams "roles_update" "customer"
        fi
    else
        genParamConfig
        getParams "roles_update" "customer"
    fi

    #    declare -g "ROLES_UPDATE_customer=${customer}"


    
    roleIdMeta=( 
        'string'
        'Immutable ID of the role.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.roleId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.roleId)[] | .[]' ` ]]
            then
                checkParams roles_update roleId "false"
            else
                getParams "roles_update" "roleId"
            fi
        else
            getParams "roles_update" "roleId"
        fi
    else
        genParamConfig
        getParams "roles_update" "roleId"
    fi

    #    declare -g "ROLES_UPDATE_roleId=${roleId}"


    

    ROLES_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles/${roleId}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Role.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Role"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${ROLES_UPDATE_URL} =~ "pageToken=" ]]
            then                
                ROLES_UPDATE_URL+=\&pageToken=${1}
            else 
                ROLES_UPDATE_URL=`echo -n ${ROLES_UPDATE_URL} | sed "s/$(echo ${ROLES_UPDATE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PUT" "${ROLES_UPDATE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PUT \
            ${ROLES_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PUT \
            ${ROLES_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PUT \"${ROLES_UPDATE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${ROLES_UPDATE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


tokens_delete() {

    apiQueryRef=( `echo tokens delete` )


    clientIdMeta=( 
        'string'
        'The Client ID of the application the token is issued to.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.clientId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.clientId)[] | .[]' ` ]]
            then
                checkParams tokens_delete clientId "false"
            else
                getParams "tokens_delete" "clientId"
            fi
        else
            getParams "tokens_delete" "clientId"
        fi
    else
        genParamConfig
        getParams "tokens_delete" "clientId"
    fi

    #    declare -g "TOKENS_DELETE_clientId=${clientId}"


    
    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams tokens_delete userKey "false"
            else
                getParams "tokens_delete" "userKey"
            fi
        else
            getParams "tokens_delete" "userKey"
        fi
    else
        genParamConfig
        getParams "tokens_delete" "userKey"
    fi

    #    declare -g "TOKENS_DELETE_userKey=${userKey}"


    

    TOKENS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/tokens/${clientId}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${TOKENS_DELETE_URL} =~ "pageToken=" ]]
            then                
                TOKENS_DELETE_URL+=\&pageToken=${1}
            else 
                TOKENS_DELETE_URL=`echo -n ${TOKENS_DELETE_URL} | sed "s/$(echo ${TOKENS_DELETE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "DELETE" "${TOKENS_DELETE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request DELETE \
            ${TOKENS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request DELETE \
            ${TOKENS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request DELETE \"${TOKENS_DELETE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${TOKENS_DELETE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


tokens_get() {

    apiQueryRef=( `echo tokens get` )


    clientIdMeta=( 
        'string'
        'The Client ID of the application the token is issued to.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.clientId)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.clientId)[] | .[]' ` ]]
            then
                checkParams tokens_get clientId "false"
            else
                getParams "tokens_get" "clientId"
            fi
        else
            getParams "tokens_get" "clientId"
        fi
    else
        genParamConfig
        getParams "tokens_get" "clientId"
    fi

    #    declare -g "TOKENS_GET_clientId=${clientId}"


    
    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams tokens_get userKey "false"
            else
                getParams "tokens_get" "userKey"
            fi
        else
            getParams "tokens_get" "userKey"
        fi
    else
        genParamConfig
        getParams "tokens_get" "userKey"
    fi

    #    declare -g "TOKENS_GET_userKey=${userKey}"


    

    TOKENS_GET_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/tokens/${clientId}?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${TOKENS_GET_URL} =~ "pageToken=" ]]
            then                
                TOKENS_GET_URL+=\&pageToken=${1}
            else 
                TOKENS_GET_URL=`echo -n ${TOKENS_GET_URL} | sed "s/$(echo ${TOKENS_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${TOKENS_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${TOKENS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${TOKENS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${TOKENS_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${TOKENS_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


tokens_list() {

    apiQueryRef=( `echo tokens list` )


    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams tokens_list userKey "false"
            else
                getParams "tokens_list" "userKey"
            fi
        else
            getParams "tokens_list" "userKey"
        fi
    else
        genParamConfig
        getParams "tokens_list" "userKey"
    fi

    #    declare -g "TOKENS_LIST_userKey=${userKey}"


    

    TOKENS_LIST_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/tokens?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${TOKENS_LIST_URL} =~ "pageToken=" ]]
            then                
                TOKENS_LIST_URL+=\&pageToken=${1}
            else 
                TOKENS_LIST_URL=`echo -n ${TOKENS_LIST_URL} | sed "s/$(echo ${TOKENS_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${TOKENS_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${TOKENS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${TOKENS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${TOKENS_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${TOKENS_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


twoStepVerification_turnOff() {

    apiQueryRef=( `echo twoStepVerification turnOff` )


    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams twoStepVerification_turnOff userKey "false"
            else
                getParams "twoStepVerification_turnOff" "userKey"
            fi
        else
            getParams "twoStepVerification_turnOff" "userKey"
        fi
    else
        genParamConfig
        getParams "twoStepVerification_turnOff" "userKey"
    fi

    #    declare -g "TWOSTEPVERIFICATION_TURNOFF_userKey=${userKey}"


    

    TWOSTEPVERIFICATION_TURNOFF_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/twoStepVerification/turnOff?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${TWOSTEPVERIFICATION_TURNOFF_URL} =~ "pageToken=" ]]
            then                
                TWOSTEPVERIFICATION_TURNOFF_URL+=\&pageToken=${1}
            else 
                TWOSTEPVERIFICATION_TURNOFF_URL=`echo -n ${TWOSTEPVERIFICATION_TURNOFF_URL} | sed "s/$(echo ${TWOSTEPVERIFICATION_TURNOFF_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${TWOSTEPVERIFICATION_TURNOFF_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${TWOSTEPVERIFICATION_TURNOFF_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${TWOSTEPVERIFICATION_TURNOFF_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${TWOSTEPVERIFICATION_TURNOFF_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${TWOSTEPVERIFICATION_TURNOFF_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


users_delete() {

    apiQueryRef=( `echo users delete` )


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams users_delete userKey "false"
            else
                getParams "users_delete" "userKey"
            fi
        else
            getParams "users_delete" "userKey"
        fi
    else
        genParamConfig
        getParams "users_delete" "userKey"
    fi

    #    declare -g "USERS_DELETE_userKey=${userKey}"


    

    USERS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${USERS_DELETE_URL} =~ "pageToken=" ]]
            then                
                USERS_DELETE_URL+=\&pageToken=${1}
            else 
                USERS_DELETE_URL=`echo -n ${USERS_DELETE_URL} | sed "s/$(echo ${USERS_DELETE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "DELETE" "${USERS_DELETE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request DELETE \
            ${USERS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request DELETE \
            ${USERS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request DELETE \"${USERS_DELETE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${USERS_DELETE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


users_get() {

    apiQueryRef=( `echo users get` )


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams users_get userKey "false"
            else
                getParams "users_get" "userKey"
            fi
        else
            getParams "users_get" "userKey"
        fi
    else
        genParamConfig
        getParams "users_get" "userKey"
    fi

    #    declare -g "USERS_GET_userKey=${userKey}"


    

    USERS_GET_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}?key=${CLIENTID}"

    optParams=( projection viewType )

    projectionMeta=(
        'string'
        'What subset of fields to fetch for this user.'
        '["projectionUndefined","basic","custom","full"]'
    )

    viewTypeMeta=(
        'string'
        'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
        '["view_type_undefined","admin_view","domain_public"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams users_get ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    USERS_GET_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "users_get" "${option}" "true"
                                USERS_GET_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "users_get" "${option}" "true"
                            USERS_GET_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "users_get" "${option}" "true"
                        USERS_GET_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi

    inpParams=( customFieldMask )

    customFieldMaskMeta=(
        'string'
        'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams users_get ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    USERS_GET_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "users_get" "${option}" "true"
                                USERS_GET_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "users_get" "${option}" "true"
                            USERS_GET_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "users_get" "${option}" "true"
                        USERS_GET_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${USERS_GET_URL} =~ "pageToken=" ]]
            then                
                USERS_GET_URL+=\&pageToken=${1}
            else 
                USERS_GET_URL=`echo -n ${USERS_GET_URL} | sed "s/$(echo ${USERS_GET_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${USERS_GET_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${USERS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${USERS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${USERS_GET_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${USERS_GET_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


users_insert() {

    apiQueryRef=( `echo users insert` )



    USERS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/users?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.User.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "User"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${USERS_INSERT_URL} =~ "pageToken=" ]]
            then                
                USERS_INSERT_URL+=\&pageToken=${1}
            else 
                USERS_INSERT_URL=`echo -n ${USERS_INSERT_URL} | sed "s/$(echo ${USERS_INSERT_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${USERS_INSERT_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${USERS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${USERS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${USERS_INSERT_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${USERS_INSERT_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


users_list() {

    apiQueryRef=( `echo users list` )



    USERS_LIST_URL="https://www.googleapis.com/admin/directory/v1/users?key=${CLIENTID}"

    optParams=( orderBy projection sortOrder viewType )

    orderByMeta=(
        'string'
        'Column to use for sorting results'
        '["orderByUndefined","email","familyName","givenName"]'
    )

    projectionMeta=(
        'string'
        'What subset of fields to fetch for this user.'
        '["projectionUndefined","basic","custom","full"]'
    )

    sortOrderMeta=(
        'string'
        'Whether to return results in ascending or descending order.'
        '["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    viewTypeMeta=(
        'string'
        'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
        '["view_type_undefined","admin_view","domain_public"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams users_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    USERS_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "users_list" "${option}" "true"
                                USERS_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "users_list" "${option}" "true"
                            USERS_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "users_list" "${option}" "true"
                        USERS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi

    inpParams=( customFieldMask customer domain maxResults pageToken query showDeleted )

    customFieldMaskMeta=(
        'string'
        'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )

    customerMeta=(
        'string'
        'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )

    domainMeta=(
        'string'
        'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify next page in the list'
    )

    queryMeta=(
        'string'
        'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )

    showDeletedMeta=(
        'string'
        'If set to true, retrieves the list of deleted users. (Default: false)'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams users_list ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    USERS_LIST_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "users_list" "${option}" "true"
                                USERS_LIST_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "users_list" "${option}" "true"
                            USERS_LIST_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "users_list" "${option}" "true"
                        USERS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${USERS_LIST_URL} =~ "pageToken=" ]]
            then                
                USERS_LIST_URL+=\&pageToken=${1}
            else 
                USERS_LIST_URL=`echo -n ${USERS_LIST_URL} | sed "s/$(echo ${USERS_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${USERS_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${USERS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${USERS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${USERS_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${USERS_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


users_makeAdmin() {

    apiQueryRef=( `echo users makeAdmin` )


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user as admin'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams users_makeAdmin userKey "false"
            else
                getParams "users_makeAdmin" "userKey"
            fi
        else
            getParams "users_makeAdmin" "userKey"
        fi
    else
        genParamConfig
        getParams "users_makeAdmin" "userKey"
    fi

    #    declare -g "USERS_MAKEADMIN_userKey=${userKey}"


    

    USERS_MAKEADMIN_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/makeAdmin?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.UserMakeAdmin.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "UserMakeAdmin"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${USERS_MAKEADMIN_URL} =~ "pageToken=" ]]
            then                
                USERS_MAKEADMIN_URL+=\&pageToken=${1}
            else 
                USERS_MAKEADMIN_URL=`echo -n ${USERS_MAKEADMIN_URL} | sed "s/$(echo ${USERS_MAKEADMIN_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${USERS_MAKEADMIN_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${USERS_MAKEADMIN_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${USERS_MAKEADMIN_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${USERS_MAKEADMIN_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${USERS_MAKEADMIN_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


users_patch() {

    apiQueryRef=( `echo users patch` )


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user. If ID, it should match with id of user object'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams users_patch userKey "false"
            else
                getParams "users_patch" "userKey"
            fi
        else
            getParams "users_patch" "userKey"
        fi
    else
        genParamConfig
        getParams "users_patch" "userKey"
    fi

    #    declare -g "USERS_PATCH_userKey=${userKey}"


    

    USERS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.User.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "User"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${USERS_PATCH_URL} =~ "pageToken=" ]]
            then                
                USERS_PATCH_URL+=\&pageToken=${1}
            else 
                USERS_PATCH_URL=`echo -n ${USERS_PATCH_URL} | sed "s/$(echo ${USERS_PATCH_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PATCH" "${USERS_PATCH_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PATCH \
            ${USERS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PATCH \
            ${USERS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PATCH \"${USERS_PATCH_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${USERS_PATCH_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


users_signOut() {

    apiQueryRef=( `echo users signOut` )


    userKeyMeta=( 
        'string'
        'Identifies the target user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams users_signOut userKey "false"
            else
                getParams "users_signOut" "userKey"
            fi
        else
            getParams "users_signOut" "userKey"
        fi
    else
        genParamConfig
        getParams "users_signOut" "userKey"
    fi

    #    declare -g "USERS_SIGNOUT_userKey=${userKey}"


    

    USERS_SIGNOUT_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/signOut?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${USERS_SIGNOUT_URL} =~ "pageToken=" ]]
            then                
                USERS_SIGNOUT_URL+=\&pageToken=${1}
            else 
                USERS_SIGNOUT_URL=`echo -n ${USERS_SIGNOUT_URL} | sed "s/$(echo ${USERS_SIGNOUT_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${USERS_SIGNOUT_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${USERS_SIGNOUT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${USERS_SIGNOUT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${USERS_SIGNOUT_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${USERS_SIGNOUT_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


users_undelete() {

    apiQueryRef=( `echo users undelete` )


    userKeyMeta=( 
        'string'
        'The immutable id of the user'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams users_undelete userKey "false"
            else
                getParams "users_undelete" "userKey"
            fi
        else
            getParams "users_undelete" "userKey"
        fi
    else
        genParamConfig
        getParams "users_undelete" "userKey"
    fi

    #    declare -g "USERS_UNDELETE_userKey=${userKey}"


    

    USERS_UNDELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/undelete?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.UserUndelete.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "UserUndelete"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${USERS_UNDELETE_URL} =~ "pageToken=" ]]
            then                
                USERS_UNDELETE_URL+=\&pageToken=${1}
            else 
                USERS_UNDELETE_URL=`echo -n ${USERS_UNDELETE_URL} | sed "s/$(echo ${USERS_UNDELETE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${USERS_UNDELETE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${USERS_UNDELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${USERS_UNDELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${USERS_UNDELETE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${USERS_UNDELETE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


users_update() {

    apiQueryRef=( `echo users update` )


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user. If ID, it should match with id of user object'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams users_update userKey "false"
            else
                getParams "users_update" "userKey"
            fi
        else
            getParams "users_update" "userKey"
        fi
    else
        genParamConfig
        getParams "users_update" "userKey"
    fi

    #    declare -g "USERS_UPDATE_userKey=${userKey}"


    

    USERS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.User.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "User"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${USERS_UPDATE_URL} =~ "pageToken=" ]]
            then                
                USERS_UPDATE_URL+=\&pageToken=${1}
            else 
                USERS_UPDATE_URL=`echo -n ${USERS_UPDATE_URL} | sed "s/$(echo ${USERS_UPDATE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "PUT" "${USERS_UPDATE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request PUT \
            ${USERS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request PUT \
            ${USERS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request PUT \"${USERS_UPDATE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${USERS_UPDATE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


users_watch() {

    apiQueryRef=( `echo users watch` )



    USERS_WATCH_URL="https://www.googleapis.com/admin/directory/v1/users/watch?key=${CLIENTID}"

    optParams=( event orderBy projection sortOrder viewType )

    eventMeta=(
        'string'
        'Event on which subscription is intended'
        '["eventTypeUnspecified","add","delete","makeAdmin","undelete","update"]'
    )

    orderByMeta=(
        'string'
        'Column to use for sorting results'
        '["orderByUnspecified","email","familyName","givenName"]'
    )

    projectionMeta=(
        'string'
        'What subset of fields to fetch for this user.'
        '["projectionUnspecified","basic","custom","full"]'
    )

    sortOrderMeta=(
        'string'
        'Whether to return results in ascending or descending order.'
        '["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )

    viewTypeMeta=(
        'string'
        'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
        '["admin_view","domain_public"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams users_watch ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    USERS_WATCH_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "users_watch" "${option}" "true"
                                USERS_WATCH_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "users_watch" "${option}" "true"
                            USERS_WATCH_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "users_watch" "${option}" "true"
                        USERS_WATCH_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi

    inpParams=( customFieldMask customer domain maxResults pageToken query showDeleted )

    customFieldMaskMeta=(
        'string'
        'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )

    customerMeta=(
        'string'
        'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )

    domainMeta=(
        'string'
        'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify next page in the list'
    )

    queryMeta=(
        'string'
        'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )

    showDeletedMeta=(
        'string'
        'If set to true, retrieves the list of deleted users. (Default: false)'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear

                    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
                    then
                        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})" ` ]]
                        then
                            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr ".param[] | select(.${option})[] | .[]" ` ]]
                            then
                                checkParams users_watch ${option} "true"
                                if ! [[ ${addedParams} =~ ${option} ]]
                                then
                                    USERS_WATCH_URL+="${tempUrlPar}"
                                    addedParams+=( "${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "users_watch" "${option}" "true"
                                USERS_WATCH_URL+="${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "users_watch" "${option}" "true"
                            USERS_WATCH_URL+="${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "users_watch" "${option}" "true"
                        USERS_WATCH_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi

    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.Channel.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "Channel"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${USERS_WATCH_URL} =~ "pageToken=" ]]
            then                
                USERS_WATCH_URL+=\&pageToken=${1}
            else 
                USERS_WATCH_URL=`echo -n ${USERS_WATCH_URL} | sed "s/$(echo ${USERS_WATCH_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${USERS_WATCH_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${USERS_WATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${USERS_WATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${USERS_WATCH_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${USERS_WATCH_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


verificationCodes_generate() {

    apiQueryRef=( `echo verificationCodes generate` )


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams verificationCodes_generate userKey "false"
            else
                getParams "verificationCodes_generate" "userKey"
            fi
        else
            getParams "verificationCodes_generate" "userKey"
        fi
    else
        genParamConfig
        getParams "verificationCodes_generate" "userKey"
    fi

    #    declare -g "VERIFICATIONCODES_GENERATE_userKey=${userKey}"


    

    VERIFICATIONCODES_GENERATE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/verificationCodes/generate?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${VERIFICATIONCODES_GENERATE_URL} =~ "pageToken=" ]]
            then                
                VERIFICATIONCODES_GENERATE_URL+=\&pageToken=${1}
            else 
                VERIFICATIONCODES_GENERATE_URL=`echo -n ${VERIFICATIONCODES_GENERATE_URL} | sed "s/$(echo ${VERIFICATIONCODES_GENERATE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${VERIFICATIONCODES_GENERATE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${VERIFICATIONCODES_GENERATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${VERIFICATIONCODES_GENERATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${VERIFICATIONCODES_GENERATE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${VERIFICATIONCODES_GENERATE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


verificationCodes_invalidate() {

    apiQueryRef=( `echo verificationCodes invalidate` )


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams verificationCodes_invalidate userKey "false"
            else
                getParams "verificationCodes_invalidate" "userKey"
            fi
        else
            getParams "verificationCodes_invalidate" "userKey"
        fi
    else
        genParamConfig
        getParams "verificationCodes_invalidate" "userKey"
    fi

    #    declare -g "VERIFICATIONCODES_INVALIDATE_userKey=${userKey}"


    

    VERIFICATIONCODES_INVALIDATE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/verificationCodes/invalidate?key=${CLIENTID}"


    echo -e "yes\nno" \
    | fuzzExPostParametersPrompt "\".schemas.null.properties\"" "Add any Post Data to the request?" \
    | read -r postDataChoice

    if [[ ${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ ${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "null"
            
            if [[ ${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "$ref": "UserName")

            if [[ -z ${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ `echo ${postPropPayload} | jq -cr '."$ref"' ` == "null" ]]
            then
                postDataStrucHead=${postPropOpt}
                postDataContentHead=${postPropPayload}
                postDataStrucTail=`echo ${postPropPayload} | jq -cr '."$ref"' `
                
                if [[ `echo ${requestPostData} | jq -cr ".${postDataStrucHead}"` == "null" ]]
                then
                    echo ${requestPostData} \
                    | jq -c ".${postDataStrucHead}={}" \
                    | read -r requestPostData
                fi

                while [[ ${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "${postDataStrucTail}"

                    if [[ ${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        postLoopBreak=false                
                        break
                    fi

                    fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                    | read -r postPropVal

                    if ! [[ -z ${postPropVal} ]]
                    then
                        postDataPropBuild ".${postDataStrucHead}.${postPropOpt}" "${(qqq)postPropVal}"
                    fi                
                done

            else
                fuzzExInputCreds "Enter a value for ${postPropOpt}" \
                | read -r postPropVal


                if ! [[ -z ${postPropVal} ]]
                then
                    postDataPropBuild ".${postPropOpt}" "${(qqq)postPropVal}"
                fi

            fi
        done
    
    fi




    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${VERIFICATIONCODES_INVALIDATE_URL} =~ "pageToken=" ]]
            then                
                VERIFICATIONCODES_INVALIDATE_URL+=\&pageToken=${1}
            else 
                VERIFICATIONCODES_INVALIDATE_URL=`echo -n ${VERIFICATIONCODES_INVALIDATE_URL} | sed "s/$(echo ${VERIFICATIONCODES_INVALIDATE_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "POST" "${VERIFICATIONCODES_INVALIDATE_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request POST \
            ${VERIFICATIONCODES_INVALIDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request POST \
            ${VERIFICATIONCODES_INVALIDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request POST \"${VERIFICATIONCODES_INVALIDATE_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${VERIFICATIONCODES_INVALIDATE_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}


verificationCodes_list() {

    apiQueryRef=( `echo verificationCodes list` )


    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if ! [[ ` cat ${credPath}/${fileRef} | jq -cr '.param' ` == "null" ]]
    then
        if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)' `  ]]
        then
            if ! [[ -z ` cat ${credPath}/${fileRef} | jq -cr '.param[] | select(.userKey)[] | .[]' ` ]]
            then
                checkParams verificationCodes_list userKey "false"
            else
                getParams "verificationCodes_list" "userKey"
            fi
        else
            getParams "verificationCodes_list" "userKey"
        fi
    else
        genParamConfig
        getParams "verificationCodes_list" "userKey"
    fi

    #    declare -g "VERIFICATIONCODES_LIST_userKey=${userKey}"


    

    VERIFICATIONCODES_LIST_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/verificationCodes?key=${CLIENTID}"

    execRequest() {
        if ! [[ -z "${1}" ]]
        then 
            if ! [[ ${VERIFICATIONCODES_LIST_URL} =~ "pageToken=" ]]
            then                
                VERIFICATIONCODES_LIST_URL+=\&pageToken=${1}
            else 
                VERIFICATIONCODES_LIST_URL=`echo -n ${VERIFICATIONCODES_LIST_URL} | sed "s/$(echo ${VERIFICATIONCODES_LIST_URL} | grep -oP '&pageToken=.*')/\&pageToken=${1}/"`
            fi

            if ! [[ -z ${requestId} ]]
            then
                
                if [[ -z ${originRequestId} ]]
                then
                    export originRequestId=${requestId}
                else
                    prevRequestId=${requestId}
                fi
                
                unset requestId
            fi
        fi
        
        if [[ -z ${requestId} ]]
        then 
            histGenRequest "${CLIENTID}" "${ACCESSTOKEN}" "${REFRESHTOKEN}" "${apiQueryRef[1]}" "${apiQueryRef[2]}" "GET" "${VERIFICATIONCODES_LIST_URL}"
 
            if [[ -z "${1}" ]]
            then
                
                if ! [[ -z ${sentAuthRequest} ]] \
                && ! [[ -z ${authPayload} ]]
                then 
                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.curl" "\"${sentAuthRequest}\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".auth.response" "${authPayload}"
                fi

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Authorization: Bearer ${ACCESSTOKEN}\""

            echo ${requestPayload} \
            | histListBuild ".request.headers" "\"Accept: application/json\""

                if ! [[ -z ${requestPostData} ]]
                then
                    echo ${requestPayload} \
                    | histListBuild  ".request.headers" "\"Content-Type: application/json\""

                    echo ${requestPayload} \
                    | histUpdatePayload ".request.postData" "${requestPostData}"

                fi

            fi

            histNewEntry "${requestPayload}" "${gapicLogDir}" "requests.json"

            if ! [[ -z "${1}" ]]
            then

                if [[ -z ${prevRequestId} ]]
                then
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"nextPageToken\":\"${1}\"}"
                else
                    histUpdateJson "\"${requestId}\"" ".tags" "{\"nextPage\":true,\"listOrigin\":\"${originRequestId}\",\"listPrevious\":\"${prevRequestId}\",\"nextPageToken\":\"${1}\"}"
                fi


            fi

        else
            if [[ -z "${1}" ]]
            then
                histUpdateToken "\"${requestId}\"" ".auth.refreshToken" "${REFRESHTOKEN}"
                histUpdateToken "\"${requestId}\"" ".auth.accessToken" "${ACCESSTOKEN}"        
                histUpdateToken "\"${requestId}\"" ".auth.curl" "${sentAuthRequest}"            
                histUpdateJson "\"${requestId}\"" ".auth.response" "${authPayload}"          
            fi
        fi

        # handle GET/POST requests

        if ! [[ -z ${requestPostData} ]]
        then
            # handle POST requests

            curl -s \
            --request GET \
            ${VERIFICATIONCODES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header 'Content-Type: application/json' \
            --data "${requestPostData}" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson

        else
            curl -s \
            --request GET \
            ${VERIFICATIONCODES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"${requestId}\"" ".response" "${outputJson}"          

        execCurl="curl -s --request GET \"${VERIFICATIONCODES_LIST_URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${VERIFICATIONCODES_LIST_URL} \\ 
EOIF
        execCurl+="--header 'Authorization: Bearer ${ACCESSTOKEN}' "
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        execCurl+="--header 'Accept: application/json' "
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        if ! [[ -z ${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json' \\ 
        --data '${requestPostData}' \\ 
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"${requestId}\"" ".request.curl" "${execCurl}"          
        unset execCurl

    }
    execRequest

}

