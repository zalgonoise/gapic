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

## TODO
# test deployment
# doublecheck parameter parsing
# handling post requests (w/ presets & jq)

gapicVersion="0.5-beta"

startTimestamp=`date +%s`

gapicBuildLogEntry() {
    buildLogGithubUrl="https://github.com/ZalgoNoise/gapic/"
    buildLogLatestCommit=`git rev-parse --verify HEAD`
    buildLogBranch=`git branch --show-current`
    buildLogUser=`git config user.name`

    jq -cn \
    --arg ghcid ${buildLogLatestCommit} \
    --arg ghurl "${buildLogGithubUrl}commit/${buildLogLatestCommit}" \
    --arg ghb ${buildLogBranch} \
    --arg ts ${startTimestamp} \
    --arg gvs ${gapicVersion} \
    '{timestamp: $ts, version: $gvs, github:{latestCommit: $ghcid, commitUrl: $ghurl, currentBranch: $ghb}, buildLog:{status: null, beginTimestamp: $ts, endTimestamp:null, buildTime:null, entries:[]}}' \
    | read -r buildLogPayload

    if [[ -z ${buildLogUser} ]]
    then 
        echo ${buildLogPayload} \
        | jq -c '.github.user=null' \
        | read -r buildLogPayload
    else
        echo ${buildLogPayload} \
        | jq -c ".github.user=\"${buildLogUser}\"" \
        | read -r buildLogPayload
    fi

    export buildLogPayload

}

