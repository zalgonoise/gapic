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
# doublecheck `clear` events


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
outputSchemaDir="${output}src/schema"

outputCredsWiz="${outputBinDir}/gapic_creds.sh"
outputLibWiz="${outputBinDir}/gapic_lib.sh"
outputExecWiz="${outputBinDir}/gapic_exec.sh"
outputParamStoreWiz="${outputBinDir}/gapic_paramstore.sh"

defaultSchemaFile="${outputSchemaDir}/gapic_AdminSDK_Directory.json"

if ! [ -d ${outputSrcDir} ]
then
    mkdir ${outputSrcDir}
fi

if ! [ -d ${outputBinDir} ]
then
    mkdir ${outputBinDir}
fi

if ! [ -d ${outputDataDir} ]
then
    mkdir ${outputDataDir}
fi

if ! [ -d ${outputSchemaDir} ]
then
    mkdir ${outputSchemaDir}
fi

if ! [ -f ${outputCredsWiz} ] \
|| ! [ -f ${outputLibWiz} ] \
|| ! [ -f ${outputExecWiz} ] \
|| ! [ -f ${outputParamStoreWiz} ]
then
    touch ${outputCredsWiz} ${outputLibWiz} ${outputExecWiz} ${outputParamStoreWiz}
fi

apacheLicense() {
    cat << EOF
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

EOF
}



# Prepare output file with exec functions


apacheLicense > ${outputExecWiz}

cat << EOF >> ${outputExecWiz}


