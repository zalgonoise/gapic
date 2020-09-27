#!/bin/zsh
# Retrieve needed credentials
    # Define credentials output file path

    credFile=`realpath $0`
    export credFile=${credFile//bin\/gapic_creds.sh/data\/.api_creds}
    export credFileRefresh=${credFile//.api_creds/.api_refresh}
    export credFileAccess=${credFile//.api_creds/.api_access}
    export credFileParams=${credFile//.api_creds/.api_params}

checkCreds() {
    # Check Client ID variable

    if [ -f ${credFile} ]
    then
        source ${credFile}

        if ! [[ -z ${SAVED_CLIENTID} ]] \
        && ! [[ -z ${SAVED_CLIENTSECRET} ]]
        then
            clear
            echo -en "# Found saved ClientID: ${SAVED_CLIENTID}. Do you want to use this one? [y/n]\n~> "
            read -r savedOptClient
            clear
            if ! [[ ${savedOptClient} =~ "n" ]] \
            || ! [[ ${savedOptClient} =~ "N" ]]
            then
                CLIENTID=${SAVED_CLIENTID}
                CLIENTSECRET=${SAVED_CLIENTSECRET}
            fi
        fi

        if ! [[ -z ${SAVED_OAUTH2_SCOPE} ]]
        then
            clear
            echo -e "# Found saved OAuth scope: ${SAVED_OAUTH2_SCOPE}. Do you want to use this one? [y/n]\n~> "
            read -r savedOptScope
            clear
            if ! [[ ${savedOptScope} =~ "n" ]] \
            || ! [[ ${savedOptScope} =~ "N" ]]
            then
                OAUTH2_SCOPE=${SAVED_OAUTH2_SCOPE}


            fi
        fi

        if ! [[ ${savedOptClient} =~ "n" ]] \
        || ! [[ ${savedOptClient} =~ "N" ]] \
        || ! [[ ${savedOptScope} =~ "n" ]] \
        || ! [[ ${savedOptScope} =~ "N" ]] \
        && ! [[ -z ${SAVED_REFRESHTOKEN} ]] \
        || ! [[ -z ${SAVED_ACCESSTOKEN} ]]
        then
            REFRESHTOKEN=${SAVED_REFRESHTOKEN}
            ACCESSTOKEN=${SAVED_ACCESSTOKEN}
        fi

    fi

    if [ -z ${CLIENTID} ]
    then
        clear
        echo -en "# enter API Key or ClientID:\n~> "
        read -r CLIENTID
        cat << EOIF >> ${credFile}
SAVED_CLIENTID=${CLIENTID}
EOIF
        clear
    fi

    # Check Client Secret variable

    if [ -z ${CLIENTSECRET} ]
    then
        echo -en "# enter Client Secret:\n~> "
        read -r CLIENTSECRET
        cat << EOIF >> ${credFile}
SAVED_CLIENTSECRET=${CLIENTSECRET}
EOIF
        clear
    fi

    # Check Authorized Scope variable

    if [ -z ${OAUTH2_SCOPE} ]
    then
        echo -en "# enter Authorization Scope. Set \"a\" to default to https://www.googleapis.com/auth/admin.directory.user \n~> "
        read -r OAUTH2_SCOPE
        clear
    fi

    if [[ ${OAUTH2_SCOPE} == "a" ]]
    then
        OAUTH2_SCOPE='https://www.googleapis.com/auth/admin.directory.user'
    fi

    if [[ -f ${${credFile}} ]] \
    && ! [[ `grep "SAVED_OAUTH2_SCOPE=${OAUTH2_SCOPE}" ${credFile}` ]]
    then
        cat << EOIF >> ${credFile}
SAVED_OAUTH2_SCOPE=${OAUTH2_SCOPE}
EOIF
    fi

    export CLIENTID CLIENTSECRET OAUTH2_SCOPE
}


# Generate an offline access code via URL
# Ref [:1] https://developers.google.com/youtube/v3/live/guides/auth/installed-apps#Obtaining_Access_Tokens
# Ref [:2] https://developers.google.com/google-ads/api/docs/concepts/curl-example

offlineCode() {
    clientId="${CLIENTID}"
    accessScope="${OAUTH2_SCOPE}"
    accessScope=${accessScope//:/%3A}
    accessScope=${accessScope//\//%2F}

    urlString1='https://accounts.google.com/o/oauth2/auth?client_id='
    urlString2='&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&access_type=offline&prompt=consent&scope='

    urlGen=${urlString1}${clientId}${urlString2}${accessScope}

    echo ${urlGen}
}


# Checks for Access Token and Refresh Token

checkAccess() {

    if [ -f ${credFileRefresh} ]
    then
        source ${credFileRefresh}
        REFRESHTOKEN=${SAVED_REFRESHTOKEN}
    fi

    if [ -f ${credFileAccess} ]
    then
        source ${credFileAccess}
        ACCESSTOKEN=${SAVED_ACCESSTOKEN}
    fi



    if [ -z ${ACCESSTOKEN} ]
    then

        echo -e "# No Access Token found. Generating one: \n"

        if [ -z ${REFRESHTOKEN} ]
        then

            echo -en "# Please visit the URL below to generate an access code. Once authenticated you will be provided a code - paste it below: \n\n "

            offlineCode

            echo -en "\nOffline code\t~> "
            read -r OFFLINECODE

            clear

            sentRequest="curl -s \ \n    https://accounts.google.com/o/oauth2/token \ \n    -d code=${OFFLINECODE} \ \n    -d client_id=${CLIENTID} \ \n    -d client_secret=${CLIENTSECRET} \ \n    -d redirect_uri=urn:ietf:wg:oauth:2.0:oob \ \n    -d grant_type=authorization_code"

            echo -e "# Request sent:\n\n"
            echo -e "#########################\n"
            echo ${(qqq)sentRequest}
            echo -e "\n\n"
            echo -e "#########################\n"

            unset sentRequest

            curl -s \
            https://accounts.google.com/o/oauth2/token \
            -d code=${OFFLINECODE} \
            -d client_id=${CLIENTID} \
            -d client_secret=${CLIENTSECRET} \
            -d redirect_uri=urn:ietf:wg:oauth:2.0:oob \
            -d grant_type=authorization_code \
            | jq -c '.' | read -r authPayload
            
            if ! [[ `echo ${authPayload} | jq '.refresh_token'` =~ "null" ]] \
            && ! [[ `echo ${authPayload} | jq '.access_token'` =~ "null" ]]
            then 
                REFRESHTOKEN=`echo ${authPayload} | jq '.refresh_token'`
                ACCESSTOKEN=`echo ${authPayload} | jq '.access_token'`
                ACCESSTOKEN=${ACCESSTOKEN//\"/}

                export REFRESHTOKEN ACCESSTOKEN

                cat << EOIF > ${credFileRefresh}
SAVED_REFRESHTOKEN=${REFRESHTOKEN}
EOIF

                cat << EOIF > ${credFileAccess}
SAVED_ACCESSTOKEN=${ACCESSTOKEN}
EOIF

                echo -e "# Execution complete!\n\n"
                echo -e "#########################\n"
                echo "${authPayload}" | jq '.'
                echo -e "\n\n"
                echo -e "#########################\n"
            else
                echo -e "# Error in the authentication!\n\n"
                echo -e "#########################\n"
                echo "${authPayload}" | jq '.'
                echo -e "\n\n"
                echo -e "#########################\n"
                exit 1
            fi

        else
            # get a new Access Token with Refresh Token
            # https://developers.google.com/identity/protocols/oauth2/web-server#httprest_7


            sentRequest="curl -s \ \n    --request POST \ \n    -d client_id=${CLIENTID} \ \n    -d client_secret=${CLIENTSECRET} \ \n    -d refresh_token=${REFRESHTOKEN} \ \n    -d grant_type=refresh_token \ \n    \"https://accounts.google.com/o/oauth2/token\""

            echo -e "# Request sent:\n\n"
            echo -e "#########################\n"
            echo "${sentRequest}"
            echo -e "\n\n"
            echo -e "#########################\n"

            unset sentRequest


            curl -s \
            --request POST \
            -d client_id=${CLIENTID} \
            -d client_secret=${CLIENTSECRET} \
            -d refresh_token=${REFRESHTOKEN} \
            -d grant_type=refresh_token \
            "https://accounts.google.com/o/oauth2/token" \
                | jq -c '.' \
                | read -r authPayload

            if ! [[ `echo ${authPayload} | jq '.access_token'` =~ "null" ]]
            then 
                ACCESSTOKEN=`echo ${authPayload} | jq '.access_token'`
                ACCESSTOKEN=${ACCESSTOKEN//\"/}

                export ACCESSTOKEN

                cat << EOIF > ${credFileAccess}
SAVED_ACCESSTOKEN=${ACCESSTOKEN}
EOIF
                echo -e "# Execution complete!\n\n"
                echo -e "#########################\n"
                echo "${authPayload}" | jq '.'
                echo -e "\n\n"
                echo -e "#########################\n"
            else
                echo -e "# Error in the authentication!\n\n"
                echo -e "#########################\n"
                echo "${authPayload}" | jq '.'
                echo -e "\n\n"
                echo -e "#########################\n"
                exit 1
            fi

        fi

    fi

}
