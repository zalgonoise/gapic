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



# Bootstrap by importing wizard files

    gapicBinDir=`realpath $0`
    gapicBinDir=${gapicBinDir//gapic_exec.sh/}
    gapicDataDir=${gapicBinDir//bin/data}
    gapicCredsDir=${gapicBinDir//bin/data\/.creds}
    gapicSchemaDir=${gapicBinDir//bin/schema}
    schemaFile=${gapicSchemaDir}gapic_AdminSDK_Directory.json
    schemaRef=`cat ${schemaFile} | jq '. | "\(.title) \(.version)"'`

    gapicCredsWiz="${gapicBinDir}gapic_creds.sh"
    gapicLibWiz="${gapicBinDir}gapic_lib.sh"
    gapicParamWiz="${gapicBinDir}gapic_paramstore.sh"
    gapicFuzzWiz="${gapicBinDir}gapic_fuzzex.sh"

    gapicSavedPar="${gapicDataDir}.api_params"

gapicBootstrap() {
    if ! [[ -d ${gapicBinDir} ]]
    then 
        mkdir -p ${gapicBinDir}
    fi

    if ! [[ -d ${gapicDataDir} ]]
    then 
        mkdir -p ${gapicDataDir}
    fi

    if ! [[ -f ${gapicCredsWiz} ]]
    then
        clear
        echo -en "# No credentials source file found! Please re-run the generator."
        exit 1
    else
        source ${gapicCredsWiz}
    fi

    if ! [[ -f ${gapicLibWiz} ]]
    then
        clear
        echo -en "# No API library source file found! Please re-run the generator."
        exit 1
    else
        source ${gapicLibWiz}
    fi

    if ! [[ -f ${gapicParamWiz} ]]
    then
        clear
        echo -en "# No parameter store source file found! Please re-run the generator."
        exit 1
    else
        source ${gapicParamWiz}
    fi

    if [[ -f ${gapicSavedPar} ]]
    then
        source ${gapicSavedPar}
    fi

    if ! [[ -f ${gapicFuzzWiz} ]]
    then
        clear
        echo -en "# No FuzzEx source file found! Please re-run the generator."
        exit 1
    else
        source ${gapicFuzzWiz}
    fi

}

# Check for existing credentials and access token

gapicCreds() {

    checkCreds 
    checkScopes "${1}" "${2}" "${3}" "${credPath}/${fileRef}"

}

# Execute the API request

gapicExec() {

    # Display available methods
    if [[ -z ${gapicSets} ]]
    then
        clear
        echo -en "# No API sets found in the source file! Please re-run the generator."
        exit 1
    else
        clear

        echo ${gapicSets} \
        | gapicFuzzyResources ${schemaFile} \
        | read -r option
        
        if ! [[ -n ${option} ]]
        then
            gapicFuzzySchema ${schemaFile}
            exit
        else
            setOption=${option}
            clear
            unset option
        fi
        
    fi

    if [[ -z ${(P)setOption[@]} ]]
    then
        clear
        echo -en "# No API methods found in the source file! Please re-run the generator."
        exit 1
    else
        echo ${(P)setOption[@]} \
        | gapicFuzzyMethods ${schemaFile} ${setOption} \
        | read -r option

        if ! [[ -n ${option} ]]
        then
            gapicFuzzySchema ${schemaFile}
            exit
        else
            methOption=${option}
            clear
            unset option
        fi

    fi

    gapicCreds "${setOption}" "${methOption}" ${schemaFile}

    execOption=${setOption}_${methOption}

    ${execOption}

    if ! [[ -z ${outputJson} ]]
    then
        gapicPostExec
    else
        echo -e "# No JSON output, please debug.\n\n"
    fi
}

# Catch exceptions and handle errors

gapicPostExec() {


    if ! [[ `echo ${outputJson} | jq '.error' | grep null` ]]
    then
        if [[ `echo ${outputJson} | jq '.error.code'` =~ "401" ]] \
        && [[ `echo ${outputJson} | jq '.error.errors[].message'` =~ "Invalid Credentials" ]]
        then
            if ! [[ `cat "${credPath}/${fileRef}" | jq ".authScopes[${activeIndex}].accessToken"` == null ]]
            then
                echo -e "# Invalid Credentials error.\n\n# Removing Access Token to generate a new one:\n\n"
                
                rmCreds "${credPath}/${fileRef}" "${activeIndex}" "accessToken" 
                rebuildAuth "${activeIndex}" "${credPath}/${fileRef}"

                echo -e "# Repeating previously configured request:\n\n"
                execRequest

                ((repeatCount++))
                if ! [[ ${repeatCount} -ge 2 ]]
                then
                    gapicPostExec
                else
                    echo "# Unable to authenticate with the provided credentials. Please relaunch and reauthenticate yourself.\n\n"
                    exit 1
                fi

            if [[ `cat "${credPath}/${fileRef}" | jq ".authScopes[${activeIndex}].accessToken"` == null ]] \
            && ! [[ `cat "${credPath}/${fileRef}" | jq ".authScopes[${activeIndex}].refreshToken"` == null ]]
            then
                echo -e "# Invalid Credentials error.\n\n# Removing Refresh Token and generating a new one:\n\n"

                rmCreds "${credPath}/${fileRef}" "${activeIndex}" "refreshToken" 
                buildAuth "${activeIndex}" "${credPath}/${fileRef}"
                
                echo -e "# Repeating previously configured request:\n\n"
                execRequest

                ((repeatCount++))
                if ! [[ ${repeatCount} -ge 2 ]]
                then
                    gapicPostExec
                else
                    echo "# Unable to authenticate with the provided credentials. Please relaunch and reauthenticate yourself.\n\n"
                    exit 1
                fi

            else
                echo -e "# Error in execution: Invalid Credentials\n\n"
                echo "${outputJson}"
                echo -e "\n\n"
                exit 1
            fi

        else
            echo -e "# Error in execution:\n\n"
            echo "${outputJson}"
            echo -e "\n\n"
            exit 1
        fi
    else
        echo -e "# Execution complete!\n\n"
        echo -e "#########################\n"
        echo "${outputJson}" | jq '.'
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
