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


# param-store v2 (json)

### must validate whether object already exists
### to either call getParams() or checkParams()

genParamConfig() {
    cat ${credPath}/${fileRef} \
    | jq -c '.param=[]' \
    | read -r newPayload

    if [[ `echo ${newPayload} | jq -c ` ]]
    then 
        echo ${newPayload} \
        | jq \
        > ${credPath}/${fileRef}
    fi
}

paramsRevListBuild() {
    jq -c ".${1}=[${2},.${1}[]]" \
    | read -r requestPayload

    echo ${requestPayload}
}

paramBuild() {
    echo ${3} \
    | paramsRevListBuild "${1}" "\"${2}\"" \
    | read -r paramNewEntry

    cat ${credPath}/${fileRef} \
    | jq -c ".param=[.param[],${paramNewEntry}]" \
    | read -r newParamPayload

    if [[ `echo ${newParamPayload} | jq -c ` ]]
    then 
        echo ${newParamPayload} \
        | jq \
        > ${credPath}/${fileRef}
    fi

}

addParams() {
    keyValue=( `cat ${3} | jq -r ".param[] | keys[] " ` )

    for (( index = 1 ; index <= ${#keyValue[@]} ; index++ ))
    do
        if [[ "${keyValue[${index}]}" == "${1}" ]]
        then 
            keyIndex=$((${index}-1))
        fi
    done

    modParams=( `cat ${3} | jq -r ".param[] | select(.${1})[] | .[]" ` )

    newList="[\"${2}\"]"

    for (( par = 1 ; par <= ${#modParams[@]} ; par++ ))
    do 
        echo ${newList} \
        | jq -c ".=[.[],\"${modParams[${par}]}\"]" \
        | read -r newList
    done

    cat ${3} \
    | jq -c ".param[${keyIndex}].${1}=${newList}" \
    | read -r newParamPayload
    
    if [[ `echo ${newParamPayload} | jq -c ` ]]
    then 
        echo ${newParamPayload} \
        | jq \
        > ${3}
    fi

}

# Handle parameter removal

rmParams() {
    keyValue=( `cat ${3} | jq -r ".param[] | keys[] " ` )

    for (( index = 1 ; index <= ${#keyValue[@]} ; index++ ))
    do
        if [[ "${keyValue[${index}]}" == "${1}" ]]
        then 
            keyIndex=$((${index}-1))
        fi
    done

    modParams=( `cat ${3} | jq -r ".param[] | select(.${1})[] | .[]" | grep -v "${2}"` )

    newList="[]"

    for (( par = 1 ; par <= ${#modParams[@]} ; par++ ))
    do 
        echo ${newList} \
        | jq -c ".=[.[],\"${modParams[${par}]}\"]" \
        | read -r newList
    done

    cat ${3} \
    | jq -c ".param[${keyIndex}].${1}=${newList}" \
    | read -r newParamPayload
    
    if [[ `echo ${newParamPayload} | jq -c ` ]]
    then 
        echo ${newParamPayload} \
        | jq \
        > ${3}
    fi

}



getParams() {
    local sourceRef=${1}
    local tempPar=${2}
    local urlVar=${3}
    local apiRef=(`echo ${sourceRef//_/ }` )
    local tempMeta="${2}Meta"

    jq -cn \
    "{${tempPar}:[]}" \
    | read -r paramPayload

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
        
        echo "${tempOpts}" \
        | fuzzExOptParameters "${apiRef[1]}" "${apiRef[2]}" "${tempPar}" \
        | read -r getOption

        if [[ -n ${getOption} ]]
        then
            declare -g "tempVal=${getOption}"
            clear
        fi
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

        addParams "${tempPar}" "${tempVal}" "${credPath}/${fileRef}"

    fi
    unset tempPar tempVal

}

# Handle saved parameters - v2 (json)

checkParams() {
    local sourceRef=${1}
    local tempPar=${2}
    local urlVar=${3}

    local apiRef=(`echo ${sourceRef//_/ }` )

    echo -en "# You have saved values for the ${tempPar} parameter. Do you want to use one?\n\n"

    savedParams=( `cat ${credPath}/${fileRef} | jq -rc ".param[] | select(.${tempPar})[] | .[]"` )

    if ! [[ -z ${savedParams} ]]
    then 
        echo "${savedParams[@]} [none]" \
        | fuzzExSimpleParameters "${apiRef[1]}" "${apiRef[2]}" "${tempPar}" \
        | read -r checkOption
        
        if [[ -n ${checkOption} ]]
        then
            if [[ ${checkOption} == "[none]" ]]
            then
                clear
                unset checkOption
                getParams ${1} ${2} ${3}
            else
                clear
                declare -g "${tempPar}=${checkOption}"
                if [[ "${urlVar}" == "true" ]]
                then
                    declare -g "tempUrlPar=&${tempPar}=${(P)${tempPar}}"
                fi
                
                unset checkOption
            fi
        else
            getParams ${1} ${2} ${3}
        fi
    else
        getParams ${1} ${2} ${3}
    fi

    if [[ -z "${(P)${tempPar}}" ]]
    then
        getParams ${sourceRef} ${tempPar} ${urlVar}
    fi
    unset tempPar reuseParOpt 
}

