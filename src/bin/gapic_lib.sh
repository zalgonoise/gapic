#!/bin/zsh

gapicSets=( asps channels chromeosdevices customers domainAliases domains groups members mobiledevices orgunits privileges roleAssignments roles schemas tokens twoStepVerification users verificationCodes )

asps=( asps_delete asps_get asps_list )
channels=( channels_stop )
chromeosdevices=( chromeosdevices_action chromeosdevices_get chromeosdevices_list chromeosdevices_moveDevicesToOu chromeosdevices_patch chromeosdevices_update )
customers=( customers_get customers_patch customers_update )
domainAliases=( domainAliases_delete domainAliases_get domainAliases_insert domainAliases_list )
domains=( domains_delete domains_get domains_insert domains_list )
groups=( groups_delete groups_get groups_insert groups_list groups_patch groups_update )
members=( members_delete members_get members_hasMember members_insert members_list members_patch members_update )
mobiledevices=( mobiledevices_action mobiledevices_delete mobiledevices_get mobiledevices_list )
orgunits=( orgunits_delete orgunits_get orgunits_insert orgunits_list orgunits_patch orgunits_update )
privileges=( privileges_list )
roleAssignments=( roleAssignments_delete roleAssignments_get roleAssignments_insert roleAssignments_list )
roles=( roles_delete roles_get roles_insert roles_list roles_patch roles_update )
schemas=( schemas_delete schemas_get schemas_insert schemas_list schemas_patch schemas_update )
tokens=( tokens_delete tokens_get tokens_list )
twoStepVerification=( twoStepVerification_turnOff )
users=( users_delete users_get users_insert users_list users_makeAdmin users_patch users_signOut users_undelete users_update users_watch )
verificationCodes=( verificationCodes_generate verificationCodes_invalidate verificationCodes_list )

getParams() {
    local tempPar=${1}

    if [[ -z ${(P)${tempPar}[3]} ]]
    then
        echo -en "# Please supply a value for the ${tempPar} parameter (${(P)${tempPar}[1]}).\n#\n# Desc: ${(P)${tempPar}[2]}\n~> "
        read -r PARAM_${tempPar}
        export PARAM_${tempPar}
        clear

    else
        tempOpts=(`echo ${(PQ)${tempPar}[3]} | jq -r ".[]"`)
        echo -en "# Please supply a value for the ${tempPar} parameter (${(P)${tempPar}[1]}).\n#\n# Desc: ${(P)${tempPar}[2]}\n"
        select getOption in ${tempOpts}
        do
            if [[ -n ${getOption} ]]
            then
                declare -g "PARAM_${tempPar}=${getOption}"
                clear
                break
            fi
        done
        unset getOption 
    fi

    declare -g "${tempPar}=${PARAM_${tempPar}}"

    if [[ -f ${credFileParams} ]]
    then
        if ! [[ `grep "PARAM_${tempPar}=${tempPar}" ${credFileParams}` ]]
        then
            cat << EOIF >> ${credFileParams}
PARAM_${tempPar}=${tempPar}
EOIF
        fi

    else
        touch ${credFileParams}
        cat << EOIF >> ${credFileParams}
PARAM_${tempPar}=${tempPar}
EOIF
    fi

    unset tempPar
}




checkParams() {
    local tempPar=${1}
    echo -en "# Do you want to reuse last saved domain parameter: ${PARAM_${tempPar}}? [y/n]\n~> "
    read -r reuseParOpt
    clear
    if ! [[ ${reuseParOpt} =~ "n" ]] \
    && ! [[ ${reuseParOpt} =~ "N" ]]
    then
        declare -g "${tempPar}=${PARAM_${tempPar}}"
        declare -g "${tempPar}=${PARAM_${tempPar}}"
    else
        getParams ${tempPar}
    fi
    unset tempPar reuseParOpt
}


