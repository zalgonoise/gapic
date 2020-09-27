#!/bin/zsh

# Bootstrap by importing wizard files

    gapicBinDir=`realpath $0`
    gapicBinDir=${gapicBinDir//gapic_exec.sh/}
    gapicDataDir=${gapicBinDir//bin/data}

    gapicCredsWiz="${gapicBinDir}gapic_creds.sh"
    gapicLibWiz="${gapicBinDir}gapic_lib.sh"
    gapicParamWiz="${gapicBinDir}gapic_paramstore.sh"

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
    if [[ -z ${gapicSets} ]]
    then
        clear
        echo -en "# No API sets found in the source file! Please re-run the generator."
        exit 1
    else
        clear
        select option in ${gapicSets}
        do
            if [[ -n ${option} ]]
            then
                setOption=${option}
                clear
                break
            fi
        done
    fi
    unset option

    if [[ -z ${(P)setOption[@]} ]]
    then
        clear
        echo -en "# No API methods found in the source file! Please re-run the generator."
        exit 1
    else
        select option in ${(P)setOption[@]}
        do
            if [[ -n ${option} ]]
            then
                methOption=${option}
                clear
                break
            fi
        done
    fi
    unset option
    gapicCreds
    ${methOption}

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
            if [ -f ${credFileAccess} ]
            then
                echo -e "# Invalid Credentials error.\n\nRemoving Access Token"
                rm ${credFileAccess}
                gapicExec
            elif ! [ -f ${credFileAccess} ] \
                && [ -f ${credFileRefresh} ]
            then
                echo -e "# Invalid Credentials error.\n\nRemoving Refresh Token"
                rm ${credFileRefresh}
                gapicExec
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
