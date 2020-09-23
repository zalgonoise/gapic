#!/bin/zsh

## TODO
# test deployment
# doublecheck parameter parsing
# handling post requests (w/ presets & jq)
# doublecheck `clear` events


inputFile=`realpath $1`
output=`realpath $0`
output=${output//gapic.sh/}

outputSrcDir="${output}src/"
outputBinDir="${output}src/bin"
outputDataDir="${output}src/data"
outputCredsWiz="${outputBinDir}/gapic_creds.sh"
outputLibWiz="${outputBinDir}/gapic_lib.sh"
outputExecWiz="${outputBinDir}/gapic_exec.sh"

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

if ! [ -f ${outputCredsWiz} ] \
|| ! [ -f ${outputLibWiz} ] \
|| ! [ -f ${outputExecWiz} ]
then
    touch ${outputCredsWiz} ${outputLibWiz} ${outputExecWiz}
fi

# Prepare output file with exec functions

cat << EOF >> ${outputExecWiz}
#!/bin/zsh

# Bootstrap by importing wizard files

    gapicBinDir=\`realpath \$0\`
    gapicBinDir=\${gapicBinDir//gapic_exec.sh/}
    gapicDataDir=\${gapicBinDir//bin/data}

    gapicCredsWiz="\${gapicBinDir}gapic_creds.sh"
    gapicLibWiz="\${gapicBinDir}gapic_lib.sh"
    gapicSavedPar="\${gapicDataDir}.api_params"

gapicBootstrap() {

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

    if [[ -f \${gapicSavedPar} ]]
    then
        source \${gapicSavedPar}
    fi


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
        select option in \${gapicSets}
        do
            if [[ -n \${option} ]]
            then
                setOption=\${option}
                clear
                break
            fi
        done
    fi
    unset option

    if [[ -z \${(P)setOption[@]} ]]
    then
        clear
        echo -en "# No API methods found in the source file! Please re-run the generator."
        exit 1
    else
        select option in \${(P)setOption[@]}
        do
            if [[ -n \${option} ]]
            then
                methOption=\${option}
                clear
                break
            fi
        done
    fi
    unset option
    gapicCreds
    \${methOption}

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
                echo -e "# Invalid Credentials error.\n\nRemoving Access Token"
                rm \${credFileAccess}
                gapicExec
            elif ! [ -f \${credFileAccess} ] \\
                && [ -f \${credFileRefresh} ]
            then
                echo -e "# Invalid Credentials error.\n\nRemoving Refresh Token"
                rm \${credFileRefresh}
                gapicExec
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

cat << EOF > ${outputCredsWiz}
#!/bin/zsh
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
            echo -e "# Found saved OAuth scope: \${SAVED_OAUTH2_SCOPE}. Do you want to use this one? [y/n]\n~> "
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

            echo -en "# Please visit the URL below to generate an access code. Once authenticated you will be provided a code - paste it below: \n\n "

            offlineCode

            echo -en "\nOffline code\t~> "
            read -r OFFLINECODE

            clear

            sentRequest="curl -s \\ \n    https://accounts.google.com/o/oauth2/token \\ \n    -d code=\${OFFLINECODE} \\ \n    -d client_id=\${CLIENTID} \\ \n    -d client_secret=\${CLIENTSECRET} \\ \n    -d redirect_uri=urn:ietf:wg:oauth:2.0:oob \\ \n    -d grant_type=authorization_code"

            echo -e "# Request sent:\n\n"
            echo -e "#########################\n"
            echo "\${sentRequest}"
            echo -e "\n\n"
            echo -e "#########################\n"

            unset sentRequest

            curl -s \\
            https://accounts.google.com/o/oauth2/token \\
            -d code=\${OFFLINECODE} \\
            -d client_id=\${CLIENTID} \\
            -d client_secret=\${CLIENTSECRET} \\
            -d redirect_uri=urn:ietf:wg:oauth:2.0:oob \\
            -d grant_type=authorization_code \\
            | jq -c '.' | read -r authPayload

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

        fi

    fi


}
EOF

# Testing if input is file


if ! [ -f ${inputFile} ]
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





#apisInFile=`echo ${inputJson} | jq -c '.[].apis[]' | wc -l`
#apiSets=(`echo ${inputJson} | jq -c '.[].set'|tr '"' ' '`)

### Retrieve all available APIs

apiSets=(`echo ${inputJson} | jq -c '.resources | keys[]' | tr '"' ' '`)

for (( a = 1 ; a <= ${#apiSets[@]} ; a++ ))
do 

    ### Iterate through each API and retrieve its method, and capitalize the variable
    
    localMethods=(`echo ${inputJson} | jq -c ".resources.${apiSets[$a]}.methods | keys[]" | grep -v "resources" | tr '"' ' '`)
    localMethods=(${(C)localMethods})

    for (( b = 1 ; b <= ${#localMethods[@]} ; b++ ))
    do

        ### Iterate through each method, prefix the resource to it (for function names)
        ### Also initialize those values as variables (nesting them) to define variable prefixes
        ### such as: usersGet=USERS_GET_

        declare -g "localMethods[$b]=${apiSets[$a]}${localMethods[$b]}"
        declare -g "${apiSets[$a]}${localMethods[$b]}=${(U)apiSets[$a]}_${(U)localMethods[$b]}_"
    
    done
    
    ### Nesting the collected methods into each element of the resources array
    ### so they can be evaluated through it 

    set -A ${apiSets[$a]} ${localMethods}

    ### Method counter for metrics, analytics and debugging

    methodCounter="${(P)#apiSets[$a]}"
    methodCountTotal=$((${methodCountTotal}+${methodCounter}))

done


# Send available API sets to file

cat << EOF >> ${outputLibWiz}
#!/bin/zsh

gapicSets=( ${apiSets[@]} )

EOF

### TODO
#
# remodeling the API library to take in Google's schema
#




# Define function names

for (( a = 1 ; a <= ${#apiSets[@]} ; a++ ))
do
    curSet=${apiSets[$a]}
    curMeth=(`echo ${inputJson} | jq -c ".[((${a}-1))].apis[].name"`)


    curSet=${curSet//\"/}
    curMeth=(${curMeth//\"/})


    set -A ${curSet} ${curMeth[@]}

    # Send available API methods to file

    cat << EOF >> ${outputLibWiz}
${curSet}=( ${curMeth[@]} )
EOF


    for (( b = 1 ; b <= ${#curMeth[@]} ; b++ ))
    do
        curJson=`echo ${inputJson} | jq -c ".[((${a}-1))].apis[((${b}-1))]"`
        set -A ${curMeth[$b]} ${curJson}
        #echo -e "# DEBUG \n\n${curJson}\n\n"
#       unset curJson
    done
#        unset curSet curMeth

done


# Nested arrays, visible with `echo ${(P)apiSets[2][2]}`,
# which shows `echo ${Users[2]}`, or `usersGet` for the function name
# and `echo ${(P)${(P)apiSets[2]}[2]}` which is equal to
# `echo ${(P)Users[2]}`, which is `echo $usersGet`, which is the full
# configuration for the API method, from the JSON file
#
# Zsh indexes start with 1, instead of 0 like in bash






for (( c = 1 ; c <= ${#apiSets[@]} ; c++ ))
do

    for (( d = 1 ; d <= ${(P)#apiSets[$c]} ; d++ ))
    do


        curPrefix=`echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.prefix'`
        curUrl=`echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.url'`
        curMethod=`echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.method'`
        curReqParams=(`echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.reqParams[]'|tr '"' ' '`)

        curHeaderSet=`echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.headers[]'`

        curPrfx=${curPrfx//\"/}
        curUrl=${curUrl//\"/}
        curMethod=${curMethod//\"/}

        echo $curHeaderSet \
            | while IFS=$'\n' read -r line
                do
                    curHeaders+=("$line")
                done
        unset curHeaderSet

        # Define url

        for (( e = 1 ; e <= ${#curReqParams[@]} ; e++))
        do

            if [[ ${curUrl} =~ ${curReqParams[$e]} ]] \
            && ! [[ ${curReqParams[$e]} =~ "CLIENTID" ]]
            then
                curUrl=${curUrl//${curReqParams[$e]}/${curPrefix}${curReqParams[$e]}}
            elif [[ ${curHeaders} =~ ${curReqParams[$e]} ]]
            then
                for (( f = 1 ; f <= ${#curHeaders[@]} ; f++ ))
                do
                    if [[ ${curHeaders[$f]} =~ ${curReqParams[$e]} ]] \
                    && ! [[ ${curReqParams[$e]} =~ "ACCESSTOKEN" ]]
                    then
                        curHeaders[$f]=${curHeaders[$f]//${curReqParams[$e]}/${curPrefix}${curReqParams[$e]}}
                    fi
                done
            fi

        done






        # Check for optional parameters

        [[ `echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.optParams[].name' 2>/dev/null` ]] \
            && {
                curOptParams=(`echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.optParams[].name'|tr '"' ' '`)

                for (( g = 1 ; g <= ${#curOptParams[@]} ; g++ ))
                do
                    curOptParOpt=(`echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c ".optParams[((${g}-1))].opts[]"|tr '"' ' '`)
                    set -A ${curOptParams[${g}]} ${curOptParOpt[@]}
                done
            }

        # Check for custom parameters (mandatory)

        [[ `echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.customParams[].name' 2>/dev/null` ]] \
            && {
                curCustParams=(`echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.customParams[].options[].name'|tr '"' ' '`)
                curCustParamVar=(`echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.customParams[].options[].var'|tr '"' ' '`)

            }

        # Check for input parameters (optional)

        [[ `echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.inputParams[].name' 2>/dev/null` ]] \
            && {
                curInpParams=(`echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.inputParams[].name'|tr '"' ' '`)
                curInpParamType=(`echo ${(P)${(P)apiSets[$c]}[$d]} | jq -c '.inputParams[].type'|tr '"' ' '`)

            }


        curPrefix=${curPrefix//\"/}
        curUrl=${curUrl//\"/}
        curMethod=${curMethod//\"/}

        # Function headers

        cat << EOF >> ${outputLibWiz}
${(P)apiSets[$c][$d]}() {


EOF





        # Function's required parameters
        for (( h = 1 ; h <= ${#curReqParams[@]} ; h++ ))
        do
            if ! [[ ${curReqParams[$h]} =~ "ACCESSTOKEN" ]] \
                && ! [[ ${curReqParams[$h]} =~ "CLIENTID" ]]
            then
                cat << EOF >> "${outputLibWiz}"

    if [[ -z "\${${curPrefix}${curReqParams[$h]}}" ]]
    then

        if ! [[ -z "\${SAVED_REQPAR}" ]] \\
        && [[ \${SAVED_REQPAR} =~ "${curReqParams[$h]}" ]]
        then 
            echo -en "# Do you want to reuse last saved ${curReqParams[$h]}: \${SAVED_REQVAL}? [y/n]\n~> "
            read -r reuseReqParOpt
            clear

            if ! [[ \${reuseReqParOpt} =~ "n" ]] \\
            && ! [[ \${reuseReqParOpt} =~ "N" ]]
            then
                ${curPrefix}REQPAR=\${SAVED_REQPAR}
                ${curPrefix}REQVAL=\${SAVED_REQVAL}
                declare -g "${curPrefix}${curReqParams[$h]}=\${SAVED_REQVAL}"
            else
                echo -en "# Please supply ${curReqParams[$h]}.\n~> "
                read -r ${curPrefix}${curReqParams[$h]}
                clear
                declare -g "SAVED_REQPAR=${curReqParams[$h]}"
                declare -g "SAVED_REQVAL=\${${curPrefix}${curReqParams[$h]}}"


                if [[ -f \${credFileParams} ]] \\
                && ! [[ \`grep "SAVED_REQPAR=${curReqParams[$h]}" \${credFileParams}\` ]] \\
                && ! [[ \`grep "SAVED_REQVAL=\${${curPrefix}${curReqParams[$h]}}" \${credFileParams}\` ]]
                then
                    cat << EOIF >> \${credFileParams}
SAVED_REQPAR=${curReqParams[$h]}
SAVED_REQVAL=\${${curPrefix}${curReqParams[$h]}}
EOIF
                fi
            fi
        else
            echo -en "# Please supply ${curReqParams[$h]}.\n~> "
            read -r ${curPrefix}${curReqParams[$h]}
            clear
            declare -g "SAVED_REQPAR=${curReqParams[$h]}"
            declare -g "SAVED_REQVAL=\${${curPrefix}${curReqParams[$h]}}"

            if [[ -f \${credFileParams} ]] \\
            && ! [[ \`grep "SAVED_REQPAR=${curReqParams[$h]}" \${credFileParams}\` ]] \\
            && ! [[ \`grep "SAVED_REQVAL=\${${curPrefix}${curReqParams[$h]}}" \${credFileParams}\` ]]
            then
                cat << EOIF >> \${credFileParams}
SAVED_REQPAR=${curReqParams[$h]}
SAVED_REQVAL=\${${curPrefix}${curReqParams[$h]}}
EOIF
            fi
        fi
    fi
EOF

                fi
            done

        # Place URL
        cat << EOF >> ${outputLibWiz}

    ${curPrefix}URL="${curUrl}"

EOF

        # Function's custom parameters (mandatory)

        if ! [[ -z ${curCustParams} ]]
        then


            for (( i = 1 ; i <= ${#curCustParams[@]} ; i++ ))
            do
                if [[ ${i} -eq 1 ]]
                then

                    cat << EOF >> ${outputLibWiz}
    if [[ -z \${${curPrefix}${curCustParams[$i]:u}} ]] \\
EOF
                elif [[ ${i} -eq ${#curCustParams[@]} ]]
                then

                    cat << EOF >> ${outputLibWiz}
    && [[ -z \${${curPrefix}${curCustParams[$i]:u}} ]]
EOF
                else

                    cat << EOF >> ${outputLibWiz}
    && [[ -z \${${curPrefix}${curCustParams[$i]:u}} ]] \\
EOF
                fi
            done
        cat << EOF >> ${outputLibWiz}
    then
        echo -e "# Mandatory to define one of the following parameters:"
        select option in ${curCustParams}
        do
            if [[ -n \${option} ]]
            then
                customParameterOption=\${option}
                clear
                break
            fi
        done
        if [[ \${SAVED_CUSTPAR} =~ \${customParameterOption} ]] \\
        && ! [[ -z \${SAVED_CUSTVAL} ]]
        then
            echo -en "# Would you like to use your saved \${SAVED_CUSTPAR}: \${SAVED_CUSTVAL}? [y/n]\n\n~> "
            read -r reuseCustParOpt
            clear

            if ! [[ \${reuseCustParOpt} =~ "n" ]] \\
            && ! [[ \${reuseCustParOpt} =~ "N" ]]
            then
                ${curPrefix}CUSTPAR=\${SAVED_CUSTPAR}
                ${curPrefix}CUSTVAL=\${SAVED_CUSTVAL}
                ${curPrefix}URL+="&\${${curPrefix}CUSTPAR}=\${${curPrefix}CUSTVAL}"
            else

                declare -g "${curPrefix}CUSTPAR=\${customParameterOption}"
                declare -g "SAVED_CUSTPAR=\${customParameterOption}"
                
                echo -en "# Please supply \${customParameterOption:u}.\n\n~> "
                read -r ${curPrefix}CUSTVAL 
                clear
                declare -g "SAVED_CUSTVAL=\${${curPrefix}CUSTVAL}"
                ${curPrefix}URL+="&\${${curPrefix}CUSTPAR}=\${${curPrefix}CUSTVAL}"
            fi
        else
            declare -g "${curPrefix}CUSTPAR=\${customParameterOption}"
            declare -g "SAVED_CUSTPAR=\${customParameterOption}"
            echo -en "# Please supply \${customParameterOption:u}.\n\n~> "
            read -r ${curPrefix}CUSTVAL
            clear

            declare -g "SAVED_CUSTVAL=\${${curPrefix}CUSTVAL}"
            ${curPrefix}URL+="&\${${curPrefix}CUSTPAR}=\${${curPrefix}CUSTVAL}"
        fi

        if [[ -f \${credFileParams} ]] \\
        && ! [[ \`grep "SAVED_CUSTPAR=\${${curPrefix}CUSTPAR}" \${credFileParams}\` ]]
        then
            cat << EOIF >> \${credFileParams}
SAVED_CUSTPAR=\${${curPrefix}CUSTPAR}
EOIF
        fi


        if [[ -f \${credFileParams} ]] \\
        && ! [[ \`grep "SAVED_CUSTVAL=\${${curPrefix}CUSTVAL}" \${credFileParams}\` ]]
        then
            cat << EOIF >> \${credFileParams}
SAVED_CUSTVAL=\${${curPrefix}CUSTVAL}
EOIF
        fi
        clear
    fi
EOF

        fi



# Define optional input parameters
### Define arrays in file


    cat << EOF >> ${outputLibWiz}

    echo -en "# Would you like to define extra input parameters? [y/n] \n~> "
    read -r inputParChoice
    clear


    if [[ \${inputParChoice} =~ "y" ]] || [[ \${inputParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#curInpParams[@]} ; i++ ))
        do

            select option in ${curInpParams} none
            do
                if [[ -n \${option} ]]
                then
                    if [[ \${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        clear
                        echo -en "# Define \${option}:\n~> "
                        read -r inParDef
                        clear

                        declare -g "${curPrefix}PAR_\${option:u}=\${inParDef}"
                        declare -g "SAVED_PAR_\${option:u}=\${inParDef}"

                        ${curPrefix}URL+="&\${option}=\${inParDef}"

                        break
                    fi
                fi
            done
        done
    fi

    unset inputParChoice option
EOF

if ! [[ -z ${curOptParams} ]]
then
    cat << EOF >> ${outputLibWiz}

    ${curPrefix}OPTPARAMS=( ${curOptParams[@]} )
EOF

for (( j = 1 ; j <= ${#curOptParams[@]} ; j++ ))
do
    cat << EOF >> ${outputLibWiz}
    ${curOptParams[j]}=( ${(P)curOptParams[j]} )
EOF
done

    cat << EOF >> ${outputLibWiz}

    echo -en "# Would you like to define any of these preset parameters? [y/n]\n~> "
    read -r inputOptChoice
    clear

    if [[ \${inputOptChoice} =~ "y" ]] || [[ \${inputOptChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#curOptParams[@]} ; i++ ))
        do

            select option in ${curOptParams} none
            do
                if [[ -n \${option} ]]
                then
                    if [[ \${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        select sec_option in \${(P)option} none
                        do
                            if [[ -n \${sec_option} ]]
                            then
                                if [[ \${sec_option} =~ "none" ]]
                                then
                                    clear
                                    break 2
                                else
                                    clear
                                    declare -g "${curPrefix}PAR_NAME=\${option}"
                                    declare -g "${curPrefix}PAR_VAL=\${sec_option}"
                                    declare -g "SAVED_PAR_NAME=\${option}"
                                    declare -g "SAVED_PAR_VAL=\${sec_option}"
                                    ${curPrefix}URL+="&\${option}=\${sec_option}"
                                    break 2
                                fi
                            fi
                        done
                    fi
                fi
            done
        done
    fi

    unset inputParChoice


EOF
fi


# Define curl


cat << EOF >> ${outputLibWiz}

    curl -s \\
        --request ${curMethod} \\
        \${${curPrefix}URL} \\
EOF

sentRequest="curl -s \n    --request ${curMethod} \n    \${${curPrefix}URL} \n"

for (( k = 1 ; k <= ${#curHeaders[@]} ; k++ ))
do
    cat << EOF >> ${outputLibWiz}
        --header ${curHeaders[$k]} \\
EOF
sentRequest+="    --header ${curHeaders[$k]//\"/\\\"}\n"

done
sentRequest+="    --compressed"

unset k curHeaders

cat << EOF >> ${outputLibWiz}
        --compressed \\
        | jq -c '.' \\
        | read -r outputJson
        export outputJson

        sentRequest="${sentRequest}"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "\${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"

EOF

unset sentRequest

# Closing the function

cat << EOF >> ${outputLibWiz}

}

EOF

        unset curPrefix curUrl curReqParams curMethod
    done
done

chmod +x ${outputExecWiz}