gapicLogger() {
    logGroup="${1}"
    logSet="${2}"
    logSep="${3}"
    logStatus="${4}"
    logMessage="${5}"

    logTimestamp=`date +%s`

    echo -e "[`date +%y-%m-%d`][`date +%H-%M-%S`.`printf "%03d" "$(($(date +%N)/1000000))"`][${logGroup}][$logSet]${logSep}[${logStatus}] # ${logMessage}" 

    jq -cn \
    --argjson ts ${logTimestamp} \
    --arg loggroup ${1} \
    --arg logset ${2} \
    --arg logstatus ${4// /} \
    --arg logmsg ${6:-${5}} \
    '{timestamp: $ts, status: $logstatus, info:{group: $loggroup, set: $logset, description: $logmsg}, error:null}' \
    | read -r logEntryPayload

    if ! [[ -z ${7} ]] \
    && ! [[ -z ${8} ]]
    then
        jq -cn \
        --arg err ${7} \
        --arg errmsg ${8} \
        '{error:null,errorMessage:null}' \
        | read -r errorPayload

        echo ${logEntryPayload} \
        | jq -c ".error=${errorPayload}" \
        | read -r newLogEntryPayload

        if [[ `echo ${newLogEntryPayload} | jq -c ` ]]
        then 
            logEntryPayload=${newLogEntryPayload}
        fi

    fi

    echo ${buildLogPayload} \
    | jq -c ".buildLog.entries=[.buildLog.entries[],${logEntryPayload}]" \
    | read -r newBuildPayload

    if [[ `echo ${newBuildPayload} | jq -c `  ]]
    then
        buildLogPayload=${newBuildPayload}
    fi


}

buildLogUpdate() {
    echo ${buildLogPayload} \
    | jq -c "${1}=${2}" \
    | read -r newBuildPayload

    if [[ `echo ${newBuildPayload} | jq -c `  ]]
    then
        buildLogPayload=${newBuildPayload}
    fi
}

buildLogPush() {
    if ! [[ -f ${outputLogDir}/buildLog.json ]]
    then 
        echo ${buildLogPayload} \
        | jq '.=[.]' \
        > ${outputLogDir}/buildLog.json
    else
        if [[ `cat ${outputLogDir}/buildLog.json | jq -c ` ]]
        then 
            cat ${outputLogDir}/buildLog.json \
            | jq -c ".=[${buildLogPayload},.[]]"\
            | read -r buildHistoryPayload

            if [[ `echo ${buildHistoryPayload} | jq -c ` ]]
            then 
                echo ${buildHistoryPayload} \
                | jq \
                > ${outputLogDir}/buildLog.json
            fi
        else            
            echo ${buildLogPayload} \
            | jq '.=[.]' \
            > ${outputLogDir}/buildLog.json
        fi            
    fi

}

# Build log entry
gapicBuildLogEntry

if ! [[ -z ${1} ]]
then
    inputFile=`realpath $1`
fi

inputSchemaUrl="https://www.googleapis.com/discovery/v1/apis/admin/directory_v1/rest"
output=`realpath $0`
output=${output//gapic.sh/}

outputSrcDir="${output}src/"
outputBinDir="${output}src/bin"
outputDataDir="${output}src/data"
outputLogDir="${output}src/log"
outputCredsDir="${output}src/data/.creds"
outputSchemaDir="${output}src/schema"

if ! [[ -d ${outputLogDir} ]]
then
    mkdir -p ${outputLogDir}
fi

#Log message
gapicLogger "ENGINE" "INIT" '\t\t' " OK " "# # gapic init # # #" "Build started."
gapicLogger "ENGINE" "VARIABLES" '\t' "INFO" "Preparing variables."



outputCredsWiz="${outputBinDir}/gapic_creds.sh"
outputLibWiz="${outputBinDir}/gapic_lib.sh"
outputExecWiz="${outputBinDir}/gapic_exec.sh"
outputParamStoreWiz="${outputBinDir}/gapic_paramstore.sh"
outputFuzzWiz="${outputBinDir}/gapic_fuzzex.sh"
outputHistWiz="${outputBinDir}/gapic_history.sh"
outputPostWiz="${outputBinDir}/gapic_post.sh"

defaultSchemaFile="${outputSchemaDir}/gapic_AdminSDK_Directory.json"

#Log message
gapicLogger "ENGINE" "DIRECTORIES" '\t' "INFO" "Setting up directories."



if ! [ -d ${outputSrcDir} ]
then
    mkdir -p ${outputSrcDir}
fi

if ! [ -d ${outputBinDir} ]
then
    mkdir -p ${outputBinDir}
fi

if ! [ -d ${outputDataDir} ]
then
    mkdir -p ${outputDataDir}
fi

if ! [ -d ${outputLogDir} ]
then
    mkdir -p ${outputLogDir}
fi

if ! [ -d ${outputSchemaDir} ]
then
    mkdir -p ${outputSchemaDir}
fi

if ! [ -d ${outputCredsDir} ]
then
    mkdir -p ${outputCredsDir}
fi

#Log message
gapicLogger "ENGINE" "SOURCE" '\t' "INFO" "Setting up source files."

if ! [ -f ${outputCredsWiz} ] \
|| ! [ -f ${outputLibWiz} ] \
|| ! [ -f ${outputExecWiz} ] \
|| ! [ -f ${outputParamStoreWiz} ] \
|| ! [ -f ${outputFuzzWiz} ] \
|| ! [ -f ${outputHistWiz} ]
then
    touch ${outputCredsWiz} ${outputLibWiz} ${outputExecWiz} ${outputParamStoreWiz} ${outputFuzzWiz} ${outputHistWiz} ${outputPostWiz}
fi

if ! [ -f ${outputLogDir}/requests.json ]
then
    echo "[]" > ${outputLogDir}/requests.json
fi

apacheLicense() {
    cat << EOF
#!/bin/zsh
#   Copyright `date +%Y` ZalgoNoise
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

EOF
}



# Prepare output file with exec functions

#Log message
gapicLogger "ENGINE" "EXEC" '\t\t' "INFO" "Creating gapic executable under: ${outputExecWiz}"

apacheLicense > ${outputExecWiz}

cat << EOF >> ${outputExecWiz}


# Bootstrap by importing wizard files

    gapicBinDir=\`realpath \$0\`
    gapicBinDir=\${gapicBinDir//gapic_exec.sh/}
    gapicDataDir=\${gapicBinDir//bin/data}
    gapicCredsDir=\${gapicBinDir//bin/data\/.creds}
    gapicSchemaDir=\${gapicBinDir//bin/schema}
    gapicLogDir=\${gapicBinDir//bin/log}
    gapicReqLog=requests.json
    
    schemaFileArray=( \`find \${gapicSchemaDir} -type f\` )
    uniqueSchemas=( \`echo \${schemaFileArray} | sed "s|\${gapicSchemaDir}||g" | sed 's/.json//g' | sed 's/_[[:digit:]]//g' | sed 's/ /\\n/g' | sort -u \` )

    for (( s = 1 ; s <= \${#uniqueSchemas[@]} ; s++ ))
    do
        schemaFileSet+=( "\${gapicSchemaDir}\${uniqueSchemas[\${s}]}.json" )
    done

    gapicCredsWiz="\${gapicBinDir}gapic_creds.sh"
    gapicLibWiz="\${gapicBinDir}gapic_lib.sh"
    gapicParamWiz="\${gapicBinDir}gapic_paramstore.sh"
    gapicFuzzWiz="\${gapicBinDir}gapic_fuzzex.sh"
    gapicHistWiz="\${gapicBinDir}gapic_history.sh"
    gapicPostWiz="\${gapicBinDir}gapic_post.sh"

gapicMenu() {
    echo \${uniqueSchemas} "Fuzzy_History" \\
    | gapicFuzzyMenu \\
    | read -r gapicMenuOpt

    if [[ \${gapicMenuOpt} == "Fuzzy_History" ]]
    then
        cat \${gapicLogDir}\${gapicReqLog} \\
        | gapicFuzzyHistory \${gapicLogDir}\${gapicReqLog} \\
        | read -r histPayload

        if [[ \`echo \${histPayload} | jq -c \` ]]
        then
            histReplayRequest "\${histPayload}"
            exit 0
        fi

    else
        schemaFile=\${gapicSchemaDir}\${gapicMenuOpt}.json
        schemaRef=\`cat \${schemaFile} | jq '. | "\(.title) \(.version)"'\`
    fi

}

gapicBootstrap() {
    if ! [[ -d \${gapicBinDir} ]]
    then 
        mkdir -p \${gapicBinDir}
    fi

    if ! [[ -d \${gapicDataDir} ]]
    then 
        mkdir -p \${gapicDataDir}
    fi

    if ! [[ -f \${gapicCredsWiz} ]]
    then
        clear
        echo -en "# No credentials source file found! Please re-run the generator."
        exit 1
    else
        source \${gapicCredsWiz}
    fi

    if ! [[ -f \${gapicLibWiz} ]]
    then
        clear
        echo -en "# No API library source file found! Please re-run the generator."
        exit 1
    else
        source \${gapicLibWiz}
    fi

    if ! [[ -f \${gapicParamWiz} ]]
    then
        clear
        echo -en "# No parameter store source file found! Please re-run the generator."
        exit 1
    else
        source \${gapicParamWiz}
    fi

    if ! [[ -f \${gapicFuzzWiz} ]]
    then
        clear
        echo -en "# No FuzzEx source file found! Please re-run the generator."
        exit 1
    else
        source \${gapicFuzzWiz}
    fi

    if ! [[ -f \${gapicHistWiz} ]]
    then
        clear
        echo -en "# No Request History source file found! Please re-run the generator."
        exit 1
    else
        source \${gapicHistWiz}
    fi

    if ! [[ -f \${gapicPostWiz} ]]
    then
        clear
        echo -en "# No Post Request source file found! Please re-run the generator."
        exit 1
    else
        source \${gapicPostWiz}
    fi
}

# Check for existing credentials and access token

gapicCreds() {

    checkCreds 
    checkScopes "\${1}" "\${2}" "\${3}" "\${credPath}/\${fileRef}"

}

# Execute the API request

gapicExec() {

    # Display available methods
    if [[ -z \${gapicSets} ]]
    then
        clear
        echo -en "# No API sets found in the source file! Please re-run the generator."
        exit 1
    else
        clear

        echo \${gapicSets} \\
        | gapicFuzzyResources \${schemaFile} \\
        | read -r option
        
        if ! [[ -n \${option} ]]
        then
            gapicFuzzySchema \${schemaFile}
            exit
        else
            setOption=\${option}
            clear
            unset option
        fi
        
    fi

    if [[ -z \${(P)setOption[@]} ]]
    then
        clear
        echo -en "# No API methods found in the source file! Please re-run the generator."
        exit 1
    else
        echo \${(P)setOption[@]} \\
        | gapicFuzzyMethods \${schemaFile} \${setOption} \\
        | read -r option

        if ! [[ -n \${option} ]]
        then
            gapicFuzzySchema \${schemaFile}
            exit
        else
            methOption=\${option}
            clear
            unset option
        fi

    fi

    gapicCreds "\${setOption}" "\${methOption}" \${schemaFile}

    execOption=\${setOption}_\${methOption}

    \${execOption}

    if ! [[ -z \${outputJson} ]]
    then
        gapicPostExec
    else
        echo -e "# No JSON output, please debug.\n\n"
    fi
}

# Catch exceptions and handle errors

gapicPostExec() {


    if ! [[ \`echo \${outputJson} | jq '.error' | grep null\` ]]
    then
        if [[ \`echo \${outputJson} | jq '.error.code'\` =~ "401" ]] \\
        && [[ \`echo \${outputJson} | jq '.error.errors[].message'\` =~ "Invalid Credentials" ]]
        then
            if ! [[ \`cat "\${credPath}/\${fileRef}" | jq -r ".authScopes |  map(select(.scopeUrl == \"\${requestScope}\").accessToken) | .[]"\` == "null" ]]
            then
                echo -e "# Invalid Credentials error.\n\n# Removing Access Token to generate a new one:\n\n"
                
                mvCreds "\${credPath}/\${fileRef}"  "scopeUrl" "\${requestScope}" "accessToken" "null"
                rebuildAuth "\${credPath}/\${fileRef}" 

                echo -e "# Repeating previously configured request:\n\n"
                execRequest

                ((repeatCount++))
                if ! [[ \${repeatCount} -ge 2 ]]
                then
                    gapicPostExec
                else
                    echo "# Unable to authenticate with the provided credentials. Please relaunch and reauthenticate yourself.\n\n"
                    exit 1
                fi

            elif [[ \`cat "\${credPath}/\${fileRef}" | jq -r ".authScopes |  map(select(.scopeUrl == \"\${requestScope}\").accessToken) | .[]"\` == "null" ]] \\
            && ! [[ \`cat "\${credPath}/\${fileRef}" | jq -r ".authScopes |  map(select(.scopeUrl == \"\${requestScope}\").refresh) | .[]"\` == "null" ]]
            then
                echo -e "# Invalid Credentials error.\n\n# Removing Refresh Token and generating a new one:\n\n"

                mvCreds "\${credPath}/\${fileRef}"  "scopeUrl" "\${requestScope}" "refreshToken" "null"
                buildAuth "\${credPath}/\${fileRef}"
                
                echo -e "# Repeating previously configured request:\n\n"
                execRequest

                ((repeatCount++))
                if ! [[ \${repeatCount} -ge 2 ]]
                then
                    gapicPostExec
                else
                    echo "# Unable to authenticate with the provided credentials. Please relaunch and reauthenticate yourself.\n\n"
                    exit 1
                fi

            else
                echo -e "# Error in execution: Invalid Credentials\n\n"
                echo "\${outputJson}"
                echo -e "\n\n"
                exit 1
            fi

        else
            echo -e "# Error in execution:\n\n"
            echo "\${outputJson}"
            echo -e "\n\n"
            exit 1
        fi
    else
        unset requestId
        echo -e "# Execution complete!\n\n"
        echo -e "#########################\n"
        echo "\${outputJson}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
        exit 0

    fi

}



# Main function

main() {
    gapicBootstrap
    gapicMenu
    gapicExec
}

# Execution starts below
main
EOF





# Prepare output file with auth functions

#Log message
gapicLogger "ENGINE" "EXEC" '\t\t' "INFO" "Creating gapic credentials wizard under: ${outputCredsWiz}"

apacheLicense > ${outputCredsWiz}

cat << EOF >> ${outputCredsWiz}
# Retrieve needed credentials
    # Define credentials output file path

    credPath=\`realpath \$0\`
    export credPath=\${credPath//bin\/gapic_creds.sh/data\/.creds}


    credFile=\`realpath \$0\`
    export credFileParams=\${credFile//bin\/gapic_creds.sh/data\/.api_params}

clientCreate() {
    jq -cn \\
    --arg cid "\${1}" \\
    --argjson cs null \\
    '{clientId: \$cid, clientSecret: \$cs, authScopes: [ ]}' \\
    | read newClient

    local clientName=\`echo \${1//-/ } | awk '{print \$1}' \`

    echo \${newClient} | jq '.' > \${credPath}/\${clientName}
}

scopeCreate() {
    cat \${3} \\
    | fuzzExCreateScopes "Which scope do you want to authorize?" "\${1}" "\${2}" "\${3}" \\
    | read -r requestScope

    clientScopes=\${requestScope}


    if ! [[ -z \${requestScope} ]]
    then
        export requestScope clientScopes

        activeScopesArr=( \`cat \${4} | jq -c ".authScopes[]" \` )
        activeIndex=\${#activeScopesArr}


        jq -cn \\
        --arg scp \${requestScope} \\
        --argjson rt null \\
        --argjson at null \\
        '{scopeUrl: \$scp, refreshToken: \$rt, accessToken: \$at}' \\
        | read -r newScope


        tmp=\`mktemp\`

        cat \${4} \\
        | jq ".authScopes=[.authScopes[],\${newScope}]" \\
        > \${tmp}

        if [[ \`cat \${tmp} | jq -c \` ]]
        then
            mv \${tmp} \${4}
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


    requestClientID=\`cat \${1} | jq -r '.clientId'  \`
    requestClientSecret=\`cat \${1} | jq -r '.clientSecret' \`

    if [[ -z \${requestScope} ]] \\
    && ! [[ -z \${2} ]]
    then
        export requestScope=\`cat \${1} | jq -r ".authScopes[\${2}].scopeUrl" \`
    fi

    requestScopeCode=\${requestScope//:/%3A}
    requestScopeCode=\${requestScopeCode//\\//%2F}

    export CLIENTID=\${requestClientID}

    urlString1='https://accounts.google.com/o/oauth2/auth?client_id='
    urlString2='&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&access_type=offline&prompt=consent&scope='

    urlGen=\${urlString1}\${requestClientID}\${urlString2}\${requestScopeCode}

    echo \${urlGen}

    echo -en "\nOffline code\t~> "
    read -r offlineCode
    clear

    export sentAuthRequest="curl -s \\ \n    https://accounts.google.com/o/oauth2/token \\ \n    -d code=\${offlineCode} \\ \n    -d client_id=\${requestClientID} \\ \n    -d client_secret=\${requestClientSecret} \\ \n    -d redirect_uri=urn:ietf:wg:oauth:2.0:oob \\ \n    -d grant_type=authorization_code"
    
    echo -e "# Request sent:\n\n"
    echo -e "#########################\n"
    echo "\${sentAuthRequest}"
    echo -e "\n\n"
    echo -e "#########################\n"
    export sentAuthRequest="curl -s https://accounts.google.com/o/oauth2/token -d code=\${offlineCode} -d client_id=\${requestClientID} -d client_secret=\${requestClientSecret} -d redirect_uri=urn:ietf:wg:oauth:2.0:oob -d grant_type=authorization_code"


    curl -s \\
    https://accounts.google.com/o/oauth2/token \\
    -d code=\${offlineCode} \\
    -d client_id=\${requestClientID} \\
    -d client_secret=\${requestClientSecret} \\
    -d redirect_uri=urn:ietf:wg:oauth:2.0:oob \\
    -d grant_type=authorization_code \\
    | jq -c '.' | read -r authPayload

    export authPayload

    tmp=\`mktemp\`

    
    if ! [[ \`echo \${authPayload} | jq -r '.refresh_token' \` == "null" ]] \\
    && ! [[ \`echo \${authPayload} | jq -r '.access_token' \` == "null" ]]
    then 
        authRefreshToken=\`echo \${authPayload} | jq -r '.refresh_token' \`
        authAccessToken=\`echo \${authPayload} | jq  -r '.access_token' \`

        export ACCESSTOKEN=\${authAccessToken}
        export REFRESHTOKEN=\${authRefreshToken}

        mvCreds "\${1}" "scopeUrl" "\${requestScope}" "refreshToken" "\"\${REFRESHTOKEN}\"" 
        mvCreds "\${1}" "scopeUrl" "\${requestScope}" "accessToken" "\"\${ACCESSTOKEN}\"" 



        echo -e "# Execution complete!\n\n"
        echo -e "#########################\n"
        echo "\${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
    elif [[ \`echo \${authPayload} | jq  -r '.error'  \` == "invalid_grant" ]]
    then

        mvCreds "\${1}" "scopeUrl" "\${requestScope}" "refreshToken" "null" 

        echo -e "# Invalid Refresh Token! Relaunch the tool.\n\n"
        echo -e "#########################\n"
        echo "\${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
        exit 1

    else
        echo -e "# Error in the authentication!\n\n"
        echo -e "#########################\n"
        echo "\${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
        rm \${tmp}
        exit 1
    fi
}

rebuildAuth() {
    # get a new Access Token with Refresh Token
    # https://developers.google.com/identity/protocols/oauth2/web-server#httprest_7
     
    requestClientID=\`cat \${1} | jq -r '.clientId' \`
    requestClientSecret=\`cat \${1} | jq -r '.clientSecret' \`

    if [[ -z \${REFRESHTOKEN} ]]
    then
        requestRefreshToken=\`cat \${1} | jq -r ".authScopes[\${2}].refreshToken" \`
        export REFRESHTOKEN=\${requestRefreshToken}
    fi

    if [[ -z \${requestScope} ]]
    then
        export requestScope=\`cat \${1} | jq -r ".authScopes[\${2}].scopeUrl"  \`
    fi

    export CLIENTID=\${requestClientID}

    export sentAuthRequest="curl -s \\ \n    --request POST \\ \n    -d client_id=\${requestClientID} \\ \n    -d client_secret=\${requestClientSecret} \\ \n    -d refresh_token=\${REFRESHTOKEN} \\ \n    -d grant_type=refresh_token \\ \n    \"https://accounts.google.com/o/oauth2/token\""

    echo -e "# Request sent:\n\n"
    echo -e "#########################\n"
    echo "\${sentAuthRequest}"
    echo -e "\n\n"
    echo -e "#########################\n"
    export sentAuthRequest="curl -s --request POST -d client_id=\${requestClientID} -d client_secret=\${requestClientSecret} -d refresh_token=\${REFRESHTOKEN} -d grant_type=refresh_token https://accounts.google.com/o/oauth2/token"

    curl -s \\
    --request POST \\
    -d client_id=\${requestClientID} \\
    -d client_secret=\${requestClientSecret} \\
    -d refresh_token=\${REFRESHTOKEN} \\
    -d grant_type=refresh_token \\
    "https://accounts.google.com/o/oauth2/token" \\
        | jq -c '.' \\
        | read -r authPayload

    export authPayload

    tmp=\`mktemp\`

    if ! [[ \`echo \${authPayload} | jq '.access_token'\` == "null" ]]
    then 
        authAccessToken=\`echo \${authPayload} | jq -r '.access_token' \`

        export ACCESSTOKEN=\${authAccessToken}

        mvCreds "\${1}" "scopeUrl" "\${requestScope}" "accessToken" "\"\${ACCESSTOKEN}\"" 


        echo -e "# Execution complete!\n\n"
        echo -e "#########################\n"
        echo "\${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
    elif [[ \`echo \${authPayload} | jq -r '.error'  \` == "invalid_grant" ]]
    then

        mvCreds "\${1}" "scopeUrl" "\${requestScope}" "refreshToken" "null"


        echo -e "# Invalid Refresh Token! Relaunch the tool.\n\n"
        echo -e "#########################\n"
        echo "\${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
        exit 1
    else
        echo -e "# Error in the authentication!\n\n"
        echo -e "#########################\n"
        echo "\${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
        rm \${tmp}
        exit 1
    fi

}

checkScopeAccess() {
    cat \${2} \\
    | jq -c ".authScopes[\${1}]" \\
    | read -r accessCheckJson

    if [[ \`echo \${accessCheckJson} | jq ".refreshToken"| sed 's/"//g' \` == null ]] \\
    && [[ \`echo \${accessCheckJson} | jq ".accessToken" | sed 's/"//g' \` == null ]]
    then
        buildAuth "\${2}" "\${1}" 

    elif [[ \`echo \${accessCheckJson} | jq ".refreshToken" | sed 's/"//g' \` != null ]] \\
    && [[ \`echo \${accessCheckJson} | jq ".accessToken" | sed 's/"//g' \` == null ]]
    then
        rebuildAuth  "\${2}" "\${1}"
    else
        export ACCESSTOKEN="\`echo \${accessCheckJson} | jq '.accessToken' | sed 's/"//g' \`"
        export REFRESHTOKEN="\`echo \${accessCheckJson} | jq '.refreshToken' | sed 's/"//g' \`"
        export requestScope="\`echo \${accessCheckJson} | jq '.scopeUrl' | sed 's/"//g' \`"

    fi

}

clientCheck() {
    export fileRef=\`echo \${1} | jq '.clientId' | sed 's/-/ /' | awk '{print \$1}' | sed 's/"//g' \`
    local clientId=\`echo \${1} | jq '.clientId' | sed 's/"//g' \`
    local clientSecret=\`echo \${1} | jq '.clientSecret' | sed 's/"//g' \`

    export CLIENTID=\${clientId}
    export CLIENTSECRET\${clientSecret}

    local tmp=\`mktemp\`

    if [[ \${clientSecret} == null ]]
    then
        fuzzExInputCreds "Enter your Client Secret for \${clientId}" \\
        | read clientSecret

        cat \${credPath}/\${fileRef} \\
        | jq ".clientSecret=\"\${clientSecret}\"" \\
        > \${tmp}

        if [[ \`cat \${tmp} | jq '.' \` ]]
        then 
            mv \${tmp} \${credPath}/\${fileRef}
        fi
    fi
}

checkCreds() {
    # Check for existing client IDs

    if [[ \`find \${credPath} -type f\` ]] \\
    && [[ -z \${clientJson} ]]
    then 
        ls \${credPath}/ \\
        | fuzzExSavedCreds "Re-use any of these ClientIDs?" "\${credPath}" \\
        | read -r clientJson

        if [[ -z \${clientJson} ]]
        then
            fuzzExInputCreds "Enter your ClientID" \\
            | read clientId

            if [[ -z \${clientId} ]]
            then
                ((noClientCounter++))
                
                if [[ \${noClientCounter} -gt 3 ]]
                then
                    exit 1
                fi
                checkCreds
            fi

            clientCreate "\${clientId}"
            checkCreds

        fi

        clientCheck "\${clientJson}"

    else 
        fuzzExInputCreds "Enter your ClientID" \\
        | read clientId

        if [[ -z \${clientId} ]]
        then
            ((noClientCounter++))
            
            if [[ \${noClientCounter} -gt 3 ]]
            then
                exit 1
            fi
            checkCreds
        fi

        clientCreate "\${clientId}"
        checkCreds
    fi

    export clientJson
}

##  rmCreds(): Deprecated ~ test and remove
rmCreds() {
    tmp=\`mktemp\`

    cat \${1} \\
    | jq -c ".authScopes | map(select(.\${2} == \"\${3}\").\${2} |= null" \\
    | read -r newAuthScopes

    cat \${1} \\
    | jq ".authScopes=\${newAuthScopes}" \\
    > \${tmp}

    if [[ \`cat \${tmp} | jq -c \` ]]
    then
        mv \${tmp} \${1}
    fi
}
####


mvCreds() {
    tmp=\`mktemp\`

    cat \${1} \\
    | jq -c ".authScopes | map(select(.\${2} == \"\${3}\").\${4} |= \${5})" \\
    | read -r newAuthScopes

    cat \${1} \\
    | jq ".authScopes=\${newAuthScopes}" \\
    > \${tmp}

    if [[ \`cat \${tmp} | jq -c \` ]]
    then
        mv \${tmp} \${1}
    fi
}

scopeLookup() {
    for (( i = 1 ; i <= \${(P)#1[@]} ; i++ ))
    do
        for (( a = 1 ; a <= \${(P)#2[@]} ; a++ ))
        do
            if [[ \` echo "\${(P)1[\${i}]}" | jq -c '.scopeUrl' | sed 's/\"//g' \` == "\${(P)2[\${a}]}" ]]
            then
                scopeIndex+=( \` cat \${credPath}/\${fileRef} | jq -c ".authScopes[((\${i}-1))]" \` )
                scopeIndexNo+=( \$((\${i}-1)) )
            fi
        done
    done

    export scopeIndex
    export scopeIndexNo
}


checkScopes() {
    availableScopes=( \`cat \${3} | jq  ".resources.\${1}.methods.\${2}.scopes[]" | sed 's/\"//g' \` )
    savedScopes=( \`cat \${4} | jq -c '.authScopes[]'  \` )
    scopeIndex=( )
    scopeIndexNo=( )

    if [[ -z \${savedScopes} ]]
    then
        scopeCreate "\${1}" "\${2}" "\${3}" "\${4}"
        savedScopes=( \`cat \${4} | jq -c '.authScopes[]'\` )

    fi

    if [[ -z \${activeIndex} ]]
    then

        scopeLookup "savedScopes" "availableScopes"
    
        if [[ -z \${scopeIndex[@]} ]] \\
        || [[ \${#savedScopes[@]} -lt \${#availableScopes[@]} ]] \\
        || [[ \${#scopeIndex[@]} -gt 1 ]]
        then
            echo \${scopeIndex[@]} \\
            | fuzzExSavedScopes "Re-use any of these OAuth Scopes?" "\${4}" \\
            | read -r clientScopes

            if [[ -z \${clientScopes} ]]
            then
                if [[ \${#savedScopes[@]} -eq \${#availableScopes[@]} ]]
                then
                    echo \${scopeIndex[@]} \\
                    | fuzzExSavedScopes "Can't add any more scopes to this method. Re-use any?" "\${4}" \\
                    | read -r clientScopes

                    if [[ -z \${clientScopes} ]]
                    then 
                        exit 1
                    fi
                elif [[ \${#savedScopes[@]} -lt \${#availableScopes[@]} ]]
                then
                    scopeCreate "\${1}" "\${2}" "\${3}" "\${4}"
                    savedScopes=( \`cat \${4} | jq -c '.authScopes[]'\` )
                    scopeLookup "savedScopes" "availableScopes"
                fi
            fi
            
            for (( i = 1 ; i <= \${#scopeIndex[@]} ; i++ ))
            do
                if [[ \`echo \${scopeIndex[\${i}]} | jq '.scopeUrl' | sed 's/"//g' \` == \${clientScopes} ]]
                then
                    activeIndex=\${scopeIndexNo[\${i}]}
                    checkScopeAccess "\${activeIndex}" "\${4}"
                fi
            done
            
        else
            activeIndex=\${scopeIndexNo}
            checkScopeAccess "\${activeIndex}" "\${4}"
        fi
    else
        checkScopeAccess "\${activeIndex}" "\${4}"

    fi
}

EOF

# Create Parameter Store file

#Log message
gapicLogger "ENGINE" "EXEC" '\t\t' "INFO" "Creating gapic parameter store wizard under: ${outputCredsWiz}"


apacheLicense > ${outputParamStoreWiz}

cat << EOF >> ${outputParamStoreWiz}

# param-store v2 (json)

### must validate whether object already exists
### to either call getParams() or checkParams()

genParamConfig() {
    cat \${credPath}/\${fileRef} \\
    | jq -c '.param=[]' \\
    | read -r newPayload

    if [[ \`echo \${newPayload} | jq -c \` ]]
    then 
        echo \${newPayload} \\
        | jq \\
        > \${credPath}/\${fileRef}
    fi
}

paramsRevListBuild() {
    jq -c ".\${1}=[\${2},.\${1}[]]" \\
    | read -r requestPayload

    echo \${requestPayload}
}

paramBuild() {
    echo \${3} \\
    | paramsRevListBuild "\${1}" "\"\${2}\"" \\
    | read -r paramNewEntry

    cat \${credPath}/\${fileRef} \\
    | jq -c ".param=[.param[],\${paramNewEntry}]" \\
    | read -r newParamPayload

    if [[ \`echo \${newParamPayload} | jq -c \` ]]
    then 
        echo \${newParamPayload} \\
        | jq \\
        > \${credPath}/\${fileRef}
    fi

}

addParams() {
    keyValue=( \`cat \${3} | jq -r ".param[] | keys[] " \` )

    for (( index = 1 ; index <= \${#keyValue[@]} ; index++ ))
    do
        if [[ "\${keyValue[\${index}]}" == "\${1}" ]]
        then 
            keyIndex=\$((\${index}-1))
        fi
    done

    modParams=( \`cat \${3} | jq -r ".param[] | select(.\${1})[] | .[]" \` )

    newList="[\"\${2}\"]"

    for (( par = 1 ; par <= \${#modParams[@]} ; par++ ))
    do 
        echo \${newList} \\
        | jq -c ".=[.[],\"\${modParams[\${par}]}\"]" \\
        | read -r newList
    done

    cat \${3} \\
    | jq -c ".param[\${keyIndex}].\${1}=\${newList}" \\
    | read -r newParamPayload
    
    if [[ \`echo \${newParamPayload} | jq -c \` ]]
    then 
        echo \${newParamPayload} \\
        | jq \\
        > \${3}
    fi

}

# Handle parameter removal

rmParams() {
    keyValue=( \`cat \${3} | jq -r ".param[] | keys[] " \` )

    for (( index = 1 ; index <= \${#keyValue[@]} ; index++ ))
    do
        if [[ "\${keyValue[\${index}]}" == "\${1}" ]]
        then 
            keyIndex=\$((\${index}-1))
        fi
    done

    modParams=( \`cat \${3} | jq -r ".param[] | select(.\${1})[] | .[]" | grep -v "\${2}"\` )

    newList="[]"

    for (( par = 1 ; par <= \${#modParams[@]} ; par++ ))
    do 
        echo \${newList} \\
        | jq -c ".=[.[],\"\${modParams[\${par}]}\"]" \\
        | read -r newList
    done

    cat \${3} \\
    | jq -c ".param[\${keyIndex}].\${1}=\${newList}" \\
    | read -r newParamPayload
    
    if [[ \`echo \${newParamPayload} | jq -c \` ]]
    then 
        echo \${newParamPayload} \\
        | jq \\
        > \${3}
    fi

}



getParams() {
    local sourceRef=\${1}
    local tempPar=\${2}
    local urlVar=\${3}
    local apiRef=(\`echo \${sourceRef//_/ }\` )
    local tempMeta="\${2}Meta"

    jq -cn \\
    "{\${tempPar}:[]}" \\
    | read -r paramPayload

    if [[ -z \${(P)\${tempMeta}[3]} ]]
    then
        echo -en "# Please supply a value for the \${tempPar} parameter (\${(P)\${tempMeta}[1]}).\n#\n# Desc: \${(P)\${tempMeta}[2]}\n~> "
        read -r getOption
        declare -g "tempVal=\${getOption}"
        unset getOption 
        clear

    else
        tempOpts=(\`echo \${(P)\${tempMeta}[3]} | jq -r ".[]"\`)
        echo -en "# Please supply a value for the \${tempPar} parameter (\${(P)\${tempMeta}[1]}).\n#\n# Desc: \${(P)\${tempMeta}[2]}\n~> "
        
        echo "\${tempOpts}" \\
        | fuzzExOptParameters "\${apiRef[1]}" "\${apiRef[2]}" "\${tempPar}" \\
        | read -r getOption

        if [[ -n \${getOption} ]]
        then
            declare -g "tempVal=\${getOption}"
            clear
        fi
        unset getOption 
    fi
    unset tempParMeta

    if ! [[ -z "\${tempVal}" ]]
    then

        declare -g "\${tempPar}=\${tempVal}"
        if [[ "\${urlVar}" =~ "true" ]]
        then
            declare -g "tempUrlPar=&\${tempPar}=\${(P)\${tempPar}}"
        fi

        addParams "\${tempPar}" "\${tempVal}" "\${credPath}/\${fileRef}"

    fi
    unset tempPar tempVal

}

# Handle saved parameters - v2 (json)

checkParams() {
    local sourceRef=\${1}
    local tempPar=\${2}
    local urlVar=\${3}

    local apiRef=(\`echo \${sourceRef//_/ }\` )

    echo -en "# You have saved values for the \${tempPar} parameter. Do you want to use one?\n\n"

    savedParams=( \`cat \${credPath}/\${fileRef} | jq -rc ".param[] | select(.\${tempPar})[] | .[]"\` )

    if ! [[ -z \${savedParams} ]]
    then 
        echo "\${savedParams[@]} [none]" \\
        | fuzzExSimpleParameters "\${apiRef[1]}" "\${apiRef[2]}" "\${tempPar}" \\
        | read -r checkOption
        
        if [[ -n \${checkOption} ]]
        then
            if [[ \${checkOption} == "[none]" ]]
            then
                clear
                unset checkOption
                getParams \${1} \${2} \${3}
            else
                clear
                declare -g "\${tempPar}=\${checkOption}"
                if [[ "\${urlVar}" == "true" ]]
                then
                    declare -g "tempUrlPar=&\${tempPar}=\${(P)\${tempPar}}"
                fi
                
                unset checkOption
            fi
        else
            getParams \${1} \${2} \${3}
        fi
    else
        getParams \${1} \${2} \${3}
    fi

    if [[ -z "\${(P)\${tempPar}}" ]]
    then
        getParams \${sourceRef} \${tempPar} \${urlVar}
    fi
    unset tempPar reuseParOpt 
}

EOF


# Create Fuzzy Explorer file

#Log message
gapicLogger "ENGINE" "EXEC" '\t\t' "INFO" "Creating gapic fuzzy explorer wizard under: ${outputFuzzWiz}"

apacheLicense > ${outputFuzzWiz}

cat << EOF >> ${outputFuzzWiz}

# Fuzzy Menu

gapicFuzzyMenu() {
    sed 's/ /\n/g' \\
    | fzf \\
    --preview \\
        "{ cat \\
          <(echo -e \"# Please choose an option, and press Enter #\") \\
          <(echo -e \"# Tab: Query quick-replace #\n\n\") \\
         } && [[ -f \${gapicSchemaDir}{}.json ]] \\
           && { cat  <( jq -C  '.' \${gapicSchemaDir}{}.json ) } \\
           || { cat <( jq -C '.' \${gapicLogDir}\${gapicReqLog} ) }" \\
    --bind "tab:replace-query" \\
    --bind "ctrl-space:execute% cat \${1}  | jq --sort-keys -C .resources.{}.methods | less -R > /dev/tty 2>&1 %" \\
    --bind "change:top" \
    --layout=reverse-list \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# gapic: API Composer #" \\
    --color=dark \\
    --black 

}

# Fuzzy History

gapicFuzzyHistory() { 
    jq -c '.[]' \\
    | fzf \\
    --preview "cat \\
      <(echo -e \"# Ctrl-space: Expand preview (use '/' to search) #\")  \\
      <(echo -e \"# Tab: query quick-replace #\") \\
      <(echo -e \"# Search for a keyword and press Enter to replay request #\n\n\") \\
      <(jq -C {} < \${1} ) \\
      " \\
    --bind "ctrl-space:execute% cat <(jq -C {1} < \${1}) | less -R > /dev/tty 2>&1 %" \\
    --bind "tab:replace-query" \\
    --layout=reverse-list \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# Fuzzy Request History Explorer #" \\
    --color=dark \\
    --black 
}

# Schema explorer / fuzzy finder

gapicFuzzySchema() {
    cat \${1} \\
    | jq 'path(..) | map(tostring) | join(".")' \\
    | sed "s/\"//g" \\
    | sed "s/^/./" \\
    | sed "s/\.\([[:digit:]]\+\)/[\1]/g" \\
    | fzf  \\
    --preview \\
        "cat \\
          <(echo -e \"# Ctrl-space: Expand preview (use '/' to search) #\")  \\
          <(echo -e \"# Ctrl-k: preview keys #\") \\
          <(echo -e \"# Tab: query quick-replace #\n\n\") \\
          <(jq -C {1} < \${1})" \\
    --bind "ctrl-s:execute% cat <(jq -c {1} < \${1}) | less -R > /dev/tty 2>&1 %" \\
    --bind "ctrl-b:preview(cat <(jq -c {1} < \${1}) | base64 -d)" \\
    --bind "ctrl-k:preview(cat <(jq -c {1} < \${1}) | jq '. | keys[]')" \\
    --bind "tab:replace-query" \\
    --bind "ctrl-space:execute% cat <(jq -C {1} < \${1}) | less -R > /dev/tty 2>&1 %" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# Fuzzy Object Explorer #" \\
    --color=dark \\
    --black \\
    | xargs -ri jq -C {} <(cat \${1})
}

gapicFuzzyResources() {
    sed 's/ /\n/g' \\
    | fzf \\
    --preview \\
        "cat \\
          <(echo -e \"# Ctrl-space: Expand preview (use '/' to search) #\") \\
          <(echo -e \"# Tab: query quick-replace #\n\n\") \\
          <( cat \${1} | jq -C  \\
            '.resources.{}.methods | keys[]')
        " \\
    --bind "tab:replace-query" \\
    --bind "ctrl-space:execute% cat \${1}  | jq --sort-keys -C .resources.{}.methods | less -R > /dev/tty 2>&1 %" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# \${schemaRef}: Resources #" \\
    --color=dark \\
    --black 
}

gapicFuzzyMethods() {
    sed 's/ /\n/g' \\
    | sed "s/^[^.]*_//g" \\
    | fzf \\
    --preview \\
        "cat \\
          <(echo -e \"# Ctrl-space: Expand preview (use '/' to search) #\n\n\") \\
          <( cat \${1} | jq -C  \\
            .resources.\${2}.methods.{})
        " \\
    --bind "tab:replace-query" \\
    --bind "ctrl-space:execute% cat \${1}  | jq --sort-keys -C .resources.\${2}.methods.{} | less -R > /dev/tty 2>&1 %" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# \${2}: Methods #" \\
    --color=dark \\
    --black 
}

fuzzExSimpleParameters() {
    sed 's/ /\n/g' \\
    | fzf \\
    --bind "tab:replace-query" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --bind "ctrl-r:execute% source \${gapicParamWiz} && rmParams \${tempPar} {} \${credPath}/\${fileRef} %+preview(cat <(echo -e \# Removed {}))" \\
    --preview "cat <(echo -e \"# Ctrl-r: Remove entry #\n\n\") <( cat \${schemaFile} | jq --sort-keys -C  .resources.\${1}.methods.\${2}.parameters.\${3})" \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# \${1}.\${2}: Saved \${3} Params #" \\
    --color=dark \\
    --black 
}

fuzzExOptParameters() {
    sed 's/ /\n/g' \\
    | fzf \\
    --bind "tab:replace-query" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --preview "cat \${schemaFile} | jq --sort-keys -C  .resources.\${1}.methods.\${2}.parameters.\${3}" \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# \${1}.\${2}: \${3} Param #" \\
    --color=dark \\
    --black 
}

fuzzExAllParameters() {
    sed 's/ /\n/g' \\
    | fzf \\
    --bind "tab:replace-query" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --preview "cat \${schemaFile} | jq --sort-keys -C  \".resources.\${1}.methods.\${2}.parameters\"" \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# \${1}.\${2}: Available Params #" \\
    --color=dark \\
    --black 
}

fuzzExPromptParameters() {
    sed 's/ /\n/g' \\
    | fzf \\
    --bind "tab:replace-query" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --preview "cat <(echo \${2} | sed 's/ /\\n/g')" \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# \${1} #" \\
    --color=dark \\
    --black 
}

fuzzExPostParametersPrompt() {
    fzf \\
    --bind "tab:replace-query" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --preview "cat \${schemaFile} | jq --sort-keys -C  \${1}" \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# \${2} #" \\
    --color=dark \\
    --black 
}


fuzzExPostParametersPreview() {
    fzf \\
    --bind "tab:replace-query" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --preview "cat \${schemaFile} | jq --sort-keys -C  .schemas.\${1}.properties.{}"  \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# \${2} #" \\
    --color=dark \\
    --black
}

fuzzExSavedCreds() {
    fzf \\
    --bind "tab:replace-query" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --preview "cat <( cat \${2}/{} | jq -C )" \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# \${1} #" \\
    --color=dark \\
    --black \\
    | xargs -ri cat \${2}/{} \\
    | jq -c '.' 
}

fuzzExInputCreds(){
    echo \\
    | fzf \\
    --print-query \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# \${1} #" \\
    --color=dark \\
    --black
}

fuzzExSavedScopes() {
    jq ".scopeUrl" \\
    | fzf \\
    --bind "tab:replace-query" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --preview "cat \${2} | jq -C \".authScopes[] | select(.scopeUrl == \"{}\")\" " \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# \${1} #" \\
    --color=dark \\
    --black \\
    | xargs -ri echo {} \\
    | sed 's/"//g'
}

fuzzExCreateScopes() {
    jq ".resources.\${2}.methods.\${3}.scopes[]" \\
    | fzf \\
    --bind "tab:replace-query" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --preview "cat <( cat \${4} | jq -C \".resources.\${2}.methods.\${3}\")" \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# \${1} #" \\
    --color=dark \\
    --black \\
    | xargs -ri echo {} \\
    | sed 's/"//g'
}

EOF



# Create Request History file

#Log message
gapicLogger "ENGINE" "EXEC" '\t\t' "INFO" "Creating request history wizard under: ${outputHistWiz}"

apacheLicense > ${outputHistWiz}

cat << EOF >> ${outputHistWiz}

# Request history JSON builder

histGenRequest() {
    local currentTimestamp=\`date +%s\`\$((\`date +%N\`/1000000))
    export requestId=\`echo -n \${currentTimestamp} \\
    | sha1sum \\
    | awk '{print \$1}'\`

    jq -cn  \\
    --arg rid \${requestId} \\
    --arg ts \${currentTimestamp} \\
    --arg cid \${1} \\
    --arg atk \${2} \\
    --arg rtk \${3} \\
    --arg res \${4} \\
    --arg met \${5} \\
    --arg hmt \${6} \\
    --arg url \${7} \\
    '{ requestId: \$rid, timestamp: \$ts, auth: { clientId: \$cid, accessToken: \$atk, refreshToken: \$rtk, curl: null, response: null}, request: { resource: \$res, method: \$met, httpMethod: \$hmt, url: \$url, headers: [], curl: null }, response: null}' \\
    | read requestPayload

    export requestPayload
}

histListBuild() {
    jq -c "\${1}=[\${1}[],\${2}]" \\
    | read -r requestPayload

    export requestPayload
}

histRevListBuild() {
    jq -c "\${1}=[\${2},\${1}[]]" \\
    | read -r requestPayload

    export requestPayload
}

histUpdatePayload() {
    jq -c "\${1}=\${2}" \\
    | read -r requestPayload

    export requestPayload
}


histNewEntry() {
    if ! [[ -f \${2}\${3} ]]
    then 
        echo "[\${1}]" \\
        | jq \\
        > \${2}\${3}
    else
        cat \${2}\${3} \\
        | jq -c \\
        | read -r savedPayload

        echo \${savedPayload} \\
        | histRevListBuild "." "\${1}"
        
        if [[ \`echo \${requestPayload} | jq -c \` ]]
        then
            echo \${requestPayload} \\
            | jq \\
            > \${2}\${3}
        fi
    fi
}

histUpdateToken() {
    cat \${gapicLogDir}\${gapicReqLog} \\
    | jq \\
    --arg replace \${3} -c \\
    "map((select(.requestId == \${1}) | \${2}) |=  \\\$replace)" \\
    | read -r newPayload

    if [[ \`echo \${newPayload} | jq -c \` ]]
    then
        echo \${newPayload} \\
        | jq \\
        > \${gapicLogDir}\${gapicReqLog}
    fi

    unset newPayload

}

histUpdateJson() {
    cat \${gapicLogDir}\${gapicReqLog} \\
    | jq \\
    -c \\
    "map((select(.requestId == \${1}) | \${2}) |=  \${3})" \\
    | read -r newPayload

    if [[ \`echo \${newPayload} | jq -c \` ]]
    then
        echo \${newPayload} \\
        | jq \\
        > \${gapicLogDir}\${gapicReqLog}
    fi

    unset newPayload

}


histReplayRequest() {
    if [[ \`echo \${1} | jq -r '.tags'\` != "null" ]] \\
    && [[ \`echo \${1} | jq -r '.tags.replay'\` == "true" ]]
    then
        export origReqId=\`echo \${1} | jq -r '.tags.origin'\`
    else
        export origReqId=\`echo \${1} | jq -r '.requestId'\`

    fi

    export CLIENTID=\`echo \${1} | jq -r '.auth.clientId' \`
    export fileRef=\`echo \${CLIENTID//-/ } | awk '{print \$1}'\`
    export CLIENTSECRET=\`cat \${credPath}/\${fileRef} | jq -r '.clientSecret'\`
    export ACCESSTOKEN=\`echo \${1} | jq -r '.auth.accessToken'\`
    export REFRESHTOKEN=\`echo \${1} | jq -r '.auth.refreshToken'\`

    
    if [[ \`echo \${1} | jq -r '.auth.response.scope'\` == 'null'  ]]
    then
        export requestScope=\`cat \${credPath}/\${fileRef} | jq -r ".authScopes[] | select(.refreshToken == \"\${REFRESHTOKEN}\") | .scopeUrl" \`
    else
        export requestScope=\`echo \${1} | jq -r '.auth.response.scope'\`
    fi

    local reqResource=\`echo \${1} | jq -r '.request.resource'\`
    local reqMethod=\`echo \${1} | jq -r '.request.method'\`
    local met=\`echo \${1} | jq -r '.request.httpMethod'\`
    local url=\`echo \${1} | jq -r '.request.url'\`

    local headersCounter=( \`echo \${1} | jq '.request.headers | keys[] ' \` )

    if [[ \${#headersCounter[@]} -eq 2 ]] \\
    && [[ \`echo \${1} | jq ".request.headers[\${headersCounter[1]}]"\` =~ "Authorization: Bearer " ]] \\
    && [[ \`echo \${1} | jq ".request.headers[\${headersCounter[2]}]"\` == '"Accept: application/json"' ]]
    then

        execRequest() {
            if [[ -z \${requestId} ]]
            then 
                histGenRequest "\${CLIENTID}" "\${ACCESSTOKEN}" "\${REFRESHTOKEN}" "\${reqResource}" "\${reqMethod}" "\${met}" "\${url}"

                if ! [[ -z \${sentAuthRequest} ]] \\
                && ! [[ -z \${authPayload} ]]
                then 
                    echo \${requestPayload} \\
                    | histUpdatePayload ".auth.curl" "\"\${sentAuthRequest}\""

                    echo ${requestPayload} \\
                    | histUpdatePayload ".auth.response" "\"\${authPayload}\""
                fi
    
                echo \${requestPayload} \\
                | histListBuild ".request.headers" "\"Authorization: Bearer \${ACCESSTOKEN}\""
                
                echo \${requestPayload} \\
                | histListBuild ".request.headers" "\"Accept: application/json\""

                histNewEntry "\${requestPayload}" "\${gapicLogDir}" "requests.json"
            else
                histUpdateToken "\"\${requestId}\"" ".auth.refreshToken" "\${REFRESHTOKEN}"
                histUpdateToken "\"\${requestId}\"" ".auth.accessToken" "\${ACCESSTOKEN}"        
                histUpdateToken "\"\${requestId}\"" ".auth.curl" "\${sentAuthRequest}"            
                histUpdateJson "\"\${requestId}\"" ".auth.response" "\${authPayload}"          
            fi


            curl -s \\
            --request \${met} \\
            \${(Q)url} \\
            --header "Authorization: Bearer \${ACCESSTOKEN}" \\
            --header "Accept: application/json" \\
            --compressed \\
            | jq -c '.' \\
            | read -r outputJson
            export outputJson

            histUpdateJson "\"\${requestId}\"" ".tags" "{\"replay\":true,\"origin\":\"\${origReqId}\"}"          
            histUpdateJson "\"\${requestId}\"" ".response" "\${outputJson}"          
            histUpdateToken "\"\${requestId}\"" ".request.curl" "curl -s --request \${met} \${(Q)url} --header 'Authorization: Bearer \${ACCESSTOKEN}' --header 'Accept: application/json' --compressed"          

        }

        execRequest

        if ! [[ -z \${outputJson} ]]
        then
            gapicPostExec
        else
            echo -e "# No JSON output, please debug.\\n\\n"
        fi
        

    fi
}

EOF


# Create Post Data handler file

#Log message
gapicLogger "ENGINE" "EXEC" '\t\t' "INFO" "Creating post data wizard under: ${outputPostWiz}"

apacheLicense > ${outputPostWiz}

cat << EOF >> ${outputPostWiz}

postBrowseProps() {
    cat \${schemaFile} \\
    | jq -rc ".schemas.\${1}.properties | keys[]" \\
    | fuzzExPostParametersPreview "\${1}" "Choose properties to add" \\
    | read -r postPropOpt

    if ! [[ -z \${postPropOpt} ]]
    then
        postPropPayload=\`cat \${schemaFile} | jq -c ".schemas.\${1}.properties.\${postPropOpt}" \`
    else
        postLoopBreak=true
    fi
}

postDataPropBuild() {
    echo \${requestPostData} \\
    | jq -c "\${1}=\${2}" \\
    | read -r requestPostData

    export requestPostData
}

EOF


# if an input JSON file isn't supplied, defaults to fetching the Directory API schema via curl
# if other files already exist, rename the active one

#Log message
gapicLogger "SCHEMA" "INPUTCHECK" '\t' "INFO" "Checking for input file."


if [[ -z ${inputFile} ]]
then

    gapicLogger "SCHEMA" "INPUTCHECK" '\t' "INFO" "Input file wasn't provided."
    gapicLogger "SCHEMA" "FILECHECK" '\t' "INFO" "Checking for previously fetched schemas."


    # Build an array with the saved schema files

    schemaDirContents=( `find ${outputSchemaDir} -name "gapic_AdminSDK_Directory*"` )

    # If there are saved schemas and if the default file exists,
    # move the default file to the next available index

    if ! [[ -z ${schemaDirContents} ]] \
      && [[ -f ${defaultSchemaFile} ]]
    then

        #Log message
        gapicLogger "SCHEMA" "FILECHECK" '\t' "INFO" "Found existing schema files in '${outputSchemaDir}'."

        # Grab the last file in the array (highest in the index)
        lastSavedSchema=${schemaDirContents[${#schemaDirContents[@]}]}
        
        # Strip the file extension, directory and file name, besides the index
        newSchemaName=${lastSavedSchema//.json/}
        newSchemaName=${newSchemaName//${outputSchemaDir}\/gapic_AdminSDK_Directory/}
        newSchemaName=${newSchemaName//_/}

        # Add 1 to the index (next in line)
        newSchemaName=$((${newSchemaName}+1))

        # Setup the new filename for the currently active schema, 
        # based on the same directory and filename 
        newSchemaName=${outputSchemaDir}/gapic_AdminSDK_Directory_${newSchemaName}.json

        #Log message
        gapicLogger "SCHEMA" "RENAME" '\t' " OK " "Renaming active schema to '${newSchemaName//${outputSchemaDir}/}'."

        # Rename the currently active schema
        mv ${defaultSchemaFile} ${newSchemaName}

    fi
    

    #Log message
    gapicLogger "SCHEMA" "CURL" '\t\t' "INFO" "Fetching API schema via cURL."


    # Then, fetch the schema file via curl, and sort the keys to make the
    # object a bit more consistent when exploring

    curl -s \
    ${inputSchemaUrl} \
    | jq --sort-keys \
    > ${defaultSchemaFile}
    
    #Log message
    gapicLogger "SCHEMA" "CURL" '\t\t' " OK " "Schema saved in '${defaultSchemaFile}'."



    # If the active schema was renamed, compare contents with the 
    # downloaded file; delete the old file if they are the same

    if [[ -f ${newSchemaName} ]]
    then

        #Log message
        gapicLogger "SCHEMA" "DIFF" '\t\t' "INFO" "Comparing downloaded schema with '${newSchemaName//${outputSchemaDir}/}'."

        
        # Google randomizes the JSON keys order each time the file is fetched
        # with `jq -c --sort-keys '.[]' | sort`, it's possible to accurately 
        # capture any differences in the files

        checkDiff=`diff <(cat ${newSchemaName} | jq -c --sort-keys '.[]' | sort) <(cat ${defaultSchemaFile} | jq -c --sort-keys '.[]' | sort)`
        
        # If the created variable with the diff is empty, remove the old file
        # ergo, there are no differences in files. If a  difference is found,
        # log warning to console (and to logfile), keep both files and dump diff

        if [[ -z ${checkDiff} ]]
        then
            #Log message
            gapicLogger "SCHEMA" "DIFF" '\t\t' " OK " "API schemas are identical. Removing '${newSchemaName//${outputSchemaDir}/}'."

            rm ${newSchemaName}
        else
            #Log message
            gapicLogger "SCHEMA" "DIFF" '\t\t' "WARNING" "Found differences in the schema. Keeping both files." "Found differences in the schema. Keeping both files" "WARNING:schema-diff" "Difference in schemas: ${checkDiff}"

            echo -e ":\n\n"
            echo ${checkDiff}
            echo -e "\n\n"
        fi
    
    fi
    
    # Always set the input file variable as the default schema file path 

    #Log message
    gapicLogger "SCHEMA" "FILECHECK" '\t' "INFO" "Setting input file to: ${defaultSchemaFile}."

    inputFile=${defaultSchemaFile}

fi

# Testing if input is file

if ! [[ -f ${inputFile} ]]
then
    #Log message
    gapicLogger "SCHEMA" "FILECHECK" '\t\t' "ERROR" "Invalid input file, please make sure you enter the path to a valid file. Exiting." "Invalid input file, please make sure you enter the path to a valid file. Exiting." "ERROR:invalid-file" "Not a file: ${inputFile} - [[ -f ${inputFile} ]]"
    exit 1
fi

# Testing if input file is JSON-valid

cat "${inputFile}" \
    | jq -c '.' 2>&1 \
    | read -r inputJson

    

if [[ ${inputJson} =~ "parse error" ]]
then
    #Log message
    gapicLogger "SCHEMA" "JSONCHECK" '\t\t' "ERROR" "Invalid JSON, please check your input file and verify it using \`jq\`." "Invalid JSON, please check your input file and verify it using \`jq\`." "ERROR:invalid-json" "jq error: ${inputJson}"
    exit 1
fi


### Retrieve all available APIs
##### Current exceptions:
##### "resources"; "customer" - complex tree (.resources.resources.resources.methods), creating exceptions later

apiExceptions='"resources"\|"customer"'
apiSets=(`echo ${inputJson} | jq -c '.resources | keys[]' | grep -v ${apiExceptions} | tr '"' ' '`)

#Log message
gapicLogger "API" "RESOURCES" '\t' "INFO" "Collected ${#apiSets[@]} resources."
#gapicLogger "API" "RESOURCES" '\t' "INFO" "Iterating through each resource to collect data."


for (( a = 1 ; a <= ${#apiSets[@]} ; a++ ))
do 

    #Log message
    gapicLogger "API" "RESOURCES" '\t' "INFO" "[${(U)apiSets[$a]}] - Collecting metadata."


    ### Iterate through each API and retrieve its method, and capitalize the variable
    
    localMethods=(`echo ${inputJson} | jq -c ".resources.${apiSets[$a]}.methods | keys[]" | tr '"' ' '`)
    localMethodsFunctions=(${localMethods})

    for (( b = 1 ; b <= ${#localMethods[@]} ; b++ ))
    do

        #Log message
        #gapicLogger "API" "METHODS" '\t\t' "INFO" "[${(U)apiSets[$a]}][${(U)localMethods[$b]}] - Collecting metadata."

        ### Iterate through each method, prefix the resource to it (for function names)
        ### Also initialize those values as arrays (nesting them) to define query structure naming,
        ### variable prefixes, and the JSON schema such as: users_get=(get USERS_GET_ {JSON})
        ### This is used so that unique functions are generated, and the jq query is defined during the loop
        declare -g "localMethodsFunctions[$b]=${apiSets[$a]}_${localMethodsFunctions[$b]}"
        local methodJson=`echo ${inputJson} | jq -c ".resources.${apiSets[${a}]}.methods.${localMethods[$b]}"`
        local methodSet=("${localMethods[$b]}" "${(U)apiSets[$a]}_${(U)localMethods[$b]}_" "${methodJson}")
        set -A ${localMethodsFunctions[$b]} ${methodSet} 
        unset methodSet methodJson
    
    done
    
    ### Nesting the collected methods into each element of the resources array
    ### so they can be evaluated through it, all from one array
    ### Example:
    # $ echo ${apiSets[1]} ~> asps
    # $ echo ${(P)${apiSets[1]}[1]} ~> asps_delete
    # $ echo ${(P)${(P)apiSets[1]}[1][1]} ~> delete
    # $ echo ${(P)${(P)apiSets[1]}[1][2]} ~> ASPS_DELETE_


    set -A ${apiSets[$a]} ${localMethodsFunctions}

    ### Method counter for metrics, analytics and debugging

    methodCounter="${(P)#apiSets[$a]}"
    methodCountTotal=$((${methodCountTotal}+${methodCounter}))

done


# Send available API sets to file

#Log message
gapicLogger "ENGINE" "EXEC" '\t\t' "INFO" "Creating gapic API library wizard under: ${outputLibWiz}."
#gapicLogger "ENGINE" "LIB" '\t\t' "INFO" "Preparing array with resources."



apacheLicense > ${outputLibWiz}

cat << EOF >> ${outputLibWiz}

gapicSets=( ${apiSets[@]} )

EOF

#Log message
gapicLogger "ENGINE" "LIB" '\t\t' "INFO" "Nesting with arrays with methods."


# Define function names

for (( a = 1 ; a <= ${#apiSets[@]} ; a++ ))
do
    # define local sets, similar to ${apiSets}

    #Log message
    #gapicLogger "ENGINE" "LIB" '\t\t' "INFO" "[${(U)apiSets[$a]}] - Preparing nested arrays for methods."

     
    cat << EOF >> ${outputLibWiz}
${apiSets[$a]}=( ${(P)${apiSets[$a]}[@]} )
EOF

done


#Log message
gapicLogger "ENGINE" "LIB" '\t\t' "INFO" "Preparing functions for each method, for each resource."



# loop through all resources

for (( c = 1 ; c <= ${#apiSets[@]} ; c++ ))
do

    #Log message
    #gapicLogger "ENGINE" "LIB" '\t\t' "INFO" "[${(U)apiSets[$c]}] - Initializing."


    # loop through all methods within each resource

    for (( d = 1 ; d <= ${(P)#apiSets[$c]} ; d++ ))
    do

        #Log message
        gapicLogger "ENGINE" "BUILD" '\t\t' "INFO" "[${(P)apiSets[$c][$d]/_//}] - Building function."

        # define variable prefix for this method

        curPrefix=${(P)${(P)apiSets[$c]}[$d][2]}
        
        # define the URL used, from '.resources.{resource}.methods.{method}.flatPath'
        # substitute parameters with shell-variable syntax 
        # .../users/{userKey}/asps --> .../users/${userKey}/asps
        
        tempUrl=`echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -r ".flatPath"`
        tempUrl=${tempUrl//\{/\$\{}

        curUrl="https://www.googleapis.com/${tempUrl}?key=\${CLIENTID}"

        # define HTTP method used (GET, POST, DELETE, PATCH, PUT)

        curMethod=`echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -r ".httpMethod"`

        if [[ "${curMethod}" == "POST" ]] \
        || [[ "${curMethod}" == "PATCH" ]] \
        || [[ "${curMethod}" == "PUT" ]] \
        || [[ "${curMethod}" == "DELETE" ]]
        then
            curPostDefaultRef=`echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -cr '.request."$ref"'`
            curPostExtraRefs+=( `echo ${inputJson} | jq -cr ".schemas.${curPostDefaultRef}.properties[] | select(.\"\$ref\") | .\"\$ref\""` )
        
            curPostSchemaRef=`echo ${inputJson} | jq -cr ".schemas.${curPostDefaultRef}.properties"`
            
            for (( schemas = 1 ; schemas <= ${#curlPostExtraRefs[@]} ; schemas++ ))
            do
                curPostSchemaExtraRef+=( `echo ${inputJson} | jq -cr ".schemas.${curPostExtraRefs[$schemas]}.properties"` )
            done

            
        fi
        


        # fetch all available query parameters (not the post data)

        #Log message
        #gapicLogger "ENGINE" "LIB" '\t\t' "INFO" "[${(P)apiSets[$c][$d]/_//}] - Preparing parameters."


        curParams=(`echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -r ".parameters | keys[]"`)

        # looping through all parameters 

        for (( e = 1 ; e <= ${#curParams[@]} ; e++ ))
        do

            # check required (mandatory) parameters
            # exceptions are being added manually (needs manual verification per API resource/method)
            if ! [[ `echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -rc ".parameters.${curParams[$e]}.required"` =~ "null" ]]
            then
                # build an array with required parameters
                curReqParams+=("${curParams[$e]}")
                
                # define temp variables for type and description
                local curTempType=`echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -rc ".parameters.${curParams[$e]}.type"`
                local curTempDesc=`echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -rc ".parameters.${curParams[$e]}.description"` 

                # store the variables in an array with the same name as the parameter, unset temp vars
                local curTempMeta="${curParams[$e]}Meta"
                set -A "${curTempMeta}" "${curTempType}" "${curTempDesc}"
                unset curTempType curTempDesc curTempMeta
            fi


            # check enum parameters (for options), in case the property exists (isn't null)
            if ! [[ `echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -rc ".parameters.${curParams[$e]}.enum"` =~ "null" ]]
            then
                # define enum parameters into its own array
                curOptParams+=("${curParams[$e]}")

                # define temp variables to store type, description, and the enum list (processed later with `| jq -r '.[]'`)
                local curTempType=`echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -rc ".parameters.${curParams[$e]}.type"`
                local curTempDesc=`echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -rc ".parameters.${curParams[$e]}.description"` 
                local curTempEnum=`echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -rc ".parameters.${curParams[$e]}.enum"` 

                # push these variables to an array of the same name as the parameter and unset temp vars
                local curTempMeta="${curParams[$e]}Meta"               
                set -A "${curTempMeta}" "${curTempType}" "${curTempDesc}" "${curTempEnum}"
                unset curTempEnum curTempType curTempDesc curTempMeta
            fi

            # collect input parameters (leftovers), which are those that require user input
            # (there isn't a default or preset option, requires user to populate the field)
            if [[ `echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -rc ".parameters.${curParams[$e]}.enum"` =~ "null" ]] \
            && [[ `echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -rc ".parameters.${curParams[$e]}.required"` =~ "null" ]]
            then
                # define an array with input parameters
                curInpParams+=("${curParams[$e]}")

                # define temp variables for parameter type and its description
                curTempType=`echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -rc ".parameters.${curParams[$e]}.type"`
                curTempDesc=`echo ${(P)${(P)apiSets[$c]}[$d][3]} | jq -rc ".parameters.${curParams[$e]}.description"` 

                # define an array named after the parameter, containing the temp vars for type and description, unset temp vars
                local curTempMeta="${curParams[$e]}Meta"
                set -A "${curTempMeta}" "${curTempType}" "${curTempDesc}"
                unset curTempType curTempDesc curTempMeta
            fi
        done

        
        #Log message
        #gapicLogger "ENGINE" "LIB" '\t\t' "INFO" "[${(P)apiSets[$c][$d]/_//}] - Preparing request headers."

        # define default cURL-compatible headers
        curHeaderSet=(
            "Authorization: Bearer \${ACCESSTOKEN}"
            "Accept: application/json"
            )

        # based on the API method or the HTTP method, add post request headers (to post JSON data)
        if ! [[ ${(P)${apiSets[$c]}[$d]} =~ "users_signOut" ]] \
        && [[ ${curMethod} =~ "PATCH" ]] \
        || [[ ${curMethod} =~ "PUT" ]] \
        || [[ ${curMethod} =~ "POST" ]]
        then 
            curHeaderSet=( 
                ${curHeaderSet[@]}
                "Content-Type: application/json"
            )

        fi



        # Function headers

        #Log message
        #gapicLogger "ENGINE" "BUILD" '\t\t' "INFO" "[${(P)apiSets[$c][$d]/_//}] - Creating function."


        cat << EOF >> ${outputLibWiz}

${(P)${apiSets[$c]}[$d]}() {

    apiQueryRef=( \`echo ${(P)${apiSets[$c]}[$d]//_/ }\`)


EOF


        if ! [[ -z ${curReqParams} ]]
        then

            # Push each required parameter into the function
            # If a saved variable exists, load it and ask to reuse
            # else, collect and store it
            for (( h = 1 ; h <= ${#curReqParams[@]} ; h++ ))
            do

                cat << EOF >> "${outputLibWiz}"
    ${curReqParams[$h]}Meta=( 
EOF
                for (( i = 1 ; i <= ${#${(P)curReqParams[$h]}Meta[@]} ; i++ ))
                do
                    cat << EOF >> "${outputLibWiz}"
        ${(qq)${(P)curReqParams[$h]}Meta[$i]}
EOF
                done
                cat << EOF >> "${outputLibWiz}"
    )

EOF
    
                cat << EOF >> "${outputLibWiz}"

    if ! [[ \` cat \${credPath}/\${fileRef} | jq -cr '.param' \` == "null" ]]
    then
        if ! [[ -z \` cat \${credPath}/\${fileRef} | jq -cr '.param[] | select(.${curReqParams[$h]})' \`  ]]
        then
            if ! [[ -z \` cat \${credPath}/\${fileRef} | jq -cr '.param[] | select(.${curReqParams[$h]})[] | .[]' \` ]]
            then
                checkParams ${(P)${apiSets[$c]}[$d]} ${curReqParams[$h]} "false"
            else
                getParams "${(P)${apiSets[$c]}[$d]}" "${curReqParams[$h]}"
            fi
        else
            getParams "${(P)${apiSets[$c]}[$d]}" "${curReqParams[$h]}"
        fi
    else
        genParamConfig
        getParams "${(P)${apiSets[$c]}[$d]}" "${curReqParams[$h]}"
    fi

    #    declare -g "${curPrefix}${curReqParams[$h]}=\${${curReqParams[$h]}}"


    
EOF
            done
        fi

        # Place URL
        cat << EOF >> ${outputLibWiz}

    ${curPrefix}URL="${curUrl}"

EOF


        # Push each optional parameter into the function
        # If a saved variable exists, load it and ask to reuse
        # else, collect and store it
        if ! [[ -z ${curOptParams} ]]
        then
            cat << EOF >> "${outputLibWiz}"
    optParams=( ${curOptParams} )

EOF
            for (( h = 1 ; h <= ${#curOptParams[@]} ; h++ ))
            do
                cat << EOF >> "${outputLibWiz}"
    ${curOptParams[$h]}Meta=(
EOF
                for (( i = 1 ; i <= ${#${(P)curOptParams[$h]}Meta[@]} ; i++ ))
                do
                    cat << EOF >> "${outputLibWiz}"
        ${(qq)${(P)curOptParams[$h]}Meta[$i]}
EOF
                done
                cat << EOF >> "${outputLibWiz}"
    )

EOF
            done

            cat << EOF >> "${outputLibWiz}"

    echo "yes no" \\
    | fuzzExPromptParameters "Define optional params?" "\${optParams}" \\
    | read -r optParChoice


    if [[ \${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= \${#optParams[@]} ; i++ ))
        do

            echo "\${optParams}" "[none]" \\
            | fuzzExAllParameters "\${apiQueryRef[1]}" "\${apiQueryRef[2]}" \\
            | read -r option
            
            if [[ -n \${option} ]]
            then
                if [[ \${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    if ! [[ \` cat \${credPath}/\${fileRef} | jq -cr '.param' \` == "null" ]]
                    then
                        if ! [[ -z \` cat \${credPath}/\${fileRef} | jq -cr ".param[] | select(.\${option})" \` ]]
                        then
                            if ! [[ -z \` cat \${credPath}/\${fileRef} | jq -cr ".param[] | select(.\${option})[] | .[]" \` ]]
                            then
                                checkParams ${(P)${apiSets[$c]}[$d]} \${option} "true"
                                if ! [[ \${addedParams} =~ \${option} ]]
                                then
                                    ${curPrefix}URL+="\${tempUrlPar}"
                                    addedParams+=( "\${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "${(P)${apiSets[$c]}[$d]}" "\${option}" "true"
                                ${curPrefix}URL+="\${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "${(P)${apiSets[$c]}[$d]}" "\${option}" "true"
                            ${curPrefix}URL+="\${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "${(P)${apiSets[$c]}[$d]}" "\${option}" "true"
                        ${curPrefix}URL+="\${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi

EOF
        fi

        if ! [[ -z ${curInpParams} ]]
        then

            cat << EOF >> "${outputLibWiz}"
    inpParams=( ${curInpParams} )

EOF
            for (( h = 1 ; h <= ${#curInpParams[@]} ; h++ ))
            do
                cat << EOF >> "${outputLibWiz}"
    ${curInpParams[$h]}Meta=(
EOF
                for (( i = 1 ; i <= ${#${(P)curInpParams[$h]}Meta[@]} ; i++ ))
                do
                    cat << EOF >> "${outputLibWiz}"
        ${(qq)${(P)curInpParams[$h]}Meta[$i]}
EOF
                done
                cat << EOF >> "${outputLibWiz}"
    )

EOF
            done

            cat << EOF >> "${outputLibWiz}"

    echo "yes no" \\
    | fuzzExPromptParameters "Define input params?" "\${inpParams}" \\
    | read -r inpParChoice


    if [[ \${inpParChoice} =~ "y" ]] || [[ \${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= \${#inpParams[@]} ; i++ ))
        do

            echo "\${inpParams}" "[none]" \\
            | fuzzExAllParameters "\${apiQueryRef[1]}" "\${apiQueryRef[2]}" \\
            | read -r option

            if [[ -n \${option} ]]
            then
                if [[ \${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear

                    if ! [[ \` cat \${credPath}/\${fileRef} | jq -cr '.param' \` == "null" ]]
                    then
                        if ! [[ -z \` cat \${credPath}/\${fileRef} | jq -cr ".param[] | select(.\${option})" \` ]]
                        then
                            if ! [[ -z \` cat \${credPath}/\${fileRef} | jq -cr ".param[] | select(.\${option})[] | .[]" \` ]]
                            then
                                checkParams ${(P)${apiSets[$c]}[$d]} \${option} "true"
                                if ! [[ \${addedParams} =~ \${option} ]]
                                then
                                    ${curPrefix}URL+="\${tempUrlPar}"
                                    addedParams+=( "\${option}" )
                                    unset tempUrlPar
                                else
                                    echo -e "# Error! Parameter already provided before, skipping.\n\n"
                                fi
                            else
                                getParams "${(P)${apiSets[$c]}[$d]}" "\${option}" "true"
                                ${curPrefix}URL+="\${tempUrlPar}"
                                unset tempUrlPar
                            fi
                            unset optParam
                        else
                            getParams "${(P)${apiSets[$c]}[$d]}" "\${option}" "true"
                            ${curPrefix}URL+="\${tempUrlPar}"
                            unset tempUrlPar
                        fi
                        unset optParam
                    else
                        genParamConfig
                        getParams "${(P)${apiSets[$c]}[$d]}" "\${option}" "true"
                        ${curPrefix}URL+="\${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
EOF
        fi

        # Post requests

        if [[ "${curMethod}" == "POST" ]] \
        || [[ "${curMethod}" == "PATCH" ]] \
        || [[ "${curMethod}" == "PUT" ]] \
        || [[ "${curMethod}" == "DELETE" ]]
        then
            cat << EOF >> "${outputLibWiz}"

    echo -e "yes\nno" \\
    | fuzzExPostParametersPrompt "\".schemas.${curPostDefaultRef}.properties\"" "Add any Post Data to the request?" \\
    | read -r postDataChoice

    if [[ \${postDataChoice} == "yes" ]]
    then

        ### While loop
        export postLoopBreak=false
        export postMainLoopBreak=false
        export postSubLoopBreak=false

        while [[ \${postMainLoopBreak} != "true" ]]
        do
            postBrowseProps "${curPostDefaultRef}"
            
            if [[ \${postLoopBreak} == "true" ]]
            then
                postMainLoopBreak=true
                postLoopBreak=false
                break
            fi


            # Handle redirections (e.g. "\$ref": "UserName")

            if [[ -z \${requestPostData} ]]
            then 
                requestPostData='{}'
            fi

            export requestPostData

            if ! [[ \`echo \${postPropPayload} | jq -cr '."\$ref"' \` == "null" ]]
            then
                postDataStrucHead=\${postPropOpt}
                
                if [[ \`echo \${requestPostData} | jq -cr ".\${postDataStrucHead}"\` == "null" ]]
                then
                    echo \${requestPostData} \\
                    | jq -c ".\${postDataStrucHead}={}" \\
                    | read -r requestPostData
                fi

                while [[ \${postSubLoopBreak} != "true" ]]
                do

                    postBrowseProps "\`echo \${postPropPayload} | jq -cr '."\$ref"' \`"

                    if [[ \${postLoopBreak} == "true" ]]
                    then
                        postSubLoopBreak=true
                        break
                    fi

                    fuzzExInputCreds "Enter a value for \${postPropOpt}" \\
                    | read -r postPropVal

                    postDataPropBuild ".\${postDataStrucHead}.\${postPropOpt}" "\"\${postPropVal}\""
                    
                done

            else
                fuzzExInputCreds "Enter a value for \${postPropOpt}" \\
                | read -r postPropVal

                postDataPropBuild ".\${postDataStrucHead}.\${postPropOpt}" "\"\${postPropVal}\""


            fi
        done
    
    fi




EOF
        fi



        cat << EOF >> ${outputLibWiz}
    execRequest() {
        if [[ -z \${requestId} ]]
        then 
            histGenRequest "\${CLIENTID}" "\${ACCESSTOKEN}" "\${REFRESHTOKEN}" "\${apiQueryRef[1]}" "\${apiQueryRef[2]}" "${curMethod}" "\${${curPrefix}URL}"
 
            if ! [[ -z \${sentAuthRequest} ]] \\
            && ! [[ -z \${authPayload} ]]
            then 
                echo \${requestPayload} \\
                | histUpdatePayload ".auth.curl" "\"\${sentAuthRequest}\""

                echo \${requestPayload} \\
                | histUpdatePayload ".auth.response" "\${authPayload}"
            fi

EOF
        for (( k = 1 ; k <= ${#curHeaderSet[@]} ; k++ ))
        do
            cat << EOF >> ${outputLibWiz}
            echo \${requestPayload} \\
            | histListBuild ".request.headers" "\"${curHeaderSet[$k]}\""

EOF
        done



        cat << EOF >> ${outputLibWiz}
            histNewEntry "\${requestPayload}" "\${gapicLogDir}" "requests.json"
       else
            histUpdateToken "\"\${requestId}\"" ".auth.refreshToken" "\${REFRESHTOKEN}"
            histUpdateToken "\"\${requestId}\"" ".auth.accessToken" "\${ACCESSTOKEN}"        
            histUpdateToken "\"\${requestId}\"" ".auth.curl" "\${sentAuthRequest}"            
            histUpdateJson "\"\${requestId}\"" ".auth.response" "\${authPayload}"          
        fi

        # handle GET/POST requests

        if ! [[ -z \${requestPostData} ]]
        then
            # handle POST requests

            echo \${requestPayload} \\
            | histListBuild ".request.headers" "\"Content-Type: application/json\""

            echo \${requestPayload} \\
            | histUpdatePayload ".request.postData" "\${requestPostData}"

            curl -s \\
            --request ${curMethod} \\
            \${${curPrefix}URL} \\
EOF
        for (( k = 1 ; k <= ${#curHeaderSet[@]} ; k++ ))
        do
            cat << EOF >> ${outputLibWiz}
            --header "${curHeaderSet[$k]}" \\
EOF
        done

        unset k 


        cat << EOF >> ${outputLibWiz}
            --header 'Content-Type: application/json' \\
            --data "\${requestPostData}" \\
            --compressed \\
            | jq -c '.' \\
            | read -r outputJson
            export outputJson

        else
            curl -s \\
            --request ${curMethod} \\
            \${${curPrefix}URL} \\
EOF
        for (( k = 1 ; k <= ${#curHeaderSet[@]} ; k++ ))
        do
            cat << EOF >> ${outputLibWiz}
            --header "${curHeaderSet[$k]}" \\
EOF
        done

        unset k 


        cat << EOF >> ${outputLibWiz}
            --compressed \\
            | jq -c '.' \\
            | read -r outputJson
            export outputJson
            
        fi

        histUpdateJson "\"\${requestId}\"" ".response" "\${outputJson}"          

        execCurl="curl -s --request ${curMethod} \"\${${curPrefix}URL}\" "


        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\\ 
        --request ${curMethod} \\\ 
        \${${curPrefix}URL} \\\ 
EOIF
EOF
        for (( k = 1 ; k <= ${#curHeaderSet[@]} ; k++ ))
        do
            
            cat << EOF >> ${outputLibWiz}
        execCurl+="--header '${curHeaderSet[$k]}' "
        cat << EOIF
        --header "${curHeaderSet[$k]}" \\\ 
EOIF
EOF
        done
        unset curHeaderSet
        cat << EOF >> ${outputLibWiz}        
        if ! [[ -z \${requestPostData} ]]
        then
            execCurl+="--header 'Content-Type: application/json' --data '\${requestPostData}' " 

            cat << EOIF
        --header 'Content-Type: application/json'
        --data '\${requestPostData}'
EOIF
        fi

        cat << EOIF
        --compressed
EOIF
        echo -e "\n\n"
        echo -e "#########################\n"

        execCurl+="--compressed"
        histUpdateToken "\"\${requestId}\"" ".request.curl" "\${execCurl}"          
        unset execCurl

    }
    execRequest
EOF

        unset sentRequest

# Closing the function

        cat << EOF >> ${outputLibWiz}

}

EOF

        #Log message
        gapicLogger "ENGINE" "BUILD" '\t\t' " OK " "[${(P)apiSets[$c][$d]/_//}] - Function created."


        unset curPrefix curUrl curReqParams curOptParams curInpParams curMethod curPostSchemaExtraRef
    done
done

chmod +x ${outputExecWiz}

endTimestamp=`date +%s`

diffTimestamp=$((${endTimestamp}-${startTimestamp}))
elapsedMins=$((${diffTimestamp}/60))
elapsedSecs=`printf "%02d" $((${diffTimestamp}%60))`


#Log message
gapicLogger "ENGINE" "EXEC" '\t\t' " OK " "Executable set up. Run with \`$ ${outputExecWiz}\`"
buildLogUpdate ".buildLog.status" "\"OK\""
gapicLogger "ENGINE" "COMPLETE" '\t' " OK " "Build completed in ${elapsedMins}m ${elapsedSecs}s"
buildLogUpdate ".buildLog.endTimestamp" "${endTimestamp}"
buildLogUpdate ".buildLog.buildTime" "${diffTimestamp}"

# Zsh Lint
lintExecWiz=`zsh -n ${outputExecWiz} 2>&1`
if ! [[ -z ${lintExecWiz} ]]
then
    gapicLogger "LINT" "EXEC" '\t\t' "ERROR" "Exec zsh lint failed with errors: ${lintExecWiz}" "Exec zsh lint failed with errors." "CRITICAL:zsh-lint" "${outputExecWiz}: ${lintExecWiz}"

else
    gapicLogger "LINT" "EXEC" '\t\t' " OK " "Exec zsh lint passed with no errors"
fi

lintLibWiz=`zsh -n ${outputLibWiz} 2>&1`
if ! [[ -z ${lintLibWiz} ]]
then
    gapicLogger "LINT" "LIB" '\t\t' "ERROR" "Lib zsh lint failed with errors: ${lintLibWiz}" "Lib zsh lint failed with errors." "CRITICAL:zsh-lint" "${outputLibWiz}: ${lintLibWiz}"

else
    gapicLogger "LINT" "LIB" '\t\t' " OK " "Lib zsh lint passed with no errors"
fi

lintCredsWiz=`zsh -n ${outputCredsWiz} 2>&1`
if ! [[ -z ${lintCredsWiz} ]]
then
    gapicLogger "LINT" "CREDS" '\t\t' "ERROR" "Creds zsh lint failed with errors: ${lintCredsWiz}" "Creds zsh lint failed with errors." "CRITICAL:zsh-lint" "${outputCredsWiz}: ${lintCredsWiz}"

else
    gapicLogger "LINT" "CREDS" '\t\t' " OK " "Creds zsh lint passed with no errors"
fi

lintParamStoreWiz=`zsh -n ${outputParamStoreWiz} 2>&1`
if ! [[ -z ${lintParamStoreWiz} ]]
then
    gapicLogger "LINT" "PARAM" '\t\t' "ERROR" "Param Store zsh lint failed with errors: ${lintParamStoreWiz}" "Param Store zsh lint failed with errors." "CRITICAL:zsh-lint" "${outputParamStoreWiz}: ${lintParamStoreWiz}"

else
    gapicLogger "LINT" "PARAM" '\t\t' " OK " "Param Store zsh lint passed with no errors"
fi

lintFuzzWiz=`zsh -n ${outputFuzzWiz} 2>&1`
if ! [[ -z ${lintFuzzWiz} ]]
then
    gapicLogger "LINT" "FUZZ" '\t\t' "ERROR" "FuzzEx zsh lint failed with errors: ${lintFuzzWiz}" "FuzzEx zsh lint failed with errors." "CRITICAL:zsh-lint" "${outputFuzzWiz}: ${lintFuzzWiz}"

else
    gapicLogger "LINT" "FUZZ" '\t\t' " OK " "FuzzEx zsh lint passed with no errors"
fi

lintHistWiz=`zsh -n ${outputHistWiz} 2>&1`
if ! [[ -z ${lintHistWiz} ]]
then
    gapicLogger "LINT" "HIST" '\t\t' "ERROR" "History zsh lint failed with errors: ${lintHistWiz}" "History zsh lint failed with errors." "CRITICAL:zsh-lint" "${outputHistWiz}: ${lintHistWiz}"

else
    gapicLogger "LINT" "HIST" '\t\t' " OK " "History zsh lint passed with no errors"
fi

gapicLogger "ENGINE" "COMPLETE" '\t' " OK " "# # gapic exit # # #" "Build completed."
buildLogPush