# Bootstrap by importing wizard files

    gapicBinDir=\`realpath \$0\`
    gapicBinDir=\${gapicBinDir//gapic_exec.sh/}
    gapicDataDir=\${gapicBinDir//bin/data}
    gapicSchemaDir=\${gapicBinDir//bin/schema}
    schemaFile=\${gapicSchemaDir}gapic_AdminSDK_Directory.json

    gapicCredsWiz="\${gapicBinDir}gapic_creds.sh"
    gapicLibWiz="\${gapicBinDir}gapic_lib.sh"
    gapicParamWiz="\${gapicBinDir}gapic_paramstore.sh"

    gapicSavedPar="\${gapicDataDir}.api_params"

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

    if [[ -f \${gapicSavedPar} ]]
    then
        source \${gapicSavedPar}
    fi

}

# Schema explorer / fuzzy finder

gapicFuzzySchema() {
    cat \${1} \\
    | jq 'path(..) | map(tostring) | join(".")' \\
    | sed "s/\"//g" \\
    | sed "s/^/./" \\
    | sed "s/\.\([[:digit:]]\+\)/[\1]/g" \\
    | fzf  \\
    --preview "cat <(jq -C {1} < \${1})" \\
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
          <( cat \${1} | jq -C  \\
            '.resources.{}.methods | keys[]')
        " \\
    --bind "tab:replace-query" \\
    --bind "ctrl-space:execute% cat \${1}  | jq --sort-keys -C .resources.{}.methods | less -R > /dev/tty 2>&1 %" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# Fuzzy Object Explorer #" \\
    --color=dark \\
    --black 
}

gapicFuzzyMethods() {
    sed 's/ /\n/g' \\
    | sed "s/^[^.]*_//g" \\
    | fzf \\
    --preview \\
        "cat \\
          <( cat \${1} | jq -C  \\
            .resources.\${2}.methods.{})
        " \\
    --bind "tab:replace-query" \\
    --bind "ctrl-space:execute% cat \${1}  | jq --sort-keys -C .resources.\${2}.methods.{} | less -R > /dev/tty 2>&1 %" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# Fuzzy Object Explorer #" \\
    --color=dark \\
    --black 
}


# Check for existing credentials and access token

gapicCreds() {
    clear
    echo -en "# Initializing gAPIc ~ checking for credentials.\n\n"

    checkCreds
    checkAccess

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
    gapicCreds

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
            if [ -f \${credFileAccess} ]
            then
                echo -e "# Invalid Credentials error.\n\n# Removing Access Token to generate a new one:\n\n"
                rm \${credFileAccess}
                genAccess

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

            elif ! [ -f \${credFileAccess} ] \\
                && [ -f \${credFileRefresh} ]
            then
                echo -e "# Invalid Credentials error.\n\n# Removing Refresh Token and generating a new one:\n\n"
                rm \${credFileRefresh}
                genRefresh
                
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
    gapicExec
}

# Execution starts below
main
EOF





# Prepare output file with auth functions
apacheLicense > ${outputCredsWiz}

cat << EOF >> ${outputCredsWiz}
# Retrieve needed credentials
    # Define credentials output file path

    credFile=\`realpath \$0\`
    export credFile=\${credFile//bin\/gapic_creds.sh/data\/.api_creds}
    export credFileRefresh=\${credFile//.api_creds/.api_refresh}
    export credFileAccess=\${credFile//.api_creds/.api_access}
    export credFileParams=\${credFile//.api_creds/.api_params}

checkCreds() {
    # Check Client ID variable

    if [ -f \${credFile} ]
    then
        source \${credFile}

        if ! [[ -z \${SAVED_CLIENTID} ]] \\
        && ! [[ -z \${SAVED_CLIENTSECRET} ]]
        then
            clear
            echo -en "# Found saved ClientID: \${SAVED_CLIENTID}. Do you want to use this one? [y/n]\n~> "
            read -r savedOptClient
            clear
            if ! [[ \${savedOptClient} =~ "n" ]] \\
            || ! [[ \${savedOptClient} =~ "N" ]]
            then
                CLIENTID=\${SAVED_CLIENTID}
                CLIENTSECRET=\${SAVED_CLIENTSECRET}
            fi
        fi

        if ! [[ -z \${SAVED_OAUTH2_SCOPE} ]]
        then
            clear
            echo -en "# Found saved OAuth scope: \${SAVED_OAUTH2_SCOPE}. Do you want to use this one? [y/n]\n~> "
            read -r savedOptScope
            clear
            if ! [[ \${savedOptScope} =~ "n" ]] \\
            || ! [[ \${savedOptScope} =~ "N" ]]
            then
                OAUTH2_SCOPE=\${SAVED_OAUTH2_SCOPE}


            fi
        fi

        if ! [[ \${savedOptClient} =~ "n" ]] \\
        || ! [[ \${savedOptClient} =~ "N" ]] \\
        || ! [[ \${savedOptScope} =~ "n" ]] \\
        || ! [[ \${savedOptScope} =~ "N" ]] \\
        && ! [[ -z \${SAVED_REFRESHTOKEN} ]] \\
        || ! [[ -z \${SAVED_ACCESSTOKEN} ]]
        then
            REFRESHTOKEN=\${SAVED_REFRESHTOKEN}
            ACCESSTOKEN=\${SAVED_ACCESSTOKEN}
        fi

    fi

    if [ -z \${CLIENTID} ]
    then
        clear
        echo -en "# enter API Key or ClientID:\n~> "
        read -r CLIENTID
        cat << EOIF >> \${credFile}
SAVED_CLIENTID=\${CLIENTID}
EOIF
        clear
    fi

    # Check Client Secret variable

    if [ -z \${CLIENTSECRET} ]
    then
        echo -en "# enter Client Secret:\n~> "
        read -r CLIENTSECRET
        cat << EOIF >> \${credFile}
SAVED_CLIENTSECRET=\${CLIENTSECRET}
EOIF
        clear
    fi

    # Check Authorized Scope variable

    if [ -z \${OAUTH2_SCOPE} ]
    then
        echo -en "# enter Authorization Scope. Set \"a\" to default to https://www.googleapis.com/auth/admin.directory.user \n~> "
        read -r OAUTH2_SCOPE
        clear
    fi

    if [[ \${OAUTH2_SCOPE} == "a" ]]
    then
        OAUTH2_SCOPE='https://www.googleapis.com/auth/admin.directory.user'
    fi

    if [[ -f \${\${credFile}} ]] \\
    && ! [[ \`grep "SAVED_OAUTH2_SCOPE=\${OAUTH2_SCOPE}" \${credFile}\` ]]
    then
        cat << EOIF >> \${credFile}
SAVED_OAUTH2_SCOPE=\${OAUTH2_SCOPE}
EOIF
    fi

    export CLIENTID CLIENTSECRET OAUTH2_SCOPE
}


# Generate an offline access code via URL
# Ref [:1] https://developers.google.com/youtube/v3/live/guides/auth/installed-apps#Obtaining_Access_Tokens
# Ref [:2] https://developers.google.com/google-ads/api/docs/concepts/curl-example

offlineCode() {
    clientId="\${CLIENTID}"
    accessScope="\${OAUTH2_SCOPE}"
    accessScope=\${accessScope//:/%3A}
    accessScope=\${accessScope//\\//%2F}

    urlString1='https://accounts.google.com/o/oauth2/auth?client_id='
    urlString2='&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&access_type=offline&prompt=consent&scope='

    urlGen=\${urlString1}\${clientId}\${urlString2}\${accessScope}

    echo \${urlGen}
}

genRefresh() {
    echo -en "# Please visit the URL below to generate an access code. Once authenticated you will be provided a code - paste it below: \n\n "
    
    offlineCode
    
    echo -en "\nOffline code\t~> "
    read -r OFFLINECODE
    clear

    sentAuthRequest="curl -s \\ \n    https://accounts.google.com/o/oauth2/token \\ \n    -d code=\${OFFLINECODE} \\ \n    -d client_id=\${CLIENTID} \\ \n    -d client_secret=\${CLIENTSECRET} \\ \n    -d redirect_uri=urn:ietf:wg:oauth:2.0:oob \\ \n    -d grant_type=authorization_code"
    
    echo -e "# Request sent:\n\n"
    echo -e "#########################\n"
    echo "\${sentAuthRequest}"
    echo -e "\n\n"
    echo -e "#########################\n"
    unset sentAuthRequest
    
    curl -s \\
    https://accounts.google.com/o/oauth2/token \\
    -d code=\${OFFLINECODE} \\
    -d client_id=\${CLIENTID} \\
    -d client_secret=\${CLIENTSECRET} \\
    -d redirect_uri=urn:ietf:wg:oauth:2.0:oob \\
    -d grant_type=authorization_code \\
    | jq -c '.' | read -r authPayload
    
    if ! [[ \`echo \${authPayload} | jq '.refresh_token'\` =~ "null" ]] \\
    && ! [[ \`echo \${authPayload} | jq '.access_token'\` =~ "null" ]]
    then 
        REFRESHTOKEN=\`echo \${authPayload} | jq '.refresh_token'\`
        ACCESSTOKEN=\`echo \${authPayload} | jq '.access_token'\`
        ACCESSTOKEN=\${ACCESSTOKEN//\\"/}
        export REFRESHTOKEN ACCESSTOKEN
        cat << EOIF > \${credFileRefresh}
SAVED_REFRESHTOKEN=\${REFRESHTOKEN}
EOIF

        cat << EOIF > \${credFileAccess}
SAVED_ACCESSTOKEN=\${ACCESSTOKEN}
EOIF

        echo -e "# Execution complete!\n\n"
        echo -e "#########################\n"
        echo "\${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
    else
        echo -e "# Error in the authentication!\n\n"
        echo -e "#########################\n"
        echo "\${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
        exit 1
    fi
}

genAccess() {
    # get a new Access Token with Refresh Token
    # https://developers.google.com/identity/protocols/oauth2/web-server#httprest_7
    
    sentRequest="curl -s \\ \n    --request POST \\ \n    -d client_id=\${CLIENTID} \\ \n    -d client_secret=\${CLIENTSECRET} \\ \n    -d refresh_token=\${REFRESHTOKEN} \\ \n    -d grant_type=refresh_token \\ \n    \"https://accounts.google.com/o/oauth2/token\""
    
    echo -e "# Request sent:\n\n"
    echo -e "#########################\n"
    echo "\${sentRequest}"
    echo -e "\n\n"
    echo -e "#########################\n"
    unset sentRequest
    
    curl -s \\
    --request POST \\
    -d client_id=\${CLIENTID} \\
    -d client_secret=\${CLIENTSECRET} \\
    -d refresh_token=\${REFRESHTOKEN} \\
    -d grant_type=refresh_token \\
    "https://accounts.google.com/o/oauth2/token" \\
        | jq -c '.' \\
        | read -r authPayload
    
    if ! [[ \`echo \${authPayload} | jq '.access_token'\` =~ "null" ]]
    then 
        ACCESSTOKEN=\`echo \${authPayload} | jq '.access_token'\`
        ACCESSTOKEN=\${ACCESSTOKEN//\\"/}
        export ACCESSTOKEN
        cat << EOIF > \${credFileAccess}
SAVED_ACCESSTOKEN=\${ACCESSTOKEN}
EOIF
        echo -e "# Execution complete!\n\n"
        echo -e "#########################\n"
        echo "\${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
    else
        echo -e "# Error in the authentication!\n\n"
        echo -e "#########################\n"
        echo "\${authPayload}" | jq '.'
        echo -e "\n\n"
        echo -e "#########################\n"
        exit 1
    fi
}

# Checks for Access Token and Refresh Token

checkAccess() {

    if [ -f \${credFileRefresh} ]
    then
        source \${credFileRefresh}
        REFRESHTOKEN=\${SAVED_REFRESHTOKEN}
    fi

    if [ -f \${credFileAccess} ]
    then
        source \${credFileAccess}
        ACCESSTOKEN=\${SAVED_ACCESSTOKEN}
    fi



    if [ -z \${ACCESSTOKEN} ]
    then

        echo -e "# No Access Token found. Generating one: \n"

        if [ -z \${REFRESHTOKEN} ]
        then
            genRefresh
            

        else
            genAccess

        fi

    fi

}
EOF

# Create Parameter Store file

apacheLicense > ${outputParamStoreWiz}

cat << EOF >> ${outputParamStoreWiz}


# handle storing parameters

getParams() {
    local tempPar=\${1}
    local urlVar=\${2}

    local tempCarrier=PARAM_\${tempPar}
    local tempMeta=\${tempPar}Meta
    local tempVal="\${(P)tempPar}"

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
        select getOption in \${tempOpts}
        do
            if [[ -n \${getOption} ]]
            then
                declare -g "tempVal=\${getOption}"
                clear
                break
            fi
        done
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


        if [[ -f \${credFileParams} ]]
        then
            if ! [[ \`grep "\${tempCarrier}" \${credFileParams}\` ]]
            then 
                cat << EOIF >> \${credFileParams}
\${tempCarrier}=( \${(P)\${tempPar}} )
EOIF
            else 
                if ! [[ \`egrep "\\<\${tempCarrier}\\>.*\\<\${(P)\${tempPar}}\\>" \${credFileParams}\` ]]
                then
                    cat << EOIF >> \${credFileParams}
\${tempCarrier}+=( \${(P)\${tempPar}} )
EOIF
                fi
            fi
        else
            touch \${credFileParams}
            cat << EOIF >> \${credFileParams}
\${tempCarrier}=( \${(P)\${tempPar}} )
EOIF
        fi
    fi
    unset tempPar tempCarrier tempVal
}

# Handle saved parameters

    #--bind "ctrl-r:execute% cat \${1}  | jq --sort-keys -C ..resources.\${2}.methods.\${3}.parameters.{} | less -R > /dev/tty 2>&1 %" \\

fuzzExSimpleParameters() {
    sed 's/ /\n/g' \\
    | fzf \\
    --bind "tab:replace-query" \\
    --bind "change:top" \\
    --layout=reverse-list \\
    --prompt="~ " \\
    --pointer="~ " \\
    --header="# Fuzzy Object Explorer #" \\
    --color=dark \\
    --black \\

}


checkParams() {
    local tempPar=\${1}
    local urlVar=\${2}

    tempCarrier=PARAM_\${tempPar}
    echo -en "# You have saved values for the \${tempPar} parameter. Do you want to use one?\n\n"
    
    echo "\${(P)\${tempCarrier}} [none] [remove]" \\
    | fuzzExSimpleParameters \\
    | read -r checkOption
    
    if [[ -n \${checkOption} ]]
    then
        if [[ \${checkOption} == "[none]" ]]
        then
            clear
            getParams \${tempPar} \${urlVar}
        elif [[ \${checkOption} == "[remove]" ]]
        then
            rmParams \${tempPar}
        else
            clear
            declare -g "\${tempPar}=\${checkOption}"
            if [[ "\${urlVar}" == "true" ]]
            then
                declare -g "tempUrlPar=&\${tempPar}=\${(P)\${tempPar}}"
            fi
            
            unset checkOption
        fi
    
    fi


    if [[ -z "\${(P)\${tempPar}}" ]]
    then
        getParams \${tempPar} \${urlVar}
    fi
    unset tempPar reuseParOpt tempCarrier
}



# Handle parameter removal

rmParams() {
    local paramToRemove=\${1}

    echo -e "# Fetching the parameter store for saved results on \${paramToRemove} to remove:\n"
    
    paramResults=( \`grep -n "\${paramToRemove}" \${gapicSavedPar} | tr ')' ' '\` )
    
    for (( x = 1 ; x <= \${#paramResults[@]} ; x++ ))
    do
        paramResKeys+=( "\${paramResults[\$x]}" )
        ((x++))
        paramResVals+=( "\${paramResults[\$x]}" )
    done

    select remOpt in none \${paramResVals[@]}
    do
        if [[ -n \${remOpt} ]]
        then
            if [[ "\${remOpt}" =~ "none" ]]
            then
                break
            else
                lineToRemove=\`egrep -n "\\<PARAM_\${paramToRemove}\\>.*\\<\${remOpt}\\>" \${gapicSavedPar} | tr ':' ' ' | awk '{print \$1}' \`
                if ! [[ -z \${lineToRemove} ]]
                then
                    sed -i "\${lineToRemove}d" \${gapicSavedPar}
                    echo -e "Removed parameter '\${remOpt}' from parameter store!\n\n"
                fi
                break
            fi
        fi
    done


}

EOF

# Log message
echo -e "[SCHEMA][INPUTCHECK]\t[--] Checking for input file."



# if an input JSON file isn't supplied, defaults to fetching the Directory API schema via curl
# if other files already exist, rename the active one

if [[ -z ${inputFile} ]]
then

    # Log message
    echo -e "[SCHEMA][INPUTCHECK]\t[FAIL] Input file wasn't provided."
    echo -e "[SCHEMA][FILECHECK]\t[--] Checking for previously fetched schemas."


    # Build an array with the saved schema files

    schemaDirContents=( `find ${outputSchemaDir} -name "gapic_AdminSDK_Directory*"` )

    # If there are saved schemas and if the default file exists,
    # move the default file to the next available index

    if ! [[ -z ${schemaDirContents} ]] \
      && [[ -f ${defaultSchemaFile} ]]
    then

        # Log message
        echo -e "[SCHEMA][FILECHECK]\t[WARNING] Found existing schema files in '${outputSchemaDir}'."

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
        echo -e "[SCHEMA][RENAME]\t[OK] Renaming active schema to '${newSchemaName//${outputSchemaDir}/}'."

        # Rename the currently active schema
        mv ${defaultSchemaFile} ${newSchemaName}

    fi
    

    # Log message
    echo -e "[SCHEMA][CURL]\t[--] Fetching API schema via cURL."

    # Then, fetch the schema file via curl, and sort the keys to make the
    # object a bit more consistent when exploring

    curl -s \
    ${inputSchemaUrl} \
    | jq --sort-keys \
    > ${defaultSchemaFile}

    echo -e "[SCHEMA][CURL]\t[OK] Schema saved in '${defaultSchemaFile}'"


    # If the active schema was renamed, compare contents with the 
    # downloaded file; delete the old file if they are the same

    if [[ -f ${newSchemaName} ]]
    then

        # Log message
        echo -e "[SCHEMA][DIFF]\t[--] Comparing downloaded schema with '${newSchemaName//${outputSchemaDir}/}'."
        
        # Google randomizes the JSON keys order each time the file is fetched
        # with `jq -c --sort-keys '.[]' | sort`, it's possible to accurately 
        # capture any differences in the files

        checkDiff=`diff <(cat ${newSchemaName} | jq -c --sort-keys '.[]' | sort) <(cat ${defaultSchemaFile} | jq -c --sort-keys '.[]' | sort)`
        
        # If the created variable with the diff is empty, remove the old file
        # ergo, there are no differences in files. If a  difference is found,
        # log warning to console (and to logfile), keep both files and dump diff

        if [[ -z ${checkDiff} ]]
        then
            echo -e "[SCHEMA][DIFF]\t[OK] API schemas are identical. Removing '${newSchemaName//${outputSchemaDir}/}'."
            rm ${newSchemaName}
        else
            echo -en "[SCHEMA][DIFF]\t[WARNING] Found differences in the schema. Keeping both files"
            echo -e ":\n\n"
            echo ${checkDiff}
            echo -e "\n\n"
        fi
    
    fi
    
    # Always set the input file variable as the default schema file path 

    inputFile=${defaultSchemaFile}

fi

# Testing if input is file

if ! [[ -f ${inputFile} ]]
then
    echo "Invalid input file, please make sure you enter the path to a valid file"
    exit 1
fi

# Testing if input file is JSON-valid

cat "${inputFile}" \
    | jq -c '.' 2>&1 \
    | read -r inputJson

    

if [[ ${inputJson} =~ "parse error" ]]
then
    echo -e "# Invalid JSON, please check your input file and verify it using `jq`. Error details:\n\n${inputJson}"
    exit 1
fi


### Retrieve all available APIs
##### Current exceptions:
##### "resources" - complex tree (.resources.resources.resources.methods), creating exceptions later


apiSets=(`echo ${inputJson} | jq -c '.resources | keys[]' | grep -v "resources" | tr '"' ' '`)

for (( a = 1 ; a <= ${#apiSets[@]} ; a++ ))
do 

    ### Iterate through each API and retrieve its method, and capitalize the variable
    
    localMethods=(`echo ${inputJson} | jq -c ".resources.${apiSets[$a]}.methods | keys[]" | tr '"' ' '`)
    localMethodsFunctions=(${localMethods})

    for (( b = 1 ; b <= ${#localMethods[@]} ; b++ ))
    do

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

apacheLicense > ${outputLibWiz}

cat << EOF >> ${outputLibWiz}

gapicSets=( ${apiSets[@]} )

EOF




# Define function names

for (( a = 1 ; a <= ${#apiSets[@]} ; a++ ))
do
    # define local sets, similar to ${apiSets}
     
    cat << EOF >> ${outputLibWiz}
${apiSets[$a]}=( ${(P)${apiSets[$a]}[@]} )
EOF

done



# loop through all resources

for (( c = 1 ; c <= ${#apiSets[@]} ; c++ ))
do

    # loop through all methods within each resource

    for (( d = 1 ; d <= ${(P)#apiSets[$c]} ; d++ ))
    do

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

        # fetch all available query parameters (not the post data)

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

        cat << EOF >> ${outputLibWiz}
${(P)${apiSets[$c]}[$d]}() {


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

    if [[ -z "\${${curPrefix}${curReqParams[$h]}}" ]]
    then
        if ! [[ -z "\${PARAM_${curReqParams[$h]}}" ]]
        then 
            checkParams ${curReqParams[$h]} "false"
            
        else
            getParams ${curReqParams[$h]}
        fi
        declare -g "${curPrefix}${curReqParams[$h]}=\${${curReqParams[$h]}}"

    fi

    
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

    echo -en "# Would you like to define extra parameters? [y/n] \n\${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ \${optParChoice} =~ "y" ]] || [[ \${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= \${#optParams[@]} ; i++ ))
        do

            select option in none \${optParams}
            do
                if [[ -n \${option} ]]
                then
                    if [[ \${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        clear

                        local optParam=PARAM_\${option}
                        if ! [[ -z "\${(P)\${optParam}}" ]]
                        then 
                            checkParams \${option} "true"

                            if ! [[ \${addedParams} =~ \${option} ]]
                            then
                                ${curPrefix}URL+="\${tempUrlPar}"
                                addedParams+=( "\${option}" )
                                unset tempUrlPar
                            else
                                echo -e "# Error! Parameter already provided before, skipping.\n\n"
                            fi

                        else
                            getParams \${option} "true"
                            ${curPrefix}URL+="\${tempUrlPar}"
                            unset tempUrlPar

                        fi
                        unset optParam
                        
                        break
                    fi
                fi
            done
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

    echo -en "# Would you like to define input parameters? [y/n] \n\${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ \${inpParChoice} =~ "y" ]] || [[ \${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= \${#inpParams[@]} ; i++ ))
        do

            select option in none \${inpParams} 
            do
                if [[ -n \${option} ]]
                then
                    if [[ \${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        clear

                        local optParam=PARAM_\${option}
                        if ! [[ -z "\${(P)\${optParam}}" ]]
                        then 
                            checkParams \${option} "true"

                            if ! [[ \${addedParams} =~ \${option} ]]
                            then
                                ${curPrefix}URL+="\${tempUrlPar}"
                                addedParams+=( "\${option}" )
                                unset tempUrlPar
                            else
                                echo -e "# Error! Parameter already provided before, skipping.\n\n"
                            fi

                        else
                            getParams \${option} "true"
                            ${curPrefix}URL+="\${tempUrlPar}"
                            unset tempUrlPar

                        fi
                        unset optParam

                        break
                    fi
                fi
            done
        done
    fi
EOF
        fi



        cat << EOF >> ${outputLibWiz}
    execRequest() {
    
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

### TODO
# add post request support: --data "{JSON}"

        unset k 

        cat << EOF >> ${outputLibWiz}
            --compressed \\
            | jq -c '.' \\
            | read -r outputJson
        export outputJson

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
        cat << EOIF
        --header "${curHeaderSet[$k]}" \\\ 
EOIF
EOF
        done
        unset curHeaderSet
        cat << EOF >> ${outputLibWiz}
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest
EOF

        unset sentRequest

# Closing the function

        cat << EOF >> ${outputLibWiz}

}

EOF

        unset curPrefix curUrl curReqParams curOptParams curInpParams curMethod
    done
done

chmod +x ${outputExecWiz}