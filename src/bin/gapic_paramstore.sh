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

    #--bind "ctrl-r:execute% cat ${1}  | jq --sort-keys -C ..resources.${2}.methods.${3}.parameters.{} | less -R > /dev/tty 2>&1 %" \

fuzzExSimpleParameters() {
    sed 's/ /\n/g' \
    | fzf \
    --bind "tab:replace-query" \
    --bind "change:top" \
    --layout=reverse-list \
    --prompt="~ " \
    --pointer="~ " \
    --header="# Fuzzy Object Explorer #" \
    --color=dark \
    --black \

}


checkParams() {
    local tempPar=${1}
    local urlVar=${2}

    tempCarrier=PARAM_${tempPar}
    echo -en "# You have saved values for the ${tempPar} parameter. Do you want to use one?\n\n"
    
    echo "${(P)${tempCarrier}} [none] [remove]" \
    | fuzzExSimpleParameters \
    | read -r checkOption
    
    if [[ -n ${checkOption} ]]
    then
        if [[ ${checkOption} == "[none]" ]]
        then
            clear
            getParams ${tempPar} ${urlVar}
        elif [[ ${checkOption} == "[remove]" ]]
        then
            rmParams ${tempPar}
        else
            clear
            declare -g "${tempPar}=${checkOption}"
            if [[ "${urlVar}" == "true" ]]
            then
                declare -g "tempUrlPar=&${tempPar}=${(P)${tempPar}}"
            fi
            
            unset checkOption
        fi
    
    fi


    if [[ -z "${(P)${tempPar}}" ]]
    then
        getParams ${tempPar} ${urlVar}
    fi
    unset tempPar reuseParOpt tempCarrier
}



# Handle parameter removal

rmParams() {
    local paramToRemove=${1}

    echo -e "# Fetching the parameter store for saved results on ${paramToRemove} to remove:\n"
    
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

