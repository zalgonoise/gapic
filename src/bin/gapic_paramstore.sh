#!/bin/zsh

# handle storing parameters

getParams() {
    local tempPar=${1}
    local urlVar=${2}

    local tempCarrier=PARAM_${tempPar}
    local tempMeta=${tempPar}Meta
    local tempVal="${(P)tempPar}"

    if [[ -z ${(P)${tempMeta}[3]} ]]
    then
        echo -en "# Please supply a value for the ${tempPar} parameter (${(P)${tempMeta}[1]}).\n#\n# Desc: ${(P)${tempMeta}[2]}\n~> "
        read -r getOption
        declare -g "tempVal=${getOption}"
        unset getOption 
        clear

    else
        tempOpts=(`echo ${(P)${tempMeta}[3]} | jq -r ".[]"`)
        echo -en "# Please supply a value for the ${tempPar} parameter (${(P)${tempMeta}[1]}).\n#\n# Desc: ${(P)${tempMeta}[2]}\n~> "
        select getOption in ${tempOpts}
        do
            if [[ -n ${getOption} ]]
            then
                declare -g "tempVal=${getOption}"
                clear
                break
            fi
        done
        unset getOption 
    fi
    unset tempParMeta

    if ! [[ -z "${tempVal}" ]]
    then

        declare -g "${tempPar}=${tempVal}"
        if [[ "${urlVar}" =~ "true" ]]
        then
            declare -g "tempUrlPar=&${tempPar}=${(P)${tempPar}}"
        fi


        if [[ -f ${credFileParams} ]]
        then
            if ! [[ `grep "${tempCarrier}" ${credFileParams}` ]]
            then 
                cat << EOIF >> ${credFileParams}
${tempCarrier}=( ${(P)${tempPar}} )
EOIF
            else 
                if ! [[ `egrep "\<${tempCarrier}\>.*\<${(P)${tempPar}}\>" ${credFileParams}` ]]
                then
                    cat << EOIF >> ${credFileParams}
${tempCarrier}+=( ${(P)${tempPar}} )
EOIF
                fi
            fi
        else
            touch ${credFileParams}
            cat << EOIF >> ${credFileParams}
${tempCarrier}=( ${(P)${tempPar}} )
EOIF
        fi
    fi
    unset tempPar tempCarrier tempVal
}

# Handle saved parameters

checkParams() {
    local tempPar=${1}
    local urlVar=${2}

    tempCarrier=PARAM_${tempPar}
    echo -en "# You have saved values for the ${tempPar} parameter. Do you want to use one?\n\n"
    select checkOption in none ${(P)${tempCarrier}} "remove a parameter"
    do
        if [[ -n ${checkOption} ]]
        then
            if [[ ${checkOption} =~ "none" ]]
            then
                clear
                getParams ${tempPar} ${urlVar}
                break
            elif [[ ${checkOption} =~ "remove a parameter" ]]
            then
                rmParams ${tempPar}
            else
                clear
                declare -g "${tempPar}=${checkOption}"

                if [[ "${urlVar}" =~ "true" ]]
                then
                    declare -g "tempUrlPar=&${tempPar}=${(P)${tempPar}}"
                fi
                
                unset checkOption
                break
            fi
        
        fi
    done


    if [[ -z "${(P)${tempPar}}" ]]
    then
        getParams ${tempPar} ${urlVar}
    fi
    unset tempPar reuseParOpt tempCarrier
}



# Handle parameter removal

rmParams() {
    local paramToRemove=${1}

    echo -e "# Fetching the parameter store for saved results on ${paramToRemove}:\n"
    
    paramResults=( `grep -n "${paramToRemove}" ${gapicSavedPar} | tr ')' ' '` )
    
    for (( x = 1 ; x <= ${#paramResults[@]} ; x++ ))
    do
        paramResKeys+=( "${paramResults[$x]}" )
        ((x++))
        paramResVals+=( "${paramResults[$x]}" )
    done

    select remOpt in none ${paramResVals[@]}
    do
        if [[ -n ${remOpt} ]]
        then
            if [[ "${remOpt}" =~ "none" ]]
            then
                break
            else
                lineToRemove=`egrep -n "\<PARAM_${paramToRemove}\>.*\<${remOpt}\>" ${gapicSavedPar} | tr ':' ' ' | awk '{print $1}' `
                if ! [[ -z ${lineToRemove} ]]
                then
                    sed -i "${lineToRemove}d" ${gapicSavedPar}
                    echo -e "Removed parameter '${remOpt}' from parameter store!\n\n"
                fi
                break
            fi
        fi
    done


}

