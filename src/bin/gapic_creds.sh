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

# Retrieve needed credentials
    # Define credentials output file path

    credPath=`realpath $0`
    export credPath=${credPath//bin\/gapic_creds.sh/data\/.creds}


    credFile=`realpath $0`
    export credFileParams=${credFile//bin\/gapic_creds.sh/data\/.api_params}

clientCreate() {
    jq -cn \
    --arg cid "${1}" \
    --argjson cs null \
    '{clientId: $cid, clientSecret: $cs, authScopes: [ ]}' \
    | read newClient

    local clientName=`echo ${1//-/ } | awk '{print $1}' `

    echo ${newClient} | jq '.' > ${credPath}/${clientName}
}

scopeCreate() {
    cat ${3} \
    | fuzzExCreateScopes "Which scope do you want to authorize?" "${1}" "${2}" "${3}" \
    | read -r requestScope

    clientScopes=${requestScope}


    if ! [[ -z ${requestScope} ]]
    then
        export requestScope clientScopes

        activeScopesArr=( `cat ${4} | jq -c ".authScopes[]" ` )
        activeIndex=${#activeScopesArr}


        jq -cn \
        --arg scp ${requestScope} \
        --argjson rt null \
        --argjson at null \
        '{scopeUrl: $scp, refreshToken: $rt, accessToken: $at}' \
        | read -r newScope


        tmp=`mktemp`

        cat ${4} \
        | jq ".authScopes=[.authScopes[],${newScope}]" \
        > ${tmp}

        if [[ `cat ${tmp} | jq -c ` ]]
        then
            mv ${tmp} ${4}
        fi
    else
        exit 1
    fi
}

buildAuth() {
    # Generate an offline access code via URL
    # Ref [:1] https://developers.google.com/youtube/v3/live/guides/auth/installed-apps#Obtaining_Access_Tokens
    # Ref [:2] https://developers.google.com/google-ads/api/docs/concepts/curl-example

    clear
    echo -en "# Please visit the URL below to generate an access code. Once authenticated you will be provided a code - paste it below: \n\n "


    requestClientID=`cat ${1} | jq -r '.clientId'  `
    requestClientSecret=`cat ${1} | jq -r '.clientSecret' `

    if [[ -z ${requestScope} ]] \
    && ! [[ -z ${2} ]]
    then
        export requestScope=`cat ${1} | jq -r ".authScopes[${2}].scopeUrl" `
    fi

    requestScopeCode=${requestScope//:/%3A}
    requestScopeCode=${requestScope//=/%3D}
    requestScopeCode=${requestScope//+/%2B}
    requestScopeCode=${requestScopeCode//\//%2F}

    export CLIENTID=${requestClientID}

    urlString1='https://accounts.google.com/o/oauth2/auth?client_id='
    urlString2='&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&access_type=offline&prompt=consent&scope='

    urlGen=${urlString1}${requestClientID}${urlString2}${requestScopeCode}

    echo ${urlGen}

    echo -en "\nOffline code\t~> "
    read -r offlineCode
    clear

    export sentAuthRequest="curl -s \ \n    https://accounts.google.com/o/oauth2/token \ \n    -d code=${offlineCode} \ \n    -d client_id=${requestClientID} \ \n    -d client_secret=${requestClientSecret} \ \n    -d redirect_uri=urn:ietf:wg:oauth:2.0:oob \ \n    -d grant_type=authorization_code"
    
    echo -e "# Request sent:\n\n"
    echo -e "#########################\n"
    echo "${sentAuthRequest}"
    echo -e "\n\n"
    echo -e "#########################\n"
    export sentAuthRequest="curl -s https://accounts.google.com/o/oauth2/token -d code=${offlineCode} -d client_id=${requestClientID} -d client_secret=${requestClientSecret} -d redirect_uri=urn:ietf:wg:oauth:2.0:oob -d grant_type=authorization_code"


    curl -s \
    https://accounts.google.com/o/oauth2/token \
    -d code=${offlineCode} \
    -d client_id=${requestClientID} \
    -d client_secret=${requestClientSecret} \
    -d redirect_uri=urn:ietf:wg:oauth:2.0:oob \
    -d grant_type=authorization_code \
    | jq -c '.' | read -r authPayload

    export authPayload

    tmp=`mktemp`

    
    if ! [[ `echo ${authPayload} | jq -r '.refresh_token' ` == "null" ]] \
    && ! [[ `echo ${authPayload} | jq -r '.access_token' ` == "null" ]]
    then 
        authRefreshToken=`echo ${authPayload} | jq -r '.refresh_token' `
        authAccessToken=`echo ${authPayload} | jq  -r '.access_token' `

        export ACCESSTOKEN=${authAccessToken}
        export REFRESHTOKEN=${authRefreshToken}

        mvCreds "${1}" "scopeUrl" "${requestScope}" "refreshToken" "\"${REFRESHTOKEN}\"" 
        mvCreds "${1}" "scopeUrl" "${requestScope}" "accessToken" "\"${ACCESSTOKEN}\"" 



        echo -e "# Execution complete!\n\n"
        echo -e "#########################\n"
        echo "${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
    elif [[ `echo ${authPayload} | jq  -r '.error'  ` == "invalid_grant" ]]
    then

        mvCreds "${1}" "scopeUrl" "${requestScope}" "refreshToken" "null" 

        echo -e "# Invalid Refresh Token! Relaunch the tool.\n\n"
        echo -e "#########################\n"
        echo "${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
        exit 1

    else
        echo -e "# Error in the authentication!\n\n"
        echo -e "#########################\n"
        echo "${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
        rm ${tmp}
        exit 1
    fi
}

rebuildAuth() {
    # get a new Access Token with Refresh Token
    # https://developers.google.com/identity/protocols/oauth2/web-server#httprest_7
     
    requestClientID=`cat ${1} | jq -r '.clientId' `
    requestClientSecret=`cat ${1} | jq -r '.clientSecret' `

    if [[ -z ${REFRESHTOKEN} ]]
    then
        requestRefreshToken=`cat ${1} | jq -r ".authScopes[${2}].refreshToken" `
        export REFRESHTOKEN=${requestRefreshToken}
    fi

    if [[ -z ${requestScope} ]]
    then
        export requestScope=`cat ${1} | jq -r ".authScopes[${2}].scopeUrl"  `
    fi

    export CLIENTID=${requestClientID}

    export sentAuthRequest="curl -s \ \n    --request POST \ \n    -d client_id=${requestClientID} \ \n    -d client_secret=${requestClientSecret} \ \n    -d refresh_token=${REFRESHTOKEN} \ \n    -d grant_type=refresh_token \ \n    \"https://accounts.google.com/o/oauth2/token\""

    echo -e "# Request sent:\n\n"
    echo -e "#########################\n"
    echo "${sentAuthRequest}"
    echo -e "\n\n"
    echo -e "#########################\n"
    export sentAuthRequest="curl -s --request POST -d client_id=${requestClientID} -d client_secret=${requestClientSecret} -d refresh_token=${REFRESHTOKEN} -d grant_type=refresh_token https://accounts.google.com/o/oauth2/token"

    curl -s \
    --request POST \
    -d client_id=${requestClientID} \
    -d client_secret=${requestClientSecret} \
    -d refresh_token=${REFRESHTOKEN} \
    -d grant_type=refresh_token \
    "https://accounts.google.com/o/oauth2/token" \
        | jq -c '.' \
        | read -r authPayload

    export authPayload

    tmp=`mktemp`

    if ! [[ `echo ${authPayload} | jq '.access_token'` == "null" ]]
    then 
        authAccessToken=`echo ${authPayload} | jq -r '.access_token' `

        export ACCESSTOKEN=${authAccessToken}

        mvCreds "${1}" "scopeUrl" "${requestScope}" "accessToken" "\"${ACCESSTOKEN}\"" 


        echo -e "# Execution complete!\n\n"
        echo -e "#########################\n"
        echo "${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
    elif [[ `echo ${authPayload} | jq -r '.error'  ` == "invalid_grant" ]]
    then

        mvCreds "${1}" "scopeUrl" "${requestScope}" "refreshToken" "null"


        echo -e "# Invalid Refresh Token! Relaunch the tool.\n\n"
        echo -e "#########################\n"
        echo "${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
        exit 1
    else
        echo -e "# Error in the authentication!\n\n"
        echo -e "#########################\n"
        echo "${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
        rm ${tmp}
        exit 1
    fi

}

checkScopeAccess() {
    cat ${2} \
    | jq -c ".authScopes[${1}]" \
    | read -r accessCheckJson

    if [[ `echo ${accessCheckJson} | jq ".refreshToken"| sed 's/"//g' ` == null ]] \
    && [[ `echo ${accessCheckJson} | jq ".accessToken" | sed 's/"//g' ` == null ]]
    then
        buildAuth "${2}" "${1}" 

    elif [[ `echo ${accessCheckJson} | jq ".refreshToken" | sed 's/"//g' ` != null ]] \
    && [[ `echo ${accessCheckJson} | jq ".accessToken" | sed 's/"//g' ` == null ]]
    then
        rebuildAuth  "${2}" "${1}"
    else
        export ACCESSTOKEN="`echo ${accessCheckJson} | jq '.accessToken' | sed 's/"//g' `"
        export REFRESHTOKEN="`echo ${accessCheckJson} | jq '.refreshToken' | sed 's/"//g' `"
        export requestScope="`echo ${accessCheckJson} | jq '.scopeUrl' | sed 's/"//g' `"

    fi

}

clientCheck() {
    export fileRef=`echo ${1} | jq '.clientId' | sed 's/-/ /' | awk '{print $1}' | sed 's/"//g' `
    local clientId=`echo ${1} | jq '.clientId' | sed 's/"//g' `
    local clientSecret=`echo ${1} | jq '.clientSecret' | sed 's/"//g' `

    export CLIENTID=${clientId}
    export CLIENTSECRET${clientSecret}

    local tmp=`mktemp`

    if [[ ${clientSecret} == null ]]
    then
        fuzzExInputCreds "Enter your Client Secret for ${clientId}" \
        | read clientSecret

        cat ${credPath}/${fileRef} \
        | jq ".clientSecret=\"${clientSecret}\"" \
        > ${tmp}

        if [[ `cat ${tmp} | jq '.' ` ]]
        then 
            mv ${tmp} ${credPath}/${fileRef}
        fi
    fi
}

checkCreds() {
    # Check for existing client IDs

    if [[ `find ${credPath} -type f` ]] \
    && [[ -z ${clientJson} ]]
    then 
        ls ${credPath}/ \
        | fuzzExSavedCreds "Re-use any of these ClientIDs?" "${credPath}" \
        | read -r clientJson

        if [[ -z ${clientJson} ]]
        then
            fuzzExInputCreds "Enter your ClientID" \
            | read clientId

            if [[ -z ${clientId} ]]
            then
                ((noClientCounter++))
                
                if [[ ${noClientCounter} -gt 3 ]]
                then
                    exit 1
                fi
                checkCreds
            fi

            clientCreate "${clientId}"
            checkCreds

        fi

        clientCheck "${clientJson}"

    else 
        fuzzExInputCreds "Enter your ClientID" \
        | read clientId

        if [[ -z ${clientId} ]]
        then
            ((noClientCounter++))
            
            if [[ ${noClientCounter} -gt 3 ]]
            then
                exit 1
            fi
            checkCreds
        fi

        clientCreate "${clientId}"
        checkCreds
    fi

    export clientJson
}

##  rmCreds(): Deprecated ~ test and remove
rmCreds() {
    tmp=`mktemp`

    cat ${1} \
    | jq -c ".authScopes | map(select(.${2} == \"${3}\").${2} |= null" \
    | read -r newAuthScopes

    cat ${1} \
    | jq ".authScopes=${newAuthScopes}" \
    > ${tmp}

    if [[ `cat ${tmp} | jq -c ` ]]
    then
        mv ${tmp} ${1}
    fi
}
####


mvCreds() {
    tmp=`mktemp`

    cat ${1} \
    | jq -c ".authScopes | map(select(.${2} == \"${3}\").${4} |= ${5})" \
    | read -r newAuthScopes

    cat ${1} \
    | jq ".authScopes=${newAuthScopes}" \
    > ${tmp}

    if [[ `cat ${tmp} | jq -c ` ]]
    then
        mv ${tmp} ${1}
    fi
}

scopeLookup() {
    for (( i = 1 ; i <= ${(P)#1[@]} ; i++ ))
    do
        for (( a = 1 ; a <= ${(P)#2[@]} ; a++ ))
        do
            if [[ ` echo "${(P)1[${i}]}" | jq -c '.scopeUrl' | sed 's/\"//g' ` == "${(P)2[${a}]}" ]]
            then
                scopeIndex+=( ` cat ${credPath}/${fileRef} | jq -c ".authScopes[((${i}-1))]" ` )
                scopeIndexNo+=( $((${i}-1)) )
            fi
        done
    done

    export scopeIndex
    export scopeIndexNo

    if [[ -z ${scopeIndex} ]] \
    && [[ -z ${scopeIndexNo} ]]
    then
        scopeMissing=true
    else
        scopeMissing=false
    fi
}


checkScopes() {
    availableScopes=( `cat ${3} | jq  ".resources.${1}.methods.${2}.scopes[]" | sed 's/\"//g' ` )
    savedScopes=( `cat ${4} | jq -c '.authScopes[]'  ` )
    scopeIndex=( )
    scopeIndexNo=( )

    if [[ -z ${savedScopes} ]]
    then
        scopeCreate "${1}" "${2}" "${3}" "${4}"
        savedScopes=( `cat ${4} | jq -c '.authScopes[]'` )

    fi

    if [[ -z ${activeIndex} ]]
    then

        scopeLookup "savedScopes" "availableScopes"
    
        if [[ ${scopeMissing} == "false" ]] \
        &&  { 
            [[ ${#savedScopes[@]} -lt ${#availableScopes[@]} ]] \
            || [[ ${#scopeIndex[@]} -gt 1 ]]
            }
        then
            echo ${scopeIndex[@]} \
            | fuzzExSavedScopes "Re-use any of these OAuth Scopes?" "${4}" \
            | read -r clientScopes

            if [[ -z ${clientScopes} ]]
            then
                if [[ ${#savedScopes[@]} -eq ${#availableScopes[@]} ]]
                then
                    echo ${scopeIndex[@]} \
                    | fuzzExSavedScopes "Can't add any more scopes to this method. Re-use any?" "${4}" \
                    | read -r clientScopes

                    if [[ -z ${clientScopes} ]]
                    then 
                        exit 1
                    fi
                elif [[ ${#savedScopes[@]} -lt ${#availableScopes[@]} ]]
                then
                    scopeCreate "${1}" "${2}" "${3}" "${4}"
                    savedScopes=( `cat ${4} | jq -c '.authScopes[]'` )
                    scopeLookup "savedScopes" "availableScopes"
                fi
            fi
            
            for (( i = 1 ; i <= ${#scopeIndex[@]} ; i++ ))
            do
                if [[ `echo ${scopeIndex[${i}]} | jq '.scopeUrl' | sed 's/"//g' ` == ${clientScopes} ]]
                then
                    activeIndex=${scopeIndexNo[${i}]}
                    checkScopeAccess "${activeIndex}" "${4}"
                fi
            done

        elif [[ ${scopeMissing} == "true" ]]
        then
            scopeCreate "${1}" "${2}" "${3}" "${4}"
            savedScopes=( `cat ${4} | jq -c '.authScopes[]'` )
            scopeLookup "savedScopes" "availableScopes"

        else
            activeIndex=${scopeIndexNo}
            checkScopeAccess "${activeIndex}" "${4}"
        fi
    else
        checkScopeAccess "${activeIndex}" "${4}"

    fi
}


authSvAcc() {
    jwtHeader='{"alg":"RS256","typ":"JWT"}'

    local serviceAccount="${1}"
    local subscriber="${2}"
    local scopeUrl="${3}"
    local audienceUrl='https://oauth2.googleapis.com/token'
    local issuedTime=$(date +%s)
    local expiryTime=$((${issuedTime}+3590))

    local jsonKeyFile="${4}"

    jq -cn \
        --arg iss $serviceAccount \
        --arg sub $subscriber \
        --arg scp $scopeUrl \
        --arg aud $audienceUrl \
        --arg exp $expiryTime \
        --arg iat $issuedTime \
        '{iss: $iss, sub: $sub, scope: $scp, aud: $aud, exp: $exp, iat: $iat}' \
    | read -r jwtClaim

    jwtHeaderBase64=$(echo -n ${jwtHeader} | base64 --wrap=0 | sed 's/+/-/g; s/\//_/g')
    jwtClaimBase64=$(echo -n ${jwtClaim} | base64 --wrap=0 | sed 's/+/-/g; s/\//_/g')

    tmp=`mktemp`
    echo -n "${jwtHeaderBase64}.${jwtClaimBase64}"  > ${tmp}

    jwtSignatureBase64=$(openssl dgst -sha256 -sign ${jsonKeyFile} ${tmp} | base64 --wrap=0 | sed 's/+/-/g; s/\//_/g')

    curl -s \
        --request POST \
        'https://oauth2.googleapis.com/token' \
        --header 'Content-Type: application/x-www-form-urlencoded' \
        -d "grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=${jwtHeaderBase64}.${jwtClaimBase64}.${jwtSignatureBase64}" \
    | read -r svAccAuthJson

    export svAccAuthJson
}