asps_delete() {


    codeId=( 
 'integer'
 'The unique ID of the ASP to be deleted.'
 )

    if [[ -z "${ASPS_DELETE_codeId}" ]]
    then
        if ! [[ -z "${PARAM_codeId}" ]]
        then 
            checkParams codeId
            
        else
            getParams codeId
        fi
        declare -g "ASPS_DELETE_codeId=${PARAM_codeId}"
        declare -g "codeId=${PARAM_codeId}"

    fi

    
    userKey=( 
 'string'
 'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
 )

    if [[ -z "${ASPS_DELETE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "ASPS_DELETE_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    ASPS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/asps/${codeId}?key=${CLIENTID}"


    curl -s \
        --request DELETE \
        ${ASPS_DELETE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request DELETE \\ \\n    \${ASPS_DELETE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

asps_get() {


    codeId=( 
 'integer'
 'The unique ID of the ASP.'
 )

    if [[ -z "${ASPS_GET_codeId}" ]]
    then
        if ! [[ -z "${PARAM_codeId}" ]]
        then 
            checkParams codeId
            
        else
            getParams codeId
        fi
        declare -g "ASPS_GET_codeId=${PARAM_codeId}"
        declare -g "codeId=${PARAM_codeId}"

    fi

    
    userKey=( 
 'string'
 'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
 )

    if [[ -z "${ASPS_GET_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "ASPS_GET_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    ASPS_GET_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/asps/${codeId}?key=${CLIENTID}"


    curl -s \
        --request GET \
        ${ASPS_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${ASPS_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

asps_list() {


    userKey=( 
 'string'
 'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
 )

    if [[ -z "${ASPS_LIST_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "ASPS_LIST_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    ASPS_LIST_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/asps?key=${CLIENTID}"


    curl -s \
        --request GET \
        ${ASPS_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${ASPS_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

channels_stop() {



    CHANNELS_STOP_URL="https://www.googleapis.com/admin/directory_v1/channels/stop?key=${CLIENTID}"


    curl -s \
        --request POST \
        ${CHANNELS_STOP_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${CHANNELS_STOP_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

chromeosdevices_action() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${CHROMEOSDEVICES_ACTION_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "CHROMEOSDEVICES_ACTION_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    resourceId=( 
 'string'
 'Immutable ID of Chrome OS Device'
 )

    if [[ -z "${CHROMEOSDEVICES_ACTION_resourceId}" ]]
    then
        if ! [[ -z "${PARAM_resourceId}" ]]
        then 
            checkParams resourceId
            
        else
            getParams resourceId
        fi
        declare -g "CHROMEOSDEVICES_ACTION_resourceId=${PARAM_resourceId}"
        declare -g "resourceId=${PARAM_resourceId}"

    fi

    

    CHROMEOSDEVICES_ACTION_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/${resourceId}/action?key=${CLIENTID}"


    curl -s \
        --request POST \
        ${CHROMEOSDEVICES_ACTION_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${CHROMEOSDEVICES_ACTION_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

chromeosdevices_get() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${CHROMEOSDEVICES_GET_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "CHROMEOSDEVICES_GET_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    deviceId=( 
 'string'
 'Immutable ID of Chrome OS Device'
 )

    if [[ -z "${CHROMEOSDEVICES_GET_deviceId}" ]]
    then
        if ! [[ -z "${PARAM_deviceId}" ]]
        then 
            checkParams deviceId
            
        else
            getParams deviceId
        fi
        declare -g "CHROMEOSDEVICES_GET_deviceId=${PARAM_deviceId}"
        declare -g "deviceId=${PARAM_deviceId}"

    fi

    

    CHROMEOSDEVICES_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/${deviceId}?key=${CLIENTID}"

    optParams=( projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CHROMEOSDEVICES_GET_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${CHROMEOSDEVICES_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${CHROMEOSDEVICES_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

chromeosdevices_list() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${CHROMEOSDEVICES_LIST_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "CHROMEOSDEVICES_LIST_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    

    CHROMEOSDEVICES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CHROMEOSDEVICES_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CHROMEOSDEVICES_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${CHROMEOSDEVICES_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${CHROMEOSDEVICES_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

chromeosdevices_moveDevicesToOu() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${CHROMEOSDEVICES_MOVEDEVICESTOOU_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "CHROMEOSDEVICES_MOVEDEVICESTOOU_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    orgUnitPath=( 
 'string'
 'Full path of the target organizational unit or its ID'
 )

    if [[ -z "${CHROMEOSDEVICES_MOVEDEVICESTOOU_orgUnitPath}" ]]
    then
        if ! [[ -z "${PARAM_orgUnitPath}" ]]
        then 
            checkParams orgUnitPath
            
        else
            getParams orgUnitPath
        fi
        declare -g "CHROMEOSDEVICES_MOVEDEVICESTOOU_orgUnitPath=${PARAM_orgUnitPath}"
        declare -g "orgUnitPath=${PARAM_orgUnitPath}"

    fi

    

    CHROMEOSDEVICES_MOVEDEVICESTOOU_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/moveDevicesToOu?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CHROMEOSDEVICES_MOVEDEVICESTOOU_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CHROMEOSDEVICES_MOVEDEVICESTOOU_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${CHROMEOSDEVICES_MOVEDEVICESTOOU_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${CHROMEOSDEVICES_MOVEDEVICESTOOU_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

chromeosdevices_patch() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${CHROMEOSDEVICES_PATCH_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "CHROMEOSDEVICES_PATCH_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    deviceId=( 
 'string'
 'Immutable ID of Chrome OS Device'
 )

    if [[ -z "${CHROMEOSDEVICES_PATCH_deviceId}" ]]
    then
        if ! [[ -z "${PARAM_deviceId}" ]]
        then 
            checkParams deviceId
            
        else
            getParams deviceId
        fi
        declare -g "CHROMEOSDEVICES_PATCH_deviceId=${PARAM_deviceId}"
        declare -g "deviceId=${PARAM_deviceId}"

    fi

    

    CHROMEOSDEVICES_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/${deviceId}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CHROMEOSDEVICES_PATCH_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CHROMEOSDEVICES_PATCH_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PATCH \
        ${CHROMEOSDEVICES_PATCH_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PATCH \\ \\n    \${CHROMEOSDEVICES_PATCH_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

chromeosdevices_update() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${CHROMEOSDEVICES_UPDATE_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "CHROMEOSDEVICES_UPDATE_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    deviceId=( 
 'string'
 'Immutable ID of Chrome OS Device'
 )

    if [[ -z "${CHROMEOSDEVICES_UPDATE_deviceId}" ]]
    then
        if ! [[ -z "${PARAM_deviceId}" ]]
        then 
            checkParams deviceId
            
        else
            getParams deviceId
        fi
        declare -g "CHROMEOSDEVICES_UPDATE_deviceId=${PARAM_deviceId}"
        declare -g "deviceId=${PARAM_deviceId}"

    fi

    

    CHROMEOSDEVICES_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/${deviceId}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CHROMEOSDEVICES_UPDATE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CHROMEOSDEVICES_UPDATE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PUT \
        ${CHROMEOSDEVICES_UPDATE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PUT \\ \\n    \${CHROMEOSDEVICES_UPDATE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

customers_get() {


    customerKey=( 
 'string'
 'Id of the customer to be retrieved'
 )

    if [[ -z "${CUSTOMERS_GET_customerKey}" ]]
    then
        if ! [[ -z "${PARAM_customerKey}" ]]
        then 
            checkParams customerKey
            
        else
            getParams customerKey
        fi
        declare -g "CUSTOMERS_GET_customerKey=${PARAM_customerKey}"
        declare -g "customerKey=${PARAM_customerKey}"

    fi

    

    CUSTOMERS_GET_URL="https://www.googleapis.com/admin/directory/v1/customers/${customerKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CUSTOMERS_GET_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CUSTOMERS_GET_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${CUSTOMERS_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${CUSTOMERS_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

customers_patch() {


    customerKey=( 
 'string'
 'Id of the customer to be updated'
 )

    if [[ -z "${CUSTOMERS_PATCH_customerKey}" ]]
    then
        if ! [[ -z "${PARAM_customerKey}" ]]
        then 
            checkParams customerKey
            
        else
            getParams customerKey
        fi
        declare -g "CUSTOMERS_PATCH_customerKey=${PARAM_customerKey}"
        declare -g "customerKey=${PARAM_customerKey}"

    fi

    

    CUSTOMERS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customers/${customerKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CUSTOMERS_PATCH_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CUSTOMERS_PATCH_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PATCH \
        ${CUSTOMERS_PATCH_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PATCH \\ \\n    \${CUSTOMERS_PATCH_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

customers_update() {


    customerKey=( 
 'string'
 'Id of the customer to be updated'
 )

    if [[ -z "${CUSTOMERS_UPDATE_customerKey}" ]]
    then
        if ! [[ -z "${PARAM_customerKey}" ]]
        then 
            checkParams customerKey
            
        else
            getParams customerKey
        fi
        declare -g "CUSTOMERS_UPDATE_customerKey=${PARAM_customerKey}"
        declare -g "customerKey=${PARAM_customerKey}"

    fi

    

    CUSTOMERS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customers/${customerKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CUSTOMERS_UPDATE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        CUSTOMERS_UPDATE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PUT \
        ${CUSTOMERS_UPDATE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PUT \\ \\n    \${CUSTOMERS_UPDATE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

domainAliases_delete() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${DOMAINALIASES_DELETE_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "DOMAINALIASES_DELETE_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    
    domainAliasName=( 
 'string'
 'Name of domain alias to be retrieved.'
 )

    if [[ -z "${DOMAINALIASES_DELETE_domainAliasName}" ]]
    then
        if ! [[ -z "${PARAM_domainAliasName}" ]]
        then 
            checkParams domainAliasName
            
        else
            getParams domainAliasName
        fi
        declare -g "DOMAINALIASES_DELETE_domainAliasName=${PARAM_domainAliasName}"
        declare -g "domainAliasName=${PARAM_domainAliasName}"

    fi

    

    DOMAINALIASES_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domainaliases/${domainAliasName}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINALIASES_DELETE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINALIASES_DELETE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request DELETE \
        ${DOMAINALIASES_DELETE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request DELETE \\ \\n    \${DOMAINALIASES_DELETE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

domainAliases_get() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${DOMAINALIASES_GET_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "DOMAINALIASES_GET_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    
    domainAliasName=( 
 'string'
 'Name of domain alias to be retrieved.'
 )

    if [[ -z "${DOMAINALIASES_GET_domainAliasName}" ]]
    then
        if ! [[ -z "${PARAM_domainAliasName}" ]]
        then 
            checkParams domainAliasName
            
        else
            getParams domainAliasName
        fi
        declare -g "DOMAINALIASES_GET_domainAliasName=${PARAM_domainAliasName}"
        declare -g "domainAliasName=${PARAM_domainAliasName}"

    fi

    

    DOMAINALIASES_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domainaliases/${domainAliasName}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINALIASES_GET_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINALIASES_GET_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${DOMAINALIASES_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${DOMAINALIASES_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

domainAliases_insert() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${DOMAINALIASES_INSERT_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "DOMAINALIASES_INSERT_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    

    DOMAINALIASES_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domainaliases?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINALIASES_INSERT_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINALIASES_INSERT_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${DOMAINALIASES_INSERT_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${DOMAINALIASES_INSERT_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

domainAliases_list() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${DOMAINALIASES_LIST_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "DOMAINALIASES_LIST_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    

    DOMAINALIASES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domainaliases?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINALIASES_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINALIASES_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${DOMAINALIASES_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${DOMAINALIASES_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

domains_delete() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${DOMAINS_DELETE_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "DOMAINS_DELETE_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    
    domainName=( 
 'string'
 'Name of domain to be deleted'
 )

    if [[ -z "${DOMAINS_DELETE_domainName}" ]]
    then
        if ! [[ -z "${PARAM_domainName}" ]]
        then 
            checkParams domainName
            
        else
            getParams domainName
        fi
        declare -g "DOMAINS_DELETE_domainName=${PARAM_domainName}"
        declare -g "domainName=${PARAM_domainName}"

    fi

    

    DOMAINS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domains/${domainName}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINS_DELETE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINS_DELETE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request DELETE \
        ${DOMAINS_DELETE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request DELETE \\ \\n    \${DOMAINS_DELETE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

domains_get() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${DOMAINS_GET_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "DOMAINS_GET_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    
    domainName=( 
 'string'
 'Name of domain to be retrieved'
 )

    if [[ -z "${DOMAINS_GET_domainName}" ]]
    then
        if ! [[ -z "${PARAM_domainName}" ]]
        then 
            checkParams domainName
            
        else
            getParams domainName
        fi
        declare -g "DOMAINS_GET_domainName=${PARAM_domainName}"
        declare -g "domainName=${PARAM_domainName}"

    fi

    

    DOMAINS_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domains/${domainName}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINS_GET_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINS_GET_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${DOMAINS_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${DOMAINS_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

domains_insert() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${DOMAINS_INSERT_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "DOMAINS_INSERT_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    

    DOMAINS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domains?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINS_INSERT_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINS_INSERT_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${DOMAINS_INSERT_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${DOMAINS_INSERT_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

domains_list() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${DOMAINS_LIST_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "DOMAINS_LIST_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    

    DOMAINS_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domains?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINS_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        DOMAINS_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${DOMAINS_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${DOMAINS_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

groups_delete() {


    groupKey=( 
 'string'
 'Email or immutable ID of the group'
 )

    if [[ -z "${GROUPS_DELETE_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groupKey
            
        else
            getParams groupKey
        fi
        declare -g "GROUPS_DELETE_groupKey=${PARAM_groupKey}"
        declare -g "groupKey=${PARAM_groupKey}"

    fi

    

    GROUPS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        GROUPS_DELETE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        GROUPS_DELETE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request DELETE \
        ${GROUPS_DELETE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request DELETE \\ \\n    \${GROUPS_DELETE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

groups_get() {


    groupKey=( 
 'string'
 'Email or immutable ID of the group'
 )

    if [[ -z "${GROUPS_GET_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groupKey
            
        else
            getParams groupKey
        fi
        declare -g "GROUPS_GET_groupKey=${PARAM_groupKey}"
        declare -g "groupKey=${PARAM_groupKey}"

    fi

    

    GROUPS_GET_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        GROUPS_GET_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        GROUPS_GET_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${GROUPS_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${GROUPS_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

groups_insert() {



    GROUPS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/groups?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        GROUPS_INSERT_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        GROUPS_INSERT_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${GROUPS_INSERT_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${GROUPS_INSERT_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

groups_list() {



    GROUPS_LIST_URL="https://www.googleapis.com/admin/directory/v1/groups?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        GROUPS_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        GROUPS_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${GROUPS_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${GROUPS_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

groups_patch() {


    groupKey=( 
 'string'
 'Email or immutable ID of the group. If ID, it should match with id of group object'
 )

    if [[ -z "${GROUPS_PATCH_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groupKey
            
        else
            getParams groupKey
        fi
        declare -g "GROUPS_PATCH_groupKey=${PARAM_groupKey}"
        declare -g "groupKey=${PARAM_groupKey}"

    fi

    

    GROUPS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        GROUPS_PATCH_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        GROUPS_PATCH_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PATCH \
        ${GROUPS_PATCH_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PATCH \\ \\n    \${GROUPS_PATCH_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

groups_update() {


    groupKey=( 
 'string'
 'Email or immutable ID of the group. If ID, it should match with id of group object'
 )

    if [[ -z "${GROUPS_UPDATE_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groupKey
            
        else
            getParams groupKey
        fi
        declare -g "GROUPS_UPDATE_groupKey=${PARAM_groupKey}"
        declare -g "groupKey=${PARAM_groupKey}"

    fi

    

    GROUPS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        GROUPS_UPDATE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        GROUPS_UPDATE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PUT \
        ${GROUPS_UPDATE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PUT \\ \\n    \${GROUPS_UPDATE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

members_delete() {


    groupKey=( 
 'string'
 'Email or immutable ID of the group'
 )

    if [[ -z "${MEMBERS_DELETE_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groupKey
            
        else
            getParams groupKey
        fi
        declare -g "MEMBERS_DELETE_groupKey=${PARAM_groupKey}"
        declare -g "groupKey=${PARAM_groupKey}"

    fi

    
    memberKey=( 
 'string'
 'Email or immutable ID of the member'
 )

    if [[ -z "${MEMBERS_DELETE_memberKey}" ]]
    then
        if ! [[ -z "${PARAM_memberKey}" ]]
        then 
            checkParams memberKey
            
        else
            getParams memberKey
        fi
        declare -g "MEMBERS_DELETE_memberKey=${PARAM_memberKey}"
        declare -g "memberKey=${PARAM_memberKey}"

    fi

    

    MEMBERS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members/${memberKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_DELETE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_DELETE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request DELETE \
        ${MEMBERS_DELETE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request DELETE \\ \\n    \${MEMBERS_DELETE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

members_get() {


    groupKey=( 
 'string'
 'Email or immutable ID of the group'
 )

    if [[ -z "${MEMBERS_GET_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groupKey
            
        else
            getParams groupKey
        fi
        declare -g "MEMBERS_GET_groupKey=${PARAM_groupKey}"
        declare -g "groupKey=${PARAM_groupKey}"

    fi

    
    memberKey=( 
 'string'
 'Email or immutable ID of the member'
 )

    if [[ -z "${MEMBERS_GET_memberKey}" ]]
    then
        if ! [[ -z "${PARAM_memberKey}" ]]
        then 
            checkParams memberKey
            
        else
            getParams memberKey
        fi
        declare -g "MEMBERS_GET_memberKey=${PARAM_memberKey}"
        declare -g "memberKey=${PARAM_memberKey}"

    fi

    

    MEMBERS_GET_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members/${memberKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_GET_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_GET_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${MEMBERS_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${MEMBERS_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

members_hasMember() {


    groupKey=( 
 'string'
 'Identifies the group in the API request. The value can be the group'\''s email address, group alias, or the unique group ID.'
 )

    if [[ -z "${MEMBERS_HASMEMBER_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groupKey
            
        else
            getParams groupKey
        fi
        declare -g "MEMBERS_HASMEMBER_groupKey=${PARAM_groupKey}"
        declare -g "groupKey=${PARAM_groupKey}"

    fi

    
    memberKey=( 
 'string'
 'Identifies the user member in the API request. The value can be the user'\''s primary email address, alias, or unique ID.'
 )

    if [[ -z "${MEMBERS_HASMEMBER_memberKey}" ]]
    then
        if ! [[ -z "${PARAM_memberKey}" ]]
        then 
            checkParams memberKey
            
        else
            getParams memberKey
        fi
        declare -g "MEMBERS_HASMEMBER_memberKey=${PARAM_memberKey}"
        declare -g "memberKey=${PARAM_memberKey}"

    fi

    

    MEMBERS_HASMEMBER_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/hasMember/${memberKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_HASMEMBER_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_HASMEMBER_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${MEMBERS_HASMEMBER_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${MEMBERS_HASMEMBER_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

members_insert() {


    groupKey=( 
 'string'
 'Email or immutable ID of the group'
 )

    if [[ -z "${MEMBERS_INSERT_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groupKey
            
        else
            getParams groupKey
        fi
        declare -g "MEMBERS_INSERT_groupKey=${PARAM_groupKey}"
        declare -g "groupKey=${PARAM_groupKey}"

    fi

    

    MEMBERS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_INSERT_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_INSERT_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${MEMBERS_INSERT_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${MEMBERS_INSERT_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

members_list() {


    groupKey=( 
 'string'
 'Email or immutable ID of the group'
 )

    if [[ -z "${MEMBERS_LIST_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groupKey
            
        else
            getParams groupKey
        fi
        declare -g "MEMBERS_LIST_groupKey=${PARAM_groupKey}"
        declare -g "groupKey=${PARAM_groupKey}"

    fi

    

    MEMBERS_LIST_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${MEMBERS_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${MEMBERS_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

members_patch() {


    groupKey=( 
 'string'
 'Email or immutable ID of the group. If ID, it should match with id of group object'
 )

    if [[ -z "${MEMBERS_PATCH_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groupKey
            
        else
            getParams groupKey
        fi
        declare -g "MEMBERS_PATCH_groupKey=${PARAM_groupKey}"
        declare -g "groupKey=${PARAM_groupKey}"

    fi

    
    memberKey=( 
 'string'
 'Email or immutable ID of the user. If ID, it should match with id of member object'
 )

    if [[ -z "${MEMBERS_PATCH_memberKey}" ]]
    then
        if ! [[ -z "${PARAM_memberKey}" ]]
        then 
            checkParams memberKey
            
        else
            getParams memberKey
        fi
        declare -g "MEMBERS_PATCH_memberKey=${PARAM_memberKey}"
        declare -g "memberKey=${PARAM_memberKey}"

    fi

    

    MEMBERS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members/${memberKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_PATCH_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_PATCH_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PATCH \
        ${MEMBERS_PATCH_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PATCH \\ \\n    \${MEMBERS_PATCH_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

members_update() {


    groupKey=( 
 'string'
 'Email or immutable ID of the group. If ID, it should match with id of group object'
 )

    if [[ -z "${MEMBERS_UPDATE_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groupKey
            
        else
            getParams groupKey
        fi
        declare -g "MEMBERS_UPDATE_groupKey=${PARAM_groupKey}"
        declare -g "groupKey=${PARAM_groupKey}"

    fi

    
    memberKey=( 
 'string'
 'Email or immutable ID of the user. If ID, it should match with id of member object'
 )

    if [[ -z "${MEMBERS_UPDATE_memberKey}" ]]
    then
        if ! [[ -z "${PARAM_memberKey}" ]]
        then 
            checkParams memberKey
            
        else
            getParams memberKey
        fi
        declare -g "MEMBERS_UPDATE_memberKey=${PARAM_memberKey}"
        declare -g "memberKey=${PARAM_memberKey}"

    fi

    

    MEMBERS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members/${memberKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_UPDATE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MEMBERS_UPDATE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PUT \
        ${MEMBERS_UPDATE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PUT \\ \\n    \${MEMBERS_UPDATE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

mobiledevices_action() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${MOBILEDEVICES_ACTION_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "MOBILEDEVICES_ACTION_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    resourceId=( 
 'string'
 'Immutable ID of Mobile Device'
 )

    if [[ -z "${MOBILEDEVICES_ACTION_resourceId}" ]]
    then
        if ! [[ -z "${PARAM_resourceId}" ]]
        then 
            checkParams resourceId
            
        else
            getParams resourceId
        fi
        declare -g "MOBILEDEVICES_ACTION_resourceId=${PARAM_resourceId}"
        declare -g "resourceId=${PARAM_resourceId}"

    fi

    

    MOBILEDEVICES_ACTION_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/mobile/${resourceId}/action?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MOBILEDEVICES_ACTION_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MOBILEDEVICES_ACTION_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${MOBILEDEVICES_ACTION_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${MOBILEDEVICES_ACTION_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

mobiledevices_delete() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${MOBILEDEVICES_DELETE_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "MOBILEDEVICES_DELETE_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    resourceId=( 
 'string'
 'Immutable ID of Mobile Device'
 )

    if [[ -z "${MOBILEDEVICES_DELETE_resourceId}" ]]
    then
        if ! [[ -z "${PARAM_resourceId}" ]]
        then 
            checkParams resourceId
            
        else
            getParams resourceId
        fi
        declare -g "MOBILEDEVICES_DELETE_resourceId=${PARAM_resourceId}"
        declare -g "resourceId=${PARAM_resourceId}"

    fi

    

    MOBILEDEVICES_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/mobile/${resourceId}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MOBILEDEVICES_DELETE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MOBILEDEVICES_DELETE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request DELETE \
        ${MOBILEDEVICES_DELETE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request DELETE \\ \\n    \${MOBILEDEVICES_DELETE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

mobiledevices_get() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${MOBILEDEVICES_GET_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "MOBILEDEVICES_GET_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    resourceId=( 
 'string'
 'Immutable ID of Mobile Device'
 )

    if [[ -z "${MOBILEDEVICES_GET_resourceId}" ]]
    then
        if ! [[ -z "${PARAM_resourceId}" ]]
        then 
            checkParams resourceId
            
        else
            getParams resourceId
        fi
        declare -g "MOBILEDEVICES_GET_resourceId=${PARAM_resourceId}"
        declare -g "resourceId=${PARAM_resourceId}"

    fi

    

    MOBILEDEVICES_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/mobile/${resourceId}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MOBILEDEVICES_GET_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 200.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MOBILEDEVICES_GET_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${MOBILEDEVICES_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${MOBILEDEVICES_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

mobiledevices_list() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${MOBILEDEVICES_LIST_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "MOBILEDEVICES_LIST_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    

    MOBILEDEVICES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/mobile?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MOBILEDEVICES_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    orgUnitPath=(
'string'
'Full path of the target organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        MOBILEDEVICES_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${MOBILEDEVICES_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${MOBILEDEVICES_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

orgunits_delete() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${ORGUNITS_DELETE_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "ORGUNITS_DELETE_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    orgUnitPath=( 
 'string'
 'Full path of the organizational unit or its ID'
 )

    if [[ -z "${ORGUNITS_DELETE_orgUnitPath}" ]]
    then
        if ! [[ -z "${PARAM_orgUnitPath}" ]]
        then 
            checkParams orgUnitPath
            
        else
            getParams orgUnitPath
        fi
        declare -g "ORGUNITS_DELETE_orgUnitPath=${PARAM_orgUnitPath}"
        declare -g "orgUnitPath=${PARAM_orgUnitPath}"

    fi

    

    ORGUNITS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits/${orgunitsId}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ORGUNITS_DELETE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ORGUNITS_DELETE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request DELETE \
        ${ORGUNITS_DELETE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request DELETE \\ \\n    \${ORGUNITS_DELETE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

orgunits_get() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${ORGUNITS_GET_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "ORGUNITS_GET_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    orgUnitPath=( 
 'string'
 'Full path of the organizational unit or its ID'
 )

    if [[ -z "${ORGUNITS_GET_orgUnitPath}" ]]
    then
        if ! [[ -z "${PARAM_orgUnitPath}" ]]
        then 
            checkParams orgUnitPath
            
        else
            getParams orgUnitPath
        fi
        declare -g "ORGUNITS_GET_orgUnitPath=${PARAM_orgUnitPath}"
        declare -g "orgUnitPath=${PARAM_orgUnitPath}"

    fi

    

    ORGUNITS_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits/${orgunitsId}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ORGUNITS_GET_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ORGUNITS_GET_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${ORGUNITS_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${ORGUNITS_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

orgunits_insert() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${ORGUNITS_INSERT_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "ORGUNITS_INSERT_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    

    ORGUNITS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ORGUNITS_INSERT_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ORGUNITS_INSERT_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${ORGUNITS_INSERT_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${ORGUNITS_INSERT_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

orgunits_list() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${ORGUNITS_LIST_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "ORGUNITS_LIST_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    

    ORGUNITS_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ORGUNITS_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    orgUnitPath=(
'string'
'the URL-encoded organizational unit'\''s path or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'the URL-encoded organizational unit'\''s path or its ID'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ORGUNITS_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${ORGUNITS_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${ORGUNITS_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

orgunits_patch() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${ORGUNITS_PATCH_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "ORGUNITS_PATCH_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    orgUnitPath=( 
 'string'
 'Full path of the organizational unit or its ID'
 )

    if [[ -z "${ORGUNITS_PATCH_orgUnitPath}" ]]
    then
        if ! [[ -z "${PARAM_orgUnitPath}" ]]
        then 
            checkParams orgUnitPath
            
        else
            getParams orgUnitPath
        fi
        declare -g "ORGUNITS_PATCH_orgUnitPath=${PARAM_orgUnitPath}"
        declare -g "orgUnitPath=${PARAM_orgUnitPath}"

    fi

    

    ORGUNITS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits/${orgunitsId}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ORGUNITS_PATCH_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ORGUNITS_PATCH_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PATCH \
        ${ORGUNITS_PATCH_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PATCH \\ \\n    \${ORGUNITS_PATCH_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

orgunits_update() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${ORGUNITS_UPDATE_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "ORGUNITS_UPDATE_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    orgUnitPath=( 
 'string'
 'Full path of the organizational unit or its ID'
 )

    if [[ -z "${ORGUNITS_UPDATE_orgUnitPath}" ]]
    then
        if ! [[ -z "${PARAM_orgUnitPath}" ]]
        then 
            checkParams orgUnitPath
            
        else
            getParams orgUnitPath
        fi
        declare -g "ORGUNITS_UPDATE_orgUnitPath=${PARAM_orgUnitPath}"
        declare -g "orgUnitPath=${PARAM_orgUnitPath}"

    fi

    

    ORGUNITS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits/${orgunitsId}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ORGUNITS_UPDATE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ORGUNITS_UPDATE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PUT \
        ${ORGUNITS_UPDATE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PUT \\ \\n    \${ORGUNITS_UPDATE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

privileges_list() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${PRIVILEGES_LIST_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "PRIVILEGES_LIST_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    

    PRIVILEGES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles/ALL/privileges?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        PRIVILEGES_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        PRIVILEGES_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${PRIVILEGES_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${PRIVILEGES_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

roleAssignments_delete() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${ROLEASSIGNMENTS_DELETE_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "ROLEASSIGNMENTS_DELETE_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    
    roleAssignmentId=( 
 'string'
 'Immutable ID of the role assignment.'
 )

    if [[ -z "${ROLEASSIGNMENTS_DELETE_roleAssignmentId}" ]]
    then
        if ! [[ -z "${PARAM_roleAssignmentId}" ]]
        then 
            checkParams roleAssignmentId
            
        else
            getParams roleAssignmentId
        fi
        declare -g "ROLEASSIGNMENTS_DELETE_roleAssignmentId=${PARAM_roleAssignmentId}"
        declare -g "roleAssignmentId=${PARAM_roleAssignmentId}"

    fi

    

    ROLEASSIGNMENTS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roleassignments/${roleAssignmentId}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ROLEASSIGNMENTS_DELETE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ROLEASSIGNMENTS_DELETE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request DELETE \
        ${ROLEASSIGNMENTS_DELETE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request DELETE \\ \\n    \${ROLEASSIGNMENTS_DELETE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

roleAssignments_get() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${ROLEASSIGNMENTS_GET_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "ROLEASSIGNMENTS_GET_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    
    roleAssignmentId=( 
 'string'
 'Immutable ID of the role assignment.'
 )

    if [[ -z "${ROLEASSIGNMENTS_GET_roleAssignmentId}" ]]
    then
        if ! [[ -z "${PARAM_roleAssignmentId}" ]]
        then 
            checkParams roleAssignmentId
            
        else
            getParams roleAssignmentId
        fi
        declare -g "ROLEASSIGNMENTS_GET_roleAssignmentId=${PARAM_roleAssignmentId}"
        declare -g "roleAssignmentId=${PARAM_roleAssignmentId}"

    fi

    

    ROLEASSIGNMENTS_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roleassignments/${roleAssignmentId}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ROLEASSIGNMENTS_GET_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ROLEASSIGNMENTS_GET_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${ROLEASSIGNMENTS_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${ROLEASSIGNMENTS_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

roleAssignments_insert() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${ROLEASSIGNMENTS_INSERT_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "ROLEASSIGNMENTS_INSERT_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    

    ROLEASSIGNMENTS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roleassignments?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ROLEASSIGNMENTS_INSERT_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath )

    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return. Max allowed value is 100.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ROLEASSIGNMENTS_INSERT_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${ROLEASSIGNMENTS_INSERT_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${ROLEASSIGNMENTS_INSERT_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

roleAssignments_list() {


    customer=( 
 'string'
 'Immutable ID of the G Suite account.'
 )

    if [[ -z "${ROLEASSIGNMENTS_LIST_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams customer
            
        else
            getParams customer
        fi
        declare -g "ROLEASSIGNMENTS_LIST_customer=${PARAM_customer}"
        declare -g "customer=${PARAM_customer}"

    fi

    

    ROLEASSIGNMENTS_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roleassignments?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ROLEASSIGNMENTS_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        ROLEASSIGNMENTS_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${ROLEASSIGNMENTS_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${ROLEASSIGNMENTS_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

string() {



    URL="https://www.googleapis.com/?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request  \
        ${URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request  \\ \\n    \${URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

Comma separated role values to filter list results on.() {



    URL="https://www.googleapis.com/?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request  \
        ${URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request  \\ \\n    \${URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

schemas_delete() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${SCHEMAS_DELETE_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "SCHEMAS_DELETE_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    schemaKey=( 
 'string'
 'Name or immutable ID of the schema'
 )

    if [[ -z "${SCHEMAS_DELETE_schemaKey}" ]]
    then
        if ! [[ -z "${PARAM_schemaKey}" ]]
        then 
            checkParams schemaKey
            
        else
            getParams schemaKey
        fi
        declare -g "SCHEMAS_DELETE_schemaKey=${PARAM_schemaKey}"
        declare -g "schemaKey=${PARAM_schemaKey}"

    fi

    

    SCHEMAS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/schemas/${schemaKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        SCHEMAS_DELETE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        SCHEMAS_DELETE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request DELETE \
        ${SCHEMAS_DELETE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request DELETE \\ \\n    \${SCHEMAS_DELETE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

schemas_get() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${SCHEMAS_GET_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "SCHEMAS_GET_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    schemaKey=( 
 'string'
 'Name or immutable ID of the schema'
 )

    if [[ -z "${SCHEMAS_GET_schemaKey}" ]]
    then
        if ! [[ -z "${PARAM_schemaKey}" ]]
        then 
            checkParams schemaKey
            
        else
            getParams schemaKey
        fi
        declare -g "SCHEMAS_GET_schemaKey=${PARAM_schemaKey}"
        declare -g "schemaKey=${PARAM_schemaKey}"

    fi

    

    SCHEMAS_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/schemas/${schemaKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        SCHEMAS_GET_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        SCHEMAS_GET_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${SCHEMAS_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${SCHEMAS_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

schemas_insert() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${SCHEMAS_INSERT_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "SCHEMAS_INSERT_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    

    SCHEMAS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/schemas?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        SCHEMAS_INSERT_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        SCHEMAS_INSERT_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${SCHEMAS_INSERT_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${SCHEMAS_INSERT_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

schemas_list() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${SCHEMAS_LIST_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "SCHEMAS_LIST_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    

    SCHEMAS_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/schemas?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        SCHEMAS_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        SCHEMAS_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${SCHEMAS_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${SCHEMAS_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

schemas_patch() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${SCHEMAS_PATCH_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "SCHEMAS_PATCH_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    schemaKey=( 
 'string'
 'Name or immutable ID of the schema.'
 )

    if [[ -z "${SCHEMAS_PATCH_schemaKey}" ]]
    then
        if ! [[ -z "${PARAM_schemaKey}" ]]
        then 
            checkParams schemaKey
            
        else
            getParams schemaKey
        fi
        declare -g "SCHEMAS_PATCH_schemaKey=${PARAM_schemaKey}"
        declare -g "schemaKey=${PARAM_schemaKey}"

    fi

    

    SCHEMAS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/schemas/${schemaKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        SCHEMAS_PATCH_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        SCHEMAS_PATCH_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PATCH \
        ${SCHEMAS_PATCH_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PATCH \\ \\n    \${SCHEMAS_PATCH_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

schemas_update() {


    customerId=( 
 'string'
 'Immutable ID of the G Suite account'
 )

    if [[ -z "${SCHEMAS_UPDATE_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams customerId
            
        else
            getParams customerId
        fi
        declare -g "SCHEMAS_UPDATE_customerId=${PARAM_customerId}"
        declare -g "customerId=${PARAM_customerId}"

    fi

    
    schemaKey=( 
 'string'
 'Name or immutable ID of the schema.'
 )

    if [[ -z "${SCHEMAS_UPDATE_schemaKey}" ]]
    then
        if ! [[ -z "${PARAM_schemaKey}" ]]
        then 
            checkParams schemaKey
            
        else
            getParams schemaKey
        fi
        declare -g "SCHEMAS_UPDATE_schemaKey=${PARAM_schemaKey}"
        declare -g "schemaKey=${PARAM_schemaKey}"

    fi

    

    SCHEMAS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/schemas/${schemaKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        SCHEMAS_UPDATE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        SCHEMAS_UPDATE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PUT \
        ${SCHEMAS_UPDATE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PUT \\ \\n    \${SCHEMAS_UPDATE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

tokens_delete() {


    clientId=( 
 'string'
 'The Client ID of the application the token is issued to.'
 )

    if [[ -z "${TOKENS_DELETE_clientId}" ]]
    then
        if ! [[ -z "${PARAM_clientId}" ]]
        then 
            checkParams clientId
            
        else
            getParams clientId
        fi
        declare -g "TOKENS_DELETE_clientId=${PARAM_clientId}"
        declare -g "clientId=${PARAM_clientId}"

    fi

    
    userKey=( 
 'string'
 'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
 )

    if [[ -z "${TOKENS_DELETE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "TOKENS_DELETE_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    TOKENS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/tokens/${clientId}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        TOKENS_DELETE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        TOKENS_DELETE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request DELETE \
        ${TOKENS_DELETE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request DELETE \\ \\n    \${TOKENS_DELETE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

tokens_get() {


    clientId=( 
 'string'
 'The Client ID of the application the token is issued to.'
 )

    if [[ -z "${TOKENS_GET_clientId}" ]]
    then
        if ! [[ -z "${PARAM_clientId}" ]]
        then 
            checkParams clientId
            
        else
            getParams clientId
        fi
        declare -g "TOKENS_GET_clientId=${PARAM_clientId}"
        declare -g "clientId=${PARAM_clientId}"

    fi

    
    userKey=( 
 'string'
 'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
 )

    if [[ -z "${TOKENS_GET_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "TOKENS_GET_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    TOKENS_GET_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/tokens/${clientId}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        TOKENS_GET_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        TOKENS_GET_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${TOKENS_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${TOKENS_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

tokens_list() {


    userKey=( 
 'string'
 'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
 )

    if [[ -z "${TOKENS_LIST_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "TOKENS_LIST_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    TOKENS_LIST_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/tokens?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        TOKENS_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        TOKENS_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${TOKENS_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${TOKENS_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

twoStepVerification_turnOff() {


    userKey=( 
 'string'
 'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
 )

    if [[ -z "${TWOSTEPVERIFICATION_TURNOFF_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "TWOSTEPVERIFICATION_TURNOFF_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    TWOSTEPVERIFICATION_TURNOFF_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/twoStepVerification/turnOff?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        TWOSTEPVERIFICATION_TURNOFF_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        TWOSTEPVERIFICATION_TURNOFF_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${TWOSTEPVERIFICATION_TURNOFF_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${TWOSTEPVERIFICATION_TURNOFF_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

users_delete() {


    userKey=( 
 'string'
 'Email or immutable ID of the user'
 )

    if [[ -z "${USERS_DELETE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "USERS_DELETE_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    USERS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type )

    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'Restrict information returned to a set of selected fields.'
'["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_DELETE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Email or immutable ID of the user'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_DELETE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request DELETE \
        ${USERS_DELETE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request DELETE \\ \\n    \${USERS_DELETE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

users_get() {


    userKey=( 
 'string'
 'Email or immutable ID of the user'
 )

    if [[ -z "${USERS_GET_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "USERS_GET_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    USERS_GET_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type projection viewType )

    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_GET_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey customFieldMask )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Email or immutable ID of the user'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_GET_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${USERS_GET_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${USERS_GET_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

users_insert() {



    USERS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/users?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type projection viewType )

    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_INSERT_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey customFieldMask )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    userKey=(
'string'
'Email or immutable ID of the user'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    query=(
'string'
'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify the next page in the list.'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Email or immutable ID of the user'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_INSERT_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${USERS_INSERT_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${USERS_INSERT_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

users_list() {



    USERS_LIST_URL="https://www.googleapis.com/admin/directory/v1/users?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type projection viewType orderBy projection sortOrder viewType )

    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey customFieldMask customFieldMask customer domain maxResults pageToken query showDeleted )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    userKey=(
'string'
'Email or immutable ID of the user'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Email or immutable ID of the user'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${USERS_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${USERS_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

users_makeAdmin() {


    userKey=( 
 'string'
 'Email or immutable ID of the user as admin'
 )

    if [[ -z "${USERS_MAKEADMIN_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "USERS_MAKEADMIN_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    USERS_MAKEADMIN_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/makeAdmin?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type projection viewType orderBy projection sortOrder viewType )

    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_MAKEADMIN_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey customFieldMask customFieldMask customer domain maxResults pageToken query showDeleted )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    userKey=(
'string'
'Email or immutable ID of the user as admin'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Email or immutable ID of the user as admin'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_MAKEADMIN_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${USERS_MAKEADMIN_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${USERS_MAKEADMIN_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

users_patch() {


    userKey=( 
 'string'
 'Email or immutable ID of the user. If ID, it should match with id of user object'
 )

    if [[ -z "${USERS_PATCH_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "USERS_PATCH_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    USERS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type projection viewType orderBy projection sortOrder viewType )

    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_PATCH_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey customFieldMask customFieldMask customer domain maxResults pageToken query showDeleted )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    userKey=(
'string'
'Email or immutable ID of the user. If ID, it should match with id of user object'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Email or immutable ID of the user. If ID, it should match with id of user object'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_PATCH_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PATCH \
        ${USERS_PATCH_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PATCH \\ \\n    \${USERS_PATCH_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

users_signOut() {


    userKey=( 
 'string'
 'Identifies the target user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
 )

    if [[ -z "${USERS_SIGNOUT_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "USERS_SIGNOUT_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    USERS_SIGNOUT_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/signOut?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type projection viewType orderBy projection sortOrder viewType )

    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_SIGNOUT_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey customFieldMask customFieldMask customer domain maxResults pageToken query showDeleted )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    userKey=(
'string'
'Identifies the target user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Identifies the target user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_SIGNOUT_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${USERS_SIGNOUT_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${USERS_SIGNOUT_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

users_undelete() {


    userKey=( 
 'string'
 'The immutable id of the user'
 )

    if [[ -z "${USERS_UNDELETE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "USERS_UNDELETE_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    USERS_UNDELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/undelete?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type projection viewType orderBy projection sortOrder viewType )

    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_UNDELETE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey customFieldMask customFieldMask customer domain maxResults pageToken query showDeleted )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    userKey=(
'string'
'The immutable id of the user'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'The immutable id of the user'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_UNDELETE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${USERS_UNDELETE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${USERS_UNDELETE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

users_update() {


    userKey=( 
 'string'
 'Email or immutable ID of the user. If ID, it should match with id of user object'
 )

    if [[ -z "${USERS_UPDATE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "USERS_UPDATE_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    USERS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type projection viewType orderBy projection sortOrder viewType )

    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUndefined","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUndefined","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["view_type_undefined","admin_view","domain_public"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_UPDATE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey customFieldMask customFieldMask customer domain maxResults pageToken query showDeleted )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    userKey=(
'string'
'Email or immutable ID of the user. If ID, it should match with id of user object'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Email or immutable ID of the user. If ID, it should match with id of user object'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_UPDATE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request PUT \
        ${USERS_UPDATE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request PUT \\ \\n    \${USERS_UPDATE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

users_watch() {



    USERS_WATCH_URL="https://www.googleapis.com/admin/directory/v1/users/watch?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type projection viewType orderBy projection sortOrder viewType event orderBy projection sortOrder viewType )

    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["admin_view","domain_public"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["admin_view","domain_public"]'
    )
    event=(
'string'
'Event on which subscription is intended'
'["eventTypeUnspecified","add","delete","makeAdmin","undelete","update"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["admin_view","domain_public"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_WATCH_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey customFieldMask customFieldMask customer domain maxResults pageToken query showDeleted customFieldMask customer domain maxResults pageToken query showDeleted )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    userKey=(
'string'
'Email or immutable ID of the user. If ID, it should match with id of user object'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Email or immutable ID of the user. If ID, it should match with id of user object'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        USERS_WATCH_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${USERS_WATCH_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${USERS_WATCH_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

verificationCodes_generate() {


    userKey=( 
 'string'
 'Email or immutable ID of the user'
 )

    if [[ -z "${VERIFICATIONCODES_GENERATE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "VERIFICATIONCODES_GENERATE_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    VERIFICATIONCODES_GENERATE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/verificationCodes/generate?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type projection viewType orderBy projection sortOrder viewType event orderBy projection sortOrder viewType )

    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["admin_view","domain_public"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["admin_view","domain_public"]'
    )
    event=(
'string'
'Event on which subscription is intended'
'["eventTypeUnspecified","add","delete","makeAdmin","undelete","update"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["admin_view","domain_public"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        VERIFICATIONCODES_GENERATE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey customFieldMask customFieldMask customer domain maxResults pageToken query showDeleted customFieldMask customer domain maxResults pageToken query showDeleted )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    userKey=(
'string'
'Email or immutable ID of the user'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Email or immutable ID of the user'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        VERIFICATIONCODES_GENERATE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${VERIFICATIONCODES_GENERATE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${VERIFICATIONCODES_GENERATE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

verificationCodes_invalidate() {


    userKey=( 
 'string'
 'Email or immutable ID of the user'
 )

    if [[ -z "${VERIFICATIONCODES_INVALIDATE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "VERIFICATIONCODES_INVALIDATE_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    VERIFICATIONCODES_INVALIDATE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/verificationCodes/invalidate?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type projection viewType orderBy projection sortOrder viewType event orderBy projection sortOrder viewType )

    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["admin_view","domain_public"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["admin_view","domain_public"]'
    )
    event=(
'string'
'Event on which subscription is intended'
'["eventTypeUnspecified","add","delete","makeAdmin","undelete","update"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["admin_view","domain_public"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        VERIFICATIONCODES_INVALIDATE_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey customFieldMask customFieldMask customer domain maxResults pageToken query showDeleted customFieldMask customer domain maxResults pageToken query showDeleted )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    userKey=(
'string'
'Email or immutable ID of the user'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Email or immutable ID of the user'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        VERIFICATIONCODES_INVALIDATE_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request POST \
        ${VERIFICATIONCODES_INVALIDATE_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --header "Content-Type: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request POST \\ \\n    \${VERIFICATIONCODES_INVALIDATE_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --header \"Content-Type: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

verificationCodes_list() {


    userKey=( 
 'string'
 'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
 )

    if [[ -z "${VERIFICATIONCODES_LIST_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams userKey
            
        else
            getParams userKey
        fi
        declare -g "VERIFICATIONCODES_LIST_userKey=${PARAM_userKey}"
        declare -g "userKey=${PARAM_userKey}"

    fi

    

    VERIFICATIONCODES_LIST_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/verificationCodes?key=${CLIENTID}"

    optParams=( projection orderBy projection sortOrder projection projection orderBy sortOrder projection orderBy projection sortOrder type projection viewType orderBy projection sortOrder viewType event orderBy projection sortOrder viewType )

    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    type=(
'string'
'Whether to return all sub-organizations or just immediate children'
'["typeUndefined","all","children"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["admin_view","domain_public"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["admin_view","domain_public"]'
    )
    event=(
'string'
'Event on which subscription is intended'
'["eventTypeUnspecified","add","delete","makeAdmin","undelete","update"]'
    )
    orderBy=(
'string'
'Column to use for sorting results'
'["orderByUnspecified","email","familyName","givenName"]'
    )
    projection=(
'string'
'What subset of fields to fetch for this user.'
'["projectionUnspecified","basic","custom","full"]'
    )
    sortOrder=(
'string'
'Whether to return results in ascending or descending order.'
'["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )
    viewType=(
'string'
'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
'["admin_view","domain_public"]'
    )

    echo -en "# Would you like to define extra parameters? [y/n] \n${optParams}\n\n~> "
    read -r optParChoice
    clear


    if [[ ${optParChoice} =~ "y" ]] || [[ ${optParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            select option in ${optParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        VERIFICATIONCODES_LIST_URL+="&${option}=${PARAM_${option}}"
                    fi
                fi
            done
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query parentDomainName customer domain maxResults pageToken query userKey includeDerivedMembership maxResults pageToken roles maxResults pageToken query orgUnitPath maxResults pageToken roleId userKey customFieldMask customFieldMask customer domain maxResults pageToken query showDeleted customFieldMask customer domain maxResults pageToken query showDeleted )

    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    parentDomainName=(
'string'
'Name of the parent domain for which domain aliases are to be fetched.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    userKey=(
'string'
'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )
    includeDerivedMembership=(
'boolean'
'Whether to list indirect memberships. Default: false.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roles=(
'string'
'Comma separated role values to filter list results on.'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    orgUnitPath=(
'string'
'Full path of the organizational unit or its ID'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    roleId=(
'string'
'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )
    userKey=(
'string'
'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )
    customFieldMask=(
'string'
'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )
    customer=(
'string'
'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )
    domain=(
'string'
'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )
    maxResults=(
'integer'
'Maximum number of results to return.'
    )
    pageToken=(
'string'
'Token to specify next page in the list'
    )
    query=(
'string'
'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )
    showDeleted=(
'string'
'If set to true, retrieves the list of deleted users. (Default: false)'
    )

    echo -en "# Would you like to define input parameters? [y/n] \n${inpParams}\n\n~> "
    read -r inpParChoice
    clear


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            select option in ${inpParams} none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        getParams ${option}
                        VERIFICATIONCODES_LIST_URL+="&${option}=${PARAM_${option}}"                        
                    fi
                fi
            done
        done
    fi

    curl -s \
        --request GET \
        ${VERIFICATIONCODES_LIST_URL} \
        --header "Authorization: Bearer \${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \\ \\n    --request GET \\ \\n    \${VERIFICATIONCODES_LIST_URL} \\ \\n    --header \"Authorization: Bearer \\\${ACCESSTOKEN}\" \\ \\n    --header \"Accept: application/json\" \\ \\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

