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


gapicSets=( asps channels chromeosdevices customer customers domainAliases domains groups members mobiledevices orgunits privileges roleAssignments roles schemas tokens twoStepVerification users verificationCodes )

asps=( asps_delete asps_get asps_list )
channels=( channels_stop )
chromeosdevices=( chromeosdevices_action chromeosdevices_get chromeosdevices_list chromeosdevices_moveDevicesToOu chromeosdevices_patch chromeosdevices_update )
customer=(  )
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

asps_delete() {

    apiQueryRef=( `echo asps delete`)


    codeIdMeta=( 
        'integer'
        'The unique ID of the ASP to be deleted.'
    )


    if [[ -z "${ASPS_DELETE_codeId}" ]]
    then
        if ! [[ -z "${PARAM_codeId}" ]]
        then 
            checkParams asps_delete codeId "false"
            
        else
            getParams "asps_delete" "codeId"
        fi
        declare -g "ASPS_DELETE_codeId=${codeId}"

    fi

    
    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if [[ -z "${ASPS_DELETE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams asps_delete userKey "false"
            
        else
            getParams "asps_delete" "userKey"
        fi
        declare -g "ASPS_DELETE_userKey=${userKey}"

    fi

    

    ASPS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/asps/${codeId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request DELETE \
            ${ASPS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${ASPS_DELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


asps_get() {

    apiQueryRef=( `echo asps get`)


    codeIdMeta=( 
        'integer'
        'The unique ID of the ASP.'
    )


    if [[ -z "${ASPS_GET_codeId}" ]]
    then
        if ! [[ -z "${PARAM_codeId}" ]]
        then 
            checkParams asps_get codeId "false"
            
        else
            getParams "asps_get" "codeId"
        fi
        declare -g "ASPS_GET_codeId=${codeId}"

    fi

    
    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if [[ -z "${ASPS_GET_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams asps_get userKey "false"
            
        else
            getParams "asps_get" "userKey"
        fi
        declare -g "ASPS_GET_userKey=${userKey}"

    fi

    

    ASPS_GET_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/asps/${codeId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${ASPS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ASPS_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


asps_list() {

    apiQueryRef=( `echo asps list`)


    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if [[ -z "${ASPS_LIST_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams asps_list userKey "false"
            
        else
            getParams "asps_list" "userKey"
        fi
        declare -g "ASPS_LIST_userKey=${userKey}"

    fi

    

    ASPS_LIST_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/asps?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${ASPS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ASPS_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


channels_stop() {

    apiQueryRef=( `echo channels stop`)



    CHANNELS_STOP_URL="https://www.googleapis.com/admin/directory_v1/channels/stop?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${CHANNELS_STOP_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${CHANNELS_STOP_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


chromeosdevices_action() {

    apiQueryRef=( `echo chromeosdevices action`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${CHROMEOSDEVICES_ACTION_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams chromeosdevices_action customerId "false"
            
        else
            getParams "chromeosdevices_action" "customerId"
        fi
        declare -g "CHROMEOSDEVICES_ACTION_customerId=${customerId}"

    fi

    
    resourceIdMeta=( 
        'string'
        'Immutable ID of Chrome OS Device'
    )


    if [[ -z "${CHROMEOSDEVICES_ACTION_resourceId}" ]]
    then
        if ! [[ -z "${PARAM_resourceId}" ]]
        then 
            checkParams chromeosdevices_action resourceId "false"
            
        else
            getParams "chromeosdevices_action" "resourceId"
        fi
        declare -g "CHROMEOSDEVICES_ACTION_resourceId=${resourceId}"

    fi

    

    CHROMEOSDEVICES_ACTION_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/${resourceId}/action?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${CHROMEOSDEVICES_ACTION_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${CHROMEOSDEVICES_ACTION_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


chromeosdevices_get() {

    apiQueryRef=( `echo chromeosdevices get`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${CHROMEOSDEVICES_GET_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams chromeosdevices_get customerId "false"
            
        else
            getParams "chromeosdevices_get" "customerId"
        fi
        declare -g "CHROMEOSDEVICES_GET_customerId=${customerId}"

    fi

    
    deviceIdMeta=( 
        'string'
        'Immutable ID of Chrome OS Device'
    )


    if [[ -z "${CHROMEOSDEVICES_GET_deviceId}" ]]
    then
        if ! [[ -z "${PARAM_deviceId}" ]]
        then 
            checkParams chromeosdevices_get deviceId "false"
            
        else
            getParams "chromeosdevices_get" "deviceId"
        fi
        declare -g "CHROMEOSDEVICES_GET_deviceId=${deviceId}"

    fi

    

    CHROMEOSDEVICES_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/${deviceId}?key=${CLIENTID}"

    optParams=( projection )

    projectionMeta=(
        'string'
        'Restrict information returned to a set of selected fields.'
        '["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams chromeosdevices_get ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            CHROMEOSDEVICES_GET_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "chromeosdevices_get" "${option}" "true"
                        CHROMEOSDEVICES_GET_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                        
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request GET \
            ${CHROMEOSDEVICES_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${CHROMEOSDEVICES_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


chromeosdevices_list() {

    apiQueryRef=( `echo chromeosdevices list`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${CHROMEOSDEVICES_LIST_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams chromeosdevices_list customerId "false"
            
        else
            getParams "chromeosdevices_list" "customerId"
        fi
        declare -g "CHROMEOSDEVICES_LIST_customerId=${customerId}"

    fi

    

    CHROMEOSDEVICES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos?key=${CLIENTID}"

    optParams=( orderBy projection sortOrder )

    orderByMeta=(
        'string'
        'Column to use for sorting results'
        '["orderByUndefined","annotatedLocation","annotatedUser","lastSync","notes","serialNumber","status","supportEndDate"]'
    )

    projectionMeta=(
        'string'
        'Restrict information returned to a set of selected fields.'
        '["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    sortOrderMeta=(
        'string'
        'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
        '["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams chromeosdevices_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            CHROMEOSDEVICES_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "chromeosdevices_list" "${option}" "true"
                        CHROMEOSDEVICES_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                        
                fi
            fi
        done
    fi
    inpParams=( maxResults orgUnitPath pageToken query )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return.'
    )

    orgUnitPathMeta=(
        'string'
        'Full path of the organizational unit or its ID'
    )

    pageTokenMeta=(
        'string'
        'Token to specify next page in the list'
    )

    queryMeta=(
        'string'
        'Search string in the format given at http://support.google.com/chromeos/a/bin/answer.py?answer=1698333'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear
                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams chromeosdevices_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            CHROMEOSDEVICES_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "chromeosdevices_list" "${option}" "true"
                        CHROMEOSDEVICES_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request GET \
            ${CHROMEOSDEVICES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${CHROMEOSDEVICES_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


chromeosdevices_moveDevicesToOu() {

    apiQueryRef=( `echo chromeosdevices moveDevicesToOu`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${CHROMEOSDEVICES_MOVEDEVICESTOOU_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams chromeosdevices_moveDevicesToOu customerId "false"
            
        else
            getParams "chromeosdevices_moveDevicesToOu" "customerId"
        fi
        declare -g "CHROMEOSDEVICES_MOVEDEVICESTOOU_customerId=${customerId}"

    fi

    
    orgUnitPathMeta=( 
        'string'
        'Full path of the target organizational unit or its ID'
    )


    if [[ -z "${CHROMEOSDEVICES_MOVEDEVICESTOOU_orgUnitPath}" ]]
    then
        if ! [[ -z "${PARAM_orgUnitPath}" ]]
        then 
            checkParams chromeosdevices_moveDevicesToOu orgUnitPath "false"
            
        else
            getParams "chromeosdevices_moveDevicesToOu" "orgUnitPath"
        fi
        declare -g "CHROMEOSDEVICES_MOVEDEVICESTOOU_orgUnitPath=${orgUnitPath}"

    fi

    

    CHROMEOSDEVICES_MOVEDEVICESTOOU_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/moveDevicesToOu?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${CHROMEOSDEVICES_MOVEDEVICESTOOU_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${CHROMEOSDEVICES_MOVEDEVICESTOOU_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


chromeosdevices_patch() {

    apiQueryRef=( `echo chromeosdevices patch`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${CHROMEOSDEVICES_PATCH_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams chromeosdevices_patch customerId "false"
            
        else
            getParams "chromeosdevices_patch" "customerId"
        fi
        declare -g "CHROMEOSDEVICES_PATCH_customerId=${customerId}"

    fi

    
    deviceIdMeta=( 
        'string'
        'Immutable ID of Chrome OS Device'
    )


    if [[ -z "${CHROMEOSDEVICES_PATCH_deviceId}" ]]
    then
        if ! [[ -z "${PARAM_deviceId}" ]]
        then 
            checkParams chromeosdevices_patch deviceId "false"
            
        else
            getParams "chromeosdevices_patch" "deviceId"
        fi
        declare -g "CHROMEOSDEVICES_PATCH_deviceId=${deviceId}"

    fi

    

    CHROMEOSDEVICES_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/${deviceId}?key=${CLIENTID}"

    optParams=( projection )

    projectionMeta=(
        'string'
        'Restrict information returned to a set of selected fields.'
        '["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams chromeosdevices_patch ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            CHROMEOSDEVICES_PATCH_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "chromeosdevices_patch" "${option}" "true"
                        CHROMEOSDEVICES_PATCH_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                        
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request PATCH \
            ${CHROMEOSDEVICES_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${CHROMEOSDEVICES_PATCH_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


chromeosdevices_update() {

    apiQueryRef=( `echo chromeosdevices update`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${CHROMEOSDEVICES_UPDATE_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams chromeosdevices_update customerId "false"
            
        else
            getParams "chromeosdevices_update" "customerId"
        fi
        declare -g "CHROMEOSDEVICES_UPDATE_customerId=${customerId}"

    fi

    
    deviceIdMeta=( 
        'string'
        'Immutable ID of Chrome OS Device'
    )


    if [[ -z "${CHROMEOSDEVICES_UPDATE_deviceId}" ]]
    then
        if ! [[ -z "${PARAM_deviceId}" ]]
        then 
            checkParams chromeosdevices_update deviceId "false"
            
        else
            getParams "chromeosdevices_update" "deviceId"
        fi
        declare -g "CHROMEOSDEVICES_UPDATE_deviceId=${deviceId}"

    fi

    

    CHROMEOSDEVICES_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/chromeos/${deviceId}?key=${CLIENTID}"

    optParams=( projection )

    projectionMeta=(
        'string'
        'Restrict information returned to a set of selected fields.'
        '["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams chromeosdevices_update ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            CHROMEOSDEVICES_UPDATE_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "chromeosdevices_update" "${option}" "true"
                        CHROMEOSDEVICES_UPDATE_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                        
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request PUT \
            ${CHROMEOSDEVICES_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${CHROMEOSDEVICES_UPDATE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


customers_get() {

    apiQueryRef=( `echo customers get`)


    customerKeyMeta=( 
        'string'
        'Id of the customer to be retrieved'
    )


    if [[ -z "${CUSTOMERS_GET_customerKey}" ]]
    then
        if ! [[ -z "${PARAM_customerKey}" ]]
        then 
            checkParams customers_get customerKey "false"
            
        else
            getParams "customers_get" "customerKey"
        fi
        declare -g "CUSTOMERS_GET_customerKey=${customerKey}"

    fi

    

    CUSTOMERS_GET_URL="https://www.googleapis.com/admin/directory/v1/customers/${customerKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${CUSTOMERS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${CUSTOMERS_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


customers_patch() {

    apiQueryRef=( `echo customers patch`)


    customerKeyMeta=( 
        'string'
        'Id of the customer to be updated'
    )


    if [[ -z "${CUSTOMERS_PATCH_customerKey}" ]]
    then
        if ! [[ -z "${PARAM_customerKey}" ]]
        then 
            checkParams customers_patch customerKey "false"
            
        else
            getParams "customers_patch" "customerKey"
        fi
        declare -g "CUSTOMERS_PATCH_customerKey=${customerKey}"

    fi

    

    CUSTOMERS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customers/${customerKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PATCH \
            ${CUSTOMERS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${CUSTOMERS_PATCH_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


customers_update() {

    apiQueryRef=( `echo customers update`)


    customerKeyMeta=( 
        'string'
        'Id of the customer to be updated'
    )


    if [[ -z "${CUSTOMERS_UPDATE_customerKey}" ]]
    then
        if ! [[ -z "${PARAM_customerKey}" ]]
        then 
            checkParams customers_update customerKey "false"
            
        else
            getParams "customers_update" "customerKey"
        fi
        declare -g "CUSTOMERS_UPDATE_customerKey=${customerKey}"

    fi

    

    CUSTOMERS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customers/${customerKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PUT \
            ${CUSTOMERS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${CUSTOMERS_UPDATE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


domainAliases_delete() {

    apiQueryRef=( `echo domainAliases delete`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${DOMAINALIASES_DELETE_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams domainAliases_delete customer "false"
            
        else
            getParams "domainAliases_delete" "customer"
        fi
        declare -g "DOMAINALIASES_DELETE_customer=${customer}"

    fi

    
    domainAliasNameMeta=( 
        'string'
        'Name of domain alias to be retrieved.'
    )


    if [[ -z "${DOMAINALIASES_DELETE_domainAliasName}" ]]
    then
        if ! [[ -z "${PARAM_domainAliasName}" ]]
        then 
            checkParams domainAliases_delete domainAliasName "false"
            
        else
            getParams "domainAliases_delete" "domainAliasName"
        fi
        declare -g "DOMAINALIASES_DELETE_domainAliasName=${domainAliasName}"

    fi

    

    DOMAINALIASES_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domainaliases/${domainAliasName}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request DELETE \
            ${DOMAINALIASES_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${DOMAINALIASES_DELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


domainAliases_get() {

    apiQueryRef=( `echo domainAliases get`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${DOMAINALIASES_GET_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams domainAliases_get customer "false"
            
        else
            getParams "domainAliases_get" "customer"
        fi
        declare -g "DOMAINALIASES_GET_customer=${customer}"

    fi

    
    domainAliasNameMeta=( 
        'string'
        'Name of domain alias to be retrieved.'
    )


    if [[ -z "${DOMAINALIASES_GET_domainAliasName}" ]]
    then
        if ! [[ -z "${PARAM_domainAliasName}" ]]
        then 
            checkParams domainAliases_get domainAliasName "false"
            
        else
            getParams "domainAliases_get" "domainAliasName"
        fi
        declare -g "DOMAINALIASES_GET_domainAliasName=${domainAliasName}"

    fi

    

    DOMAINALIASES_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domainaliases/${domainAliasName}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${DOMAINALIASES_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${DOMAINALIASES_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


domainAliases_insert() {

    apiQueryRef=( `echo domainAliases insert`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${DOMAINALIASES_INSERT_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams domainAliases_insert customer "false"
            
        else
            getParams "domainAliases_insert" "customer"
        fi
        declare -g "DOMAINALIASES_INSERT_customer=${customer}"

    fi

    

    DOMAINALIASES_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domainaliases?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${DOMAINALIASES_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${DOMAINALIASES_INSERT_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


domainAliases_list() {

    apiQueryRef=( `echo domainAliases list`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${DOMAINALIASES_LIST_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams domainAliases_list customer "false"
            
        else
            getParams "domainAliases_list" "customer"
        fi
        declare -g "DOMAINALIASES_LIST_customer=${customer}"

    fi

    

    DOMAINALIASES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domainaliases?key=${CLIENTID}"

    inpParams=( parentDomainName )

    parentDomainNameMeta=(
        'string'
        'Name of the parent domain for which domain aliases are to be fetched.'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear
                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams domainAliases_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            DOMAINALIASES_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "domainAliases_list" "${option}" "true"
                        DOMAINALIASES_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request GET \
            ${DOMAINALIASES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${DOMAINALIASES_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


domains_delete() {

    apiQueryRef=( `echo domains delete`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${DOMAINS_DELETE_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams domains_delete customer "false"
            
        else
            getParams "domains_delete" "customer"
        fi
        declare -g "DOMAINS_DELETE_customer=${customer}"

    fi

    
    domainNameMeta=( 
        'string'
        'Name of domain to be deleted'
    )


    if [[ -z "${DOMAINS_DELETE_domainName}" ]]
    then
        if ! [[ -z "${PARAM_domainName}" ]]
        then 
            checkParams domains_delete domainName "false"
            
        else
            getParams "domains_delete" "domainName"
        fi
        declare -g "DOMAINS_DELETE_domainName=${domainName}"

    fi

    

    DOMAINS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domains/${domainName}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request DELETE \
            ${DOMAINS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${DOMAINS_DELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


domains_get() {

    apiQueryRef=( `echo domains get`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${DOMAINS_GET_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams domains_get customer "false"
            
        else
            getParams "domains_get" "customer"
        fi
        declare -g "DOMAINS_GET_customer=${customer}"

    fi

    
    domainNameMeta=( 
        'string'
        'Name of domain to be retrieved'
    )


    if [[ -z "${DOMAINS_GET_domainName}" ]]
    then
        if ! [[ -z "${PARAM_domainName}" ]]
        then 
            checkParams domains_get domainName "false"
            
        else
            getParams "domains_get" "domainName"
        fi
        declare -g "DOMAINS_GET_domainName=${domainName}"

    fi

    

    DOMAINS_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domains/${domainName}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${DOMAINS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${DOMAINS_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


domains_insert() {

    apiQueryRef=( `echo domains insert`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${DOMAINS_INSERT_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams domains_insert customer "false"
            
        else
            getParams "domains_insert" "customer"
        fi
        declare -g "DOMAINS_INSERT_customer=${customer}"

    fi

    

    DOMAINS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domains?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${DOMAINS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${DOMAINS_INSERT_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


domains_list() {

    apiQueryRef=( `echo domains list`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${DOMAINS_LIST_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams domains_list customer "false"
            
        else
            getParams "domains_list" "customer"
        fi
        declare -g "DOMAINS_LIST_customer=${customer}"

    fi

    

    DOMAINS_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/domains?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${DOMAINS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${DOMAINS_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


groups_delete() {

    apiQueryRef=( `echo groups delete`)


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group'
    )


    if [[ -z "${GROUPS_DELETE_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groups_delete groupKey "false"
            
        else
            getParams "groups_delete" "groupKey"
        fi
        declare -g "GROUPS_DELETE_groupKey=${groupKey}"

    fi

    

    GROUPS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request DELETE \
            ${GROUPS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${GROUPS_DELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


groups_get() {

    apiQueryRef=( `echo groups get`)


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group'
    )


    if [[ -z "${GROUPS_GET_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groups_get groupKey "false"
            
        else
            getParams "groups_get" "groupKey"
        fi
        declare -g "GROUPS_GET_groupKey=${groupKey}"

    fi

    

    GROUPS_GET_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${GROUPS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${GROUPS_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


groups_insert() {

    apiQueryRef=( `echo groups insert`)



    GROUPS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/groups?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${GROUPS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${GROUPS_INSERT_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


groups_list() {

    apiQueryRef=( `echo groups list`)



    GROUPS_LIST_URL="https://www.googleapis.com/admin/directory/v1/groups?key=${CLIENTID}"

    optParams=( orderBy sortOrder )

    orderByMeta=(
        'string'
        'Column to use for sorting results'
        '["orderByUndefined","email"]'
    )

    sortOrderMeta=(
        'string'
        'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
        '["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams groups_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            GROUPS_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "groups_list" "${option}" "true"
                        GROUPS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                        
                fi
            fi
        done
    fi
    inpParams=( customer domain maxResults pageToken query userKey )

    customerMeta=(
        'string'
        'Immutable ID of the G Suite account. In case of multi-domain, to fetch all groups for a customer, fill this field instead of domain.'
    )

    domainMeta=(
        'string'
        'Name of the domain. Fill this field to get groups from only this domain. To return all groups in a multi-domain fill customer field instead.'
    )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return. Max allowed value is 200.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify next page in the list'
    )

    queryMeta=(
        'string'
        'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-groups'
    )

    userKeyMeta=(
        'string'
        'Email or immutable ID of the user if only those groups are to be listed, the given user is a member of. If it'\''s an ID, it should match with the ID of the user object.'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear
                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams groups_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            GROUPS_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "groups_list" "${option}" "true"
                        GROUPS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request GET \
            ${GROUPS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${GROUPS_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


groups_patch() {

    apiQueryRef=( `echo groups patch`)


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group. If ID, it should match with id of group object'
    )


    if [[ -z "${GROUPS_PATCH_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groups_patch groupKey "false"
            
        else
            getParams "groups_patch" "groupKey"
        fi
        declare -g "GROUPS_PATCH_groupKey=${groupKey}"

    fi

    

    GROUPS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PATCH \
            ${GROUPS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${GROUPS_PATCH_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


groups_update() {

    apiQueryRef=( `echo groups update`)


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group. If ID, it should match with id of group object'
    )


    if [[ -z "${GROUPS_UPDATE_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams groups_update groupKey "false"
            
        else
            getParams "groups_update" "groupKey"
        fi
        declare -g "GROUPS_UPDATE_groupKey=${groupKey}"

    fi

    

    GROUPS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PUT \
            ${GROUPS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${GROUPS_UPDATE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


members_delete() {

    apiQueryRef=( `echo members delete`)


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group'
    )


    if [[ -z "${MEMBERS_DELETE_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams members_delete groupKey "false"
            
        else
            getParams "members_delete" "groupKey"
        fi
        declare -g "MEMBERS_DELETE_groupKey=${groupKey}"

    fi

    
    memberKeyMeta=( 
        'string'
        'Email or immutable ID of the member'
    )


    if [[ -z "${MEMBERS_DELETE_memberKey}" ]]
    then
        if ! [[ -z "${PARAM_memberKey}" ]]
        then 
            checkParams members_delete memberKey "false"
            
        else
            getParams "members_delete" "memberKey"
        fi
        declare -g "MEMBERS_DELETE_memberKey=${memberKey}"

    fi

    

    MEMBERS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members/${memberKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request DELETE \
            ${MEMBERS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${MEMBERS_DELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


members_get() {

    apiQueryRef=( `echo members get`)


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group'
    )


    if [[ -z "${MEMBERS_GET_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams members_get groupKey "false"
            
        else
            getParams "members_get" "groupKey"
        fi
        declare -g "MEMBERS_GET_groupKey=${groupKey}"

    fi

    
    memberKeyMeta=( 
        'string'
        'Email or immutable ID of the member'
    )


    if [[ -z "${MEMBERS_GET_memberKey}" ]]
    then
        if ! [[ -z "${PARAM_memberKey}" ]]
        then 
            checkParams members_get memberKey "false"
            
        else
            getParams "members_get" "memberKey"
        fi
        declare -g "MEMBERS_GET_memberKey=${memberKey}"

    fi

    

    MEMBERS_GET_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members/${memberKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${MEMBERS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${MEMBERS_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


members_hasMember() {

    apiQueryRef=( `echo members hasMember`)


    groupKeyMeta=( 
        'string'
        'Identifies the group in the API request. The value can be the group'\''s email address, group alias, or the unique group ID.'
    )


    if [[ -z "${MEMBERS_HASMEMBER_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams members_hasMember groupKey "false"
            
        else
            getParams "members_hasMember" "groupKey"
        fi
        declare -g "MEMBERS_HASMEMBER_groupKey=${groupKey}"

    fi

    
    memberKeyMeta=( 
        'string'
        'Identifies the user member in the API request. The value can be the user'\''s primary email address, alias, or unique ID.'
    )


    if [[ -z "${MEMBERS_HASMEMBER_memberKey}" ]]
    then
        if ! [[ -z "${PARAM_memberKey}" ]]
        then 
            checkParams members_hasMember memberKey "false"
            
        else
            getParams "members_hasMember" "memberKey"
        fi
        declare -g "MEMBERS_HASMEMBER_memberKey=${memberKey}"

    fi

    

    MEMBERS_HASMEMBER_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/hasMember/${memberKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${MEMBERS_HASMEMBER_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${MEMBERS_HASMEMBER_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


members_insert() {

    apiQueryRef=( `echo members insert`)


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group'
    )


    if [[ -z "${MEMBERS_INSERT_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams members_insert groupKey "false"
            
        else
            getParams "members_insert" "groupKey"
        fi
        declare -g "MEMBERS_INSERT_groupKey=${groupKey}"

    fi

    

    MEMBERS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${MEMBERS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${MEMBERS_INSERT_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


members_list() {

    apiQueryRef=( `echo members list`)


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group'
    )


    if [[ -z "${MEMBERS_LIST_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams members_list groupKey "false"
            
        else
            getParams "members_list" "groupKey"
        fi
        declare -g "MEMBERS_LIST_groupKey=${groupKey}"

    fi

    

    MEMBERS_LIST_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members?key=${CLIENTID}"

    inpParams=( includeDerivedMembership maxResults pageToken roles )

    includeDerivedMembershipMeta=(
        'boolean'
        'Whether to list indirect memberships. Default: false.'
    )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return. Max allowed value is 200.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify next page in the list'
    )

    rolesMeta=(
        'string'
        'Comma separated role values to filter list results on.'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear
                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams members_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            MEMBERS_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "members_list" "${option}" "true"
                        MEMBERS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request GET \
            ${MEMBERS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${MEMBERS_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


members_patch() {

    apiQueryRef=( `echo members patch`)


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group. If ID, it should match with id of group object'
    )


    if [[ -z "${MEMBERS_PATCH_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams members_patch groupKey "false"
            
        else
            getParams "members_patch" "groupKey"
        fi
        declare -g "MEMBERS_PATCH_groupKey=${groupKey}"

    fi

    
    memberKeyMeta=( 
        'string'
        'Email or immutable ID of the user. If ID, it should match with id of member object'
    )


    if [[ -z "${MEMBERS_PATCH_memberKey}" ]]
    then
        if ! [[ -z "${PARAM_memberKey}" ]]
        then 
            checkParams members_patch memberKey "false"
            
        else
            getParams "members_patch" "memberKey"
        fi
        declare -g "MEMBERS_PATCH_memberKey=${memberKey}"

    fi

    

    MEMBERS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members/${memberKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PATCH \
            ${MEMBERS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${MEMBERS_PATCH_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


members_update() {

    apiQueryRef=( `echo members update`)


    groupKeyMeta=( 
        'string'
        'Email or immutable ID of the group. If ID, it should match with id of group object'
    )


    if [[ -z "${MEMBERS_UPDATE_groupKey}" ]]
    then
        if ! [[ -z "${PARAM_groupKey}" ]]
        then 
            checkParams members_update groupKey "false"
            
        else
            getParams "members_update" "groupKey"
        fi
        declare -g "MEMBERS_UPDATE_groupKey=${groupKey}"

    fi

    
    memberKeyMeta=( 
        'string'
        'Email or immutable ID of the user. If ID, it should match with id of member object'
    )


    if [[ -z "${MEMBERS_UPDATE_memberKey}" ]]
    then
        if ! [[ -z "${PARAM_memberKey}" ]]
        then 
            checkParams members_update memberKey "false"
            
        else
            getParams "members_update" "memberKey"
        fi
        declare -g "MEMBERS_UPDATE_memberKey=${memberKey}"

    fi

    

    MEMBERS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/groups/${groupKey}/members/${memberKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PUT \
            ${MEMBERS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${MEMBERS_UPDATE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


mobiledevices_action() {

    apiQueryRef=( `echo mobiledevices action`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${MOBILEDEVICES_ACTION_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams mobiledevices_action customerId "false"
            
        else
            getParams "mobiledevices_action" "customerId"
        fi
        declare -g "MOBILEDEVICES_ACTION_customerId=${customerId}"

    fi

    
    resourceIdMeta=( 
        'string'
        'Immutable ID of Mobile Device'
    )


    if [[ -z "${MOBILEDEVICES_ACTION_resourceId}" ]]
    then
        if ! [[ -z "${PARAM_resourceId}" ]]
        then 
            checkParams mobiledevices_action resourceId "false"
            
        else
            getParams "mobiledevices_action" "resourceId"
        fi
        declare -g "MOBILEDEVICES_ACTION_resourceId=${resourceId}"

    fi

    

    MOBILEDEVICES_ACTION_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/mobile/${resourceId}/action?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${MOBILEDEVICES_ACTION_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${MOBILEDEVICES_ACTION_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


mobiledevices_delete() {

    apiQueryRef=( `echo mobiledevices delete`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${MOBILEDEVICES_DELETE_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams mobiledevices_delete customerId "false"
            
        else
            getParams "mobiledevices_delete" "customerId"
        fi
        declare -g "MOBILEDEVICES_DELETE_customerId=${customerId}"

    fi

    
    resourceIdMeta=( 
        'string'
        'Immutable ID of Mobile Device'
    )


    if [[ -z "${MOBILEDEVICES_DELETE_resourceId}" ]]
    then
        if ! [[ -z "${PARAM_resourceId}" ]]
        then 
            checkParams mobiledevices_delete resourceId "false"
            
        else
            getParams "mobiledevices_delete" "resourceId"
        fi
        declare -g "MOBILEDEVICES_DELETE_resourceId=${resourceId}"

    fi

    

    MOBILEDEVICES_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/mobile/${resourceId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request DELETE \
            ${MOBILEDEVICES_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${MOBILEDEVICES_DELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


mobiledevices_get() {

    apiQueryRef=( `echo mobiledevices get`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${MOBILEDEVICES_GET_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams mobiledevices_get customerId "false"
            
        else
            getParams "mobiledevices_get" "customerId"
        fi
        declare -g "MOBILEDEVICES_GET_customerId=${customerId}"

    fi

    
    resourceIdMeta=( 
        'string'
        'Immutable ID of Mobile Device'
    )


    if [[ -z "${MOBILEDEVICES_GET_resourceId}" ]]
    then
        if ! [[ -z "${PARAM_resourceId}" ]]
        then 
            checkParams mobiledevices_get resourceId "false"
            
        else
            getParams "mobiledevices_get" "resourceId"
        fi
        declare -g "MOBILEDEVICES_GET_resourceId=${resourceId}"

    fi

    

    MOBILEDEVICES_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/mobile/${resourceId}?key=${CLIENTID}"

    optParams=( projection )

    projectionMeta=(
        'string'
        'Restrict information returned to a set of selected fields.'
        '["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams mobiledevices_get ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            MOBILEDEVICES_GET_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "mobiledevices_get" "${option}" "true"
                        MOBILEDEVICES_GET_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                        
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request GET \
            ${MOBILEDEVICES_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${MOBILEDEVICES_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


mobiledevices_list() {

    apiQueryRef=( `echo mobiledevices list`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${MOBILEDEVICES_LIST_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams mobiledevices_list customerId "false"
            
        else
            getParams "mobiledevices_list" "customerId"
        fi
        declare -g "MOBILEDEVICES_LIST_customerId=${customerId}"

    fi

    

    MOBILEDEVICES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/devices/mobile?key=${CLIENTID}"

    optParams=( orderBy projection sortOrder )

    orderByMeta=(
        'string'
        'Column to use for sorting results'
        '["orderByUndefined","deviceId","email","lastSync","model","name","os","status","type"]'
    )

    projectionMeta=(
        'string'
        'Restrict information returned to a set of selected fields.'
        '["PROJECTION_UNDEFINED","BASIC","FULL"]'
    )

    sortOrderMeta=(
        'string'
        'Whether to return results in ascending or descending order. Only of use when orderBy is also used'
        '["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams mobiledevices_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            MOBILEDEVICES_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "mobiledevices_list" "${option}" "true"
                        MOBILEDEVICES_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                        
                fi
            fi
        done
    fi
    inpParams=( maxResults pageToken query )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return. Max allowed value is 100.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify next page in the list'
    )

    queryMeta=(
        'string'
        'Search string in the format given at http://support.google.com/a/bin/answer.py?answer=1408863#search'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear
                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams mobiledevices_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            MOBILEDEVICES_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "mobiledevices_list" "${option}" "true"
                        MOBILEDEVICES_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request GET \
            ${MOBILEDEVICES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${MOBILEDEVICES_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


orgunits_delete() {

    apiQueryRef=( `echo orgunits delete`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${ORGUNITS_DELETE_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams orgunits_delete customerId "false"
            
        else
            getParams "orgunits_delete" "customerId"
        fi
        declare -g "ORGUNITS_DELETE_customerId=${customerId}"

    fi

    
    orgUnitPathMeta=( 
        'string'
        'Full path of the organizational unit or its ID'
    )


    if [[ -z "${ORGUNITS_DELETE_orgUnitPath}" ]]
    then
        if ! [[ -z "${PARAM_orgUnitPath}" ]]
        then 
            checkParams orgunits_delete orgUnitPath "false"
            
        else
            getParams "orgunits_delete" "orgUnitPath"
        fi
        declare -g "ORGUNITS_DELETE_orgUnitPath=${orgUnitPath}"

    fi

    

    ORGUNITS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits/${orgunitsId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request DELETE \
            ${ORGUNITS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${ORGUNITS_DELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


orgunits_get() {

    apiQueryRef=( `echo orgunits get`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${ORGUNITS_GET_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams orgunits_get customerId "false"
            
        else
            getParams "orgunits_get" "customerId"
        fi
        declare -g "ORGUNITS_GET_customerId=${customerId}"

    fi

    
    orgUnitPathMeta=( 
        'string'
        'Full path of the organizational unit or its ID'
    )


    if [[ -z "${ORGUNITS_GET_orgUnitPath}" ]]
    then
        if ! [[ -z "${PARAM_orgUnitPath}" ]]
        then 
            checkParams orgunits_get orgUnitPath "false"
            
        else
            getParams "orgunits_get" "orgUnitPath"
        fi
        declare -g "ORGUNITS_GET_orgUnitPath=${orgUnitPath}"

    fi

    

    ORGUNITS_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits/${orgunitsId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${ORGUNITS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ORGUNITS_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


orgunits_insert() {

    apiQueryRef=( `echo orgunits insert`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${ORGUNITS_INSERT_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams orgunits_insert customerId "false"
            
        else
            getParams "orgunits_insert" "customerId"
        fi
        declare -g "ORGUNITS_INSERT_customerId=${customerId}"

    fi

    

    ORGUNITS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${ORGUNITS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${ORGUNITS_INSERT_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


orgunits_list() {

    apiQueryRef=( `echo orgunits list`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${ORGUNITS_LIST_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams orgunits_list customerId "false"
            
        else
            getParams "orgunits_list" "customerId"
        fi
        declare -g "ORGUNITS_LIST_customerId=${customerId}"

    fi

    

    ORGUNITS_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits?key=${CLIENTID}"

    optParams=( type )

    typeMeta=(
        'string'
        'Whether to return all sub-organizations or just immediate children'
        '["typeUndefined","all","children"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams orgunits_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            ORGUNITS_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "orgunits_list" "${option}" "true"
                        ORGUNITS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                        
                fi
            fi
        done
    fi
    inpParams=( orgUnitPath )

    orgUnitPathMeta=(
        'string'
        'the URL-encoded organizational unit'\''s path or its ID'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear
                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams orgunits_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            ORGUNITS_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "orgunits_list" "${option}" "true"
                        ORGUNITS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request GET \
            ${ORGUNITS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ORGUNITS_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


orgunits_patch() {

    apiQueryRef=( `echo orgunits patch`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${ORGUNITS_PATCH_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams orgunits_patch customerId "false"
            
        else
            getParams "orgunits_patch" "customerId"
        fi
        declare -g "ORGUNITS_PATCH_customerId=${customerId}"

    fi

    
    orgUnitPathMeta=( 
        'string'
        'Full path of the organizational unit or its ID'
    )


    if [[ -z "${ORGUNITS_PATCH_orgUnitPath}" ]]
    then
        if ! [[ -z "${PARAM_orgUnitPath}" ]]
        then 
            checkParams orgunits_patch orgUnitPath "false"
            
        else
            getParams "orgunits_patch" "orgUnitPath"
        fi
        declare -g "ORGUNITS_PATCH_orgUnitPath=${orgUnitPath}"

    fi

    

    ORGUNITS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits/${orgunitsId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PATCH \
            ${ORGUNITS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${ORGUNITS_PATCH_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


orgunits_update() {

    apiQueryRef=( `echo orgunits update`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${ORGUNITS_UPDATE_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams orgunits_update customerId "false"
            
        else
            getParams "orgunits_update" "customerId"
        fi
        declare -g "ORGUNITS_UPDATE_customerId=${customerId}"

    fi

    
    orgUnitPathMeta=( 
        'string'
        'Full path of the organizational unit or its ID'
    )


    if [[ -z "${ORGUNITS_UPDATE_orgUnitPath}" ]]
    then
        if ! [[ -z "${PARAM_orgUnitPath}" ]]
        then 
            checkParams orgunits_update orgUnitPath "false"
            
        else
            getParams "orgunits_update" "orgUnitPath"
        fi
        declare -g "ORGUNITS_UPDATE_orgUnitPath=${orgUnitPath}"

    fi

    

    ORGUNITS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/orgunits/${orgunitsId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PUT \
            ${ORGUNITS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${ORGUNITS_UPDATE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


privileges_list() {

    apiQueryRef=( `echo privileges list`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${PRIVILEGES_LIST_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams privileges_list customer "false"
            
        else
            getParams "privileges_list" "customer"
        fi
        declare -g "PRIVILEGES_LIST_customer=${customer}"

    fi

    

    PRIVILEGES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles/ALL/privileges?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${PRIVILEGES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${PRIVILEGES_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


roleAssignments_delete() {

    apiQueryRef=( `echo roleAssignments delete`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${ROLEASSIGNMENTS_DELETE_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams roleAssignments_delete customer "false"
            
        else
            getParams "roleAssignments_delete" "customer"
        fi
        declare -g "ROLEASSIGNMENTS_DELETE_customer=${customer}"

    fi

    
    roleAssignmentIdMeta=( 
        'string'
        'Immutable ID of the role assignment.'
    )


    if [[ -z "${ROLEASSIGNMENTS_DELETE_roleAssignmentId}" ]]
    then
        if ! [[ -z "${PARAM_roleAssignmentId}" ]]
        then 
            checkParams roleAssignments_delete roleAssignmentId "false"
            
        else
            getParams "roleAssignments_delete" "roleAssignmentId"
        fi
        declare -g "ROLEASSIGNMENTS_DELETE_roleAssignmentId=${roleAssignmentId}"

    fi

    

    ROLEASSIGNMENTS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roleassignments/${roleAssignmentId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request DELETE \
            ${ROLEASSIGNMENTS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${ROLEASSIGNMENTS_DELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


roleAssignments_get() {

    apiQueryRef=( `echo roleAssignments get`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${ROLEASSIGNMENTS_GET_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams roleAssignments_get customer "false"
            
        else
            getParams "roleAssignments_get" "customer"
        fi
        declare -g "ROLEASSIGNMENTS_GET_customer=${customer}"

    fi

    
    roleAssignmentIdMeta=( 
        'string'
        'Immutable ID of the role assignment.'
    )


    if [[ -z "${ROLEASSIGNMENTS_GET_roleAssignmentId}" ]]
    then
        if ! [[ -z "${PARAM_roleAssignmentId}" ]]
        then 
            checkParams roleAssignments_get roleAssignmentId "false"
            
        else
            getParams "roleAssignments_get" "roleAssignmentId"
        fi
        declare -g "ROLEASSIGNMENTS_GET_roleAssignmentId=${roleAssignmentId}"

    fi

    

    ROLEASSIGNMENTS_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roleassignments/${roleAssignmentId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${ROLEASSIGNMENTS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ROLEASSIGNMENTS_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


roleAssignments_insert() {

    apiQueryRef=( `echo roleAssignments insert`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${ROLEASSIGNMENTS_INSERT_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams roleAssignments_insert customer "false"
            
        else
            getParams "roleAssignments_insert" "customer"
        fi
        declare -g "ROLEASSIGNMENTS_INSERT_customer=${customer}"

    fi

    

    ROLEASSIGNMENTS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roleassignments?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${ROLEASSIGNMENTS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${ROLEASSIGNMENTS_INSERT_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


roleAssignments_list() {

    apiQueryRef=( `echo roleAssignments list`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${ROLEASSIGNMENTS_LIST_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams roleAssignments_list customer "false"
            
        else
            getParams "roleAssignments_list" "customer"
        fi
        declare -g "ROLEASSIGNMENTS_LIST_customer=${customer}"

    fi

    

    ROLEASSIGNMENTS_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roleassignments?key=${CLIENTID}"

    inpParams=( maxResults pageToken roleId userKey )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify the next page in the list.'
    )

    roleIdMeta=(
        'string'
        'Immutable ID of a role. If included in the request, returns only role assignments containing this role ID.'
    )

    userKeyMeta=(
        'string'
        'The user'\''s primary email address, alias email address, or unique user ID. If included in the request, returns role assignments only for this user.'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear
                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams roleAssignments_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            ROLEASSIGNMENTS_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "roleAssignments_list" "${option}" "true"
                        ROLEASSIGNMENTS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request GET \
            ${ROLEASSIGNMENTS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ROLEASSIGNMENTS_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


roles_delete() {

    apiQueryRef=( `echo roles delete`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${ROLES_DELETE_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams roles_delete customer "false"
            
        else
            getParams "roles_delete" "customer"
        fi
        declare -g "ROLES_DELETE_customer=${customer}"

    fi

    
    roleIdMeta=( 
        'string'
        'Immutable ID of the role.'
    )


    if [[ -z "${ROLES_DELETE_roleId}" ]]
    then
        if ! [[ -z "${PARAM_roleId}" ]]
        then 
            checkParams roles_delete roleId "false"
            
        else
            getParams "roles_delete" "roleId"
        fi
        declare -g "ROLES_DELETE_roleId=${roleId}"

    fi

    

    ROLES_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles/${roleId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request DELETE \
            ${ROLES_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${ROLES_DELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


roles_get() {

    apiQueryRef=( `echo roles get`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${ROLES_GET_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams roles_get customer "false"
            
        else
            getParams "roles_get" "customer"
        fi
        declare -g "ROLES_GET_customer=${customer}"

    fi

    
    roleIdMeta=( 
        'string'
        'Immutable ID of the role.'
    )


    if [[ -z "${ROLES_GET_roleId}" ]]
    then
        if ! [[ -z "${PARAM_roleId}" ]]
        then 
            checkParams roles_get roleId "false"
            
        else
            getParams "roles_get" "roleId"
        fi
        declare -g "ROLES_GET_roleId=${roleId}"

    fi

    

    ROLES_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles/${roleId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${ROLES_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ROLES_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


roles_insert() {

    apiQueryRef=( `echo roles insert`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${ROLES_INSERT_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams roles_insert customer "false"
            
        else
            getParams "roles_insert" "customer"
        fi
        declare -g "ROLES_INSERT_customer=${customer}"

    fi

    

    ROLES_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${ROLES_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${ROLES_INSERT_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


roles_list() {

    apiQueryRef=( `echo roles list`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${ROLES_LIST_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams roles_list customer "false"
            
        else
            getParams "roles_list" "customer"
        fi
        declare -g "ROLES_LIST_customer=${customer}"

    fi

    

    ROLES_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles?key=${CLIENTID}"

    inpParams=( maxResults pageToken )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify the next page in the list.'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear
                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams roles_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            ROLES_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "roles_list" "${option}" "true"
                        ROLES_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request GET \
            ${ROLES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${ROLES_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


roles_patch() {

    apiQueryRef=( `echo roles patch`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${ROLES_PATCH_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams roles_patch customer "false"
            
        else
            getParams "roles_patch" "customer"
        fi
        declare -g "ROLES_PATCH_customer=${customer}"

    fi

    
    roleIdMeta=( 
        'string'
        'Immutable ID of the role.'
    )


    if [[ -z "${ROLES_PATCH_roleId}" ]]
    then
        if ! [[ -z "${PARAM_roleId}" ]]
        then 
            checkParams roles_patch roleId "false"
            
        else
            getParams "roles_patch" "roleId"
        fi
        declare -g "ROLES_PATCH_roleId=${roleId}"

    fi

    

    ROLES_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles/${roleId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PATCH \
            ${ROLES_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${ROLES_PATCH_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


roles_update() {

    apiQueryRef=( `echo roles update`)


    customerMeta=( 
        'string'
        'Immutable ID of the G Suite account.'
    )


    if [[ -z "${ROLES_UPDATE_customer}" ]]
    then
        if ! [[ -z "${PARAM_customer}" ]]
        then 
            checkParams roles_update customer "false"
            
        else
            getParams "roles_update" "customer"
        fi
        declare -g "ROLES_UPDATE_customer=${customer}"

    fi

    
    roleIdMeta=( 
        'string'
        'Immutable ID of the role.'
    )


    if [[ -z "${ROLES_UPDATE_roleId}" ]]
    then
        if ! [[ -z "${PARAM_roleId}" ]]
        then 
            checkParams roles_update roleId "false"
            
        else
            getParams "roles_update" "roleId"
        fi
        declare -g "ROLES_UPDATE_roleId=${roleId}"

    fi

    

    ROLES_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customer}/roles/${roleId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PUT \
            ${ROLES_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${ROLES_UPDATE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


schemas_delete() {

    apiQueryRef=( `echo schemas delete`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${SCHEMAS_DELETE_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams schemas_delete customerId "false"
            
        else
            getParams "schemas_delete" "customerId"
        fi
        declare -g "SCHEMAS_DELETE_customerId=${customerId}"

    fi

    
    schemaKeyMeta=( 
        'string'
        'Name or immutable ID of the schema'
    )


    if [[ -z "${SCHEMAS_DELETE_schemaKey}" ]]
    then
        if ! [[ -z "${PARAM_schemaKey}" ]]
        then 
            checkParams schemas_delete schemaKey "false"
            
        else
            getParams "schemas_delete" "schemaKey"
        fi
        declare -g "SCHEMAS_DELETE_schemaKey=${schemaKey}"

    fi

    

    SCHEMAS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/schemas/${schemaKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request DELETE \
            ${SCHEMAS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${SCHEMAS_DELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


schemas_get() {

    apiQueryRef=( `echo schemas get`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${SCHEMAS_GET_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams schemas_get customerId "false"
            
        else
            getParams "schemas_get" "customerId"
        fi
        declare -g "SCHEMAS_GET_customerId=${customerId}"

    fi

    
    schemaKeyMeta=( 
        'string'
        'Name or immutable ID of the schema'
    )


    if [[ -z "${SCHEMAS_GET_schemaKey}" ]]
    then
        if ! [[ -z "${PARAM_schemaKey}" ]]
        then 
            checkParams schemas_get schemaKey "false"
            
        else
            getParams "schemas_get" "schemaKey"
        fi
        declare -g "SCHEMAS_GET_schemaKey=${schemaKey}"

    fi

    

    SCHEMAS_GET_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/schemas/${schemaKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${SCHEMAS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${SCHEMAS_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


schemas_insert() {

    apiQueryRef=( `echo schemas insert`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${SCHEMAS_INSERT_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams schemas_insert customerId "false"
            
        else
            getParams "schemas_insert" "customerId"
        fi
        declare -g "SCHEMAS_INSERT_customerId=${customerId}"

    fi

    

    SCHEMAS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/schemas?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${SCHEMAS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${SCHEMAS_INSERT_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


schemas_list() {

    apiQueryRef=( `echo schemas list`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${SCHEMAS_LIST_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams schemas_list customerId "false"
            
        else
            getParams "schemas_list" "customerId"
        fi
        declare -g "SCHEMAS_LIST_customerId=${customerId}"

    fi

    

    SCHEMAS_LIST_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/schemas?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${SCHEMAS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${SCHEMAS_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


schemas_patch() {

    apiQueryRef=( `echo schemas patch`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${SCHEMAS_PATCH_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams schemas_patch customerId "false"
            
        else
            getParams "schemas_patch" "customerId"
        fi
        declare -g "SCHEMAS_PATCH_customerId=${customerId}"

    fi

    
    schemaKeyMeta=( 
        'string'
        'Name or immutable ID of the schema.'
    )


    if [[ -z "${SCHEMAS_PATCH_schemaKey}" ]]
    then
        if ! [[ -z "${PARAM_schemaKey}" ]]
        then 
            checkParams schemas_patch schemaKey "false"
            
        else
            getParams "schemas_patch" "schemaKey"
        fi
        declare -g "SCHEMAS_PATCH_schemaKey=${schemaKey}"

    fi

    

    SCHEMAS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/schemas/${schemaKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PATCH \
            ${SCHEMAS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${SCHEMAS_PATCH_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


schemas_update() {

    apiQueryRef=( `echo schemas update`)


    customerIdMeta=( 
        'string'
        'Immutable ID of the G Suite account'
    )


    if [[ -z "${SCHEMAS_UPDATE_customerId}" ]]
    then
        if ! [[ -z "${PARAM_customerId}" ]]
        then 
            checkParams schemas_update customerId "false"
            
        else
            getParams "schemas_update" "customerId"
        fi
        declare -g "SCHEMAS_UPDATE_customerId=${customerId}"

    fi

    
    schemaKeyMeta=( 
        'string'
        'Name or immutable ID of the schema.'
    )


    if [[ -z "${SCHEMAS_UPDATE_schemaKey}" ]]
    then
        if ! [[ -z "${PARAM_schemaKey}" ]]
        then 
            checkParams schemas_update schemaKey "false"
            
        else
            getParams "schemas_update" "schemaKey"
        fi
        declare -g "SCHEMAS_UPDATE_schemaKey=${schemaKey}"

    fi

    

    SCHEMAS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/customer/${customerId}/schemas/${schemaKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PUT \
            ${SCHEMAS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${SCHEMAS_UPDATE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


tokens_delete() {

    apiQueryRef=( `echo tokens delete`)


    clientIdMeta=( 
        'string'
        'The Client ID of the application the token is issued to.'
    )


    if [[ -z "${TOKENS_DELETE_clientId}" ]]
    then
        if ! [[ -z "${PARAM_clientId}" ]]
        then 
            checkParams tokens_delete clientId "false"
            
        else
            getParams "tokens_delete" "clientId"
        fi
        declare -g "TOKENS_DELETE_clientId=${clientId}"

    fi

    
    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if [[ -z "${TOKENS_DELETE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams tokens_delete userKey "false"
            
        else
            getParams "tokens_delete" "userKey"
        fi
        declare -g "TOKENS_DELETE_userKey=${userKey}"

    fi

    

    TOKENS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/tokens/${clientId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request DELETE \
            ${TOKENS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${TOKENS_DELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


tokens_get() {

    apiQueryRef=( `echo tokens get`)


    clientIdMeta=( 
        'string'
        'The Client ID of the application the token is issued to.'
    )


    if [[ -z "${TOKENS_GET_clientId}" ]]
    then
        if ! [[ -z "${PARAM_clientId}" ]]
        then 
            checkParams tokens_get clientId "false"
            
        else
            getParams "tokens_get" "clientId"
        fi
        declare -g "TOKENS_GET_clientId=${clientId}"

    fi

    
    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if [[ -z "${TOKENS_GET_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams tokens_get userKey "false"
            
        else
            getParams "tokens_get" "userKey"
        fi
        declare -g "TOKENS_GET_userKey=${userKey}"

    fi

    

    TOKENS_GET_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/tokens/${clientId}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${TOKENS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${TOKENS_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


tokens_list() {

    apiQueryRef=( `echo tokens list`)


    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if [[ -z "${TOKENS_LIST_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams tokens_list userKey "false"
            
        else
            getParams "tokens_list" "userKey"
        fi
        declare -g "TOKENS_LIST_userKey=${userKey}"

    fi

    

    TOKENS_LIST_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/tokens?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${TOKENS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${TOKENS_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


twoStepVerification_turnOff() {

    apiQueryRef=( `echo twoStepVerification turnOff`)


    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if [[ -z "${TWOSTEPVERIFICATION_TURNOFF_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams twoStepVerification_turnOff userKey "false"
            
        else
            getParams "twoStepVerification_turnOff" "userKey"
        fi
        declare -g "TWOSTEPVERIFICATION_TURNOFF_userKey=${userKey}"

    fi

    

    TWOSTEPVERIFICATION_TURNOFF_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/twoStepVerification/turnOff?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${TWOSTEPVERIFICATION_TURNOFF_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${TWOSTEPVERIFICATION_TURNOFF_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


users_delete() {

    apiQueryRef=( `echo users delete`)


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user'
    )


    if [[ -z "${USERS_DELETE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams users_delete userKey "false"
            
        else
            getParams "users_delete" "userKey"
        fi
        declare -g "USERS_DELETE_userKey=${userKey}"

    fi

    

    USERS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request DELETE \
            ${USERS_DELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request DELETE \\ 
        ${USERS_DELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


users_get() {

    apiQueryRef=( `echo users get`)


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user'
    )


    if [[ -z "${USERS_GET_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams users_get userKey "false"
            
        else
            getParams "users_get" "userKey"
        fi
        declare -g "USERS_GET_userKey=${userKey}"

    fi

    

    USERS_GET_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}?key=${CLIENTID}"

    optParams=( projection viewType )

    projectionMeta=(
        'string'
        'What subset of fields to fetch for this user.'
        '["projectionUndefined","basic","custom","full"]'
    )

    viewTypeMeta=(
        'string'
        'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
        '["view_type_undefined","admin_view","domain_public"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams users_get ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            USERS_GET_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "users_get" "${option}" "true"
                        USERS_GET_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                        
                fi
            fi
        done
    fi
    inpParams=( customFieldMask )

    customFieldMaskMeta=(
        'string'
        'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear
                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams users_get ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            USERS_GET_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "users_get" "${option}" "true"
                        USERS_GET_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request GET \
            ${USERS_GET_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${USERS_GET_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


users_insert() {

    apiQueryRef=( `echo users insert`)



    USERS_INSERT_URL="https://www.googleapis.com/admin/directory/v1/users?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${USERS_INSERT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${USERS_INSERT_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


users_list() {

    apiQueryRef=( `echo users list`)



    USERS_LIST_URL="https://www.googleapis.com/admin/directory/v1/users?key=${CLIENTID}"

    optParams=( orderBy projection sortOrder viewType )

    orderByMeta=(
        'string'
        'Column to use for sorting results'
        '["orderByUndefined","email","familyName","givenName"]'
    )

    projectionMeta=(
        'string'
        'What subset of fields to fetch for this user.'
        '["projectionUndefined","basic","custom","full"]'
    )

    sortOrderMeta=(
        'string'
        'Whether to return results in ascending or descending order.'
        '["SORT_ORDER_UNDEFINED","ASCENDING","DESCENDING"]'
    )

    viewTypeMeta=(
        'string'
        'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
        '["view_type_undefined","admin_view","domain_public"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams users_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            USERS_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "users_list" "${option}" "true"
                        USERS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                        
                fi
            fi
        done
    fi
    inpParams=( customFieldMask customer domain maxResults pageToken query showDeleted )

    customFieldMaskMeta=(
        'string'
        'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )

    customerMeta=(
        'string'
        'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )

    domainMeta=(
        'string'
        'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead.'
    )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify next page in the list'
    )

    queryMeta=(
        'string'
        'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )

    showDeletedMeta=(
        'string'
        'If set to true, retrieves the list of deleted users. (Default: false)'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear
                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams users_list ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            USERS_LIST_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "users_list" "${option}" "true"
                        USERS_LIST_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request GET \
            ${USERS_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${USERS_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


users_makeAdmin() {

    apiQueryRef=( `echo users makeAdmin`)


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user as admin'
    )


    if [[ -z "${USERS_MAKEADMIN_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams users_makeAdmin userKey "false"
            
        else
            getParams "users_makeAdmin" "userKey"
        fi
        declare -g "USERS_MAKEADMIN_userKey=${userKey}"

    fi

    

    USERS_MAKEADMIN_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/makeAdmin?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${USERS_MAKEADMIN_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${USERS_MAKEADMIN_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


users_patch() {

    apiQueryRef=( `echo users patch`)


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user. If ID, it should match with id of user object'
    )


    if [[ -z "${USERS_PATCH_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams users_patch userKey "false"
            
        else
            getParams "users_patch" "userKey"
        fi
        declare -g "USERS_PATCH_userKey=${userKey}"

    fi

    

    USERS_PATCH_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PATCH \
            ${USERS_PATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PATCH \\ 
        ${USERS_PATCH_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


users_signOut() {

    apiQueryRef=( `echo users signOut`)


    userKeyMeta=( 
        'string'
        'Identifies the target user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if [[ -z "${USERS_SIGNOUT_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams users_signOut userKey "false"
            
        else
            getParams "users_signOut" "userKey"
        fi
        declare -g "USERS_SIGNOUT_userKey=${userKey}"

    fi

    

    USERS_SIGNOUT_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/signOut?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${USERS_SIGNOUT_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${USERS_SIGNOUT_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


users_undelete() {

    apiQueryRef=( `echo users undelete`)


    userKeyMeta=( 
        'string'
        'The immutable id of the user'
    )


    if [[ -z "${USERS_UNDELETE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams users_undelete userKey "false"
            
        else
            getParams "users_undelete" "userKey"
        fi
        declare -g "USERS_UNDELETE_userKey=${userKey}"

    fi

    

    USERS_UNDELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/undelete?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${USERS_UNDELETE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${USERS_UNDELETE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


users_update() {

    apiQueryRef=( `echo users update`)


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user. If ID, it should match with id of user object'
    )


    if [[ -z "${USERS_UPDATE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams users_update userKey "false"
            
        else
            getParams "users_update" "userKey"
        fi
        declare -g "USERS_UPDATE_userKey=${userKey}"

    fi

    

    USERS_UPDATE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request PUT \
            ${USERS_UPDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request PUT \\ 
        ${USERS_UPDATE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


users_watch() {

    apiQueryRef=( `echo users watch`)



    USERS_WATCH_URL="https://www.googleapis.com/admin/directory/v1/users/watch?key=${CLIENTID}"

    optParams=( event orderBy projection sortOrder viewType )

    eventMeta=(
        'string'
        'Event on which subscription is intended'
        '["eventTypeUnspecified","add","delete","makeAdmin","undelete","update"]'
    )

    orderByMeta=(
        'string'
        'Column to use for sorting results'
        '["orderByUnspecified","email","familyName","givenName"]'
    )

    projectionMeta=(
        'string'
        'What subset of fields to fetch for this user.'
        '["projectionUnspecified","basic","custom","full"]'
    )

    sortOrderMeta=(
        'string'
        'Whether to return results in ascending or descending order.'
        '["sortOrderUnspecified","ASCENDING","DESCENDING"]'
    )

    viewTypeMeta=(
        'string'
        'Whether to fetch the ADMIN_VIEW or DOMAIN_PUBLIC view of the user.'
        '["admin_view","domain_public"]'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define optional params?" "${optParams}" \
    | read -r optParChoice


    if [[ ${optParChoice} == "yes" ]]
    then
        for (( i = 1 ; i <= ${#optParams[@]} ; i++ ))
        do

            echo "${optParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option
            
            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break
                else
                    clear

                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams users_watch ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            USERS_WATCH_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "users_watch" "${option}" "true"
                        USERS_WATCH_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                        
                fi
            fi
        done
    fi
    inpParams=( customFieldMask customer domain maxResults pageToken query showDeleted )

    customFieldMaskMeta=(
        'string'
        'Comma-separated list of schema names. All fields from these schemas are fetched. This should only be set when projection=custom.'
    )

    customerMeta=(
        'string'
        'Immutable ID of the G Suite account. In case of multi-domain, to fetch all users for a customer, fill this field instead of domain.'
    )

    domainMeta=(
        'string'
        'Name of the domain. Fill this field to get users from only this domain. To return all users in a multi-domain fill customer field instead."'
    )

    maxResultsMeta=(
        'integer'
        'Maximum number of results to return.'
    )

    pageTokenMeta=(
        'string'
        'Token to specify next page in the list'
    )

    queryMeta=(
        'string'
        'Query string search. Should be of the form "". Complete documentation is at https: //developers.google.com/admin-sdk/directory/v1/guides/search-users'
    )

    showDeletedMeta=(
        'string'
        'If set to true, retrieves the list of deleted users. (Default: false)'
    )


    echo "yes no" \
    | fuzzExPromptParameters "Define input params?" "${inpParams}" \
    | read -r inpParChoice


    if [[ ${inpParChoice} =~ "y" ]] || [[ ${inpParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= ${#inpParams[@]} ; i++ ))
        do

            echo "${inpParams}" "[none]" \
            | fuzzExAllParameters "${apiQueryRef[1]}" "${apiQueryRef[2]}" \
            | read -r option

            if [[ -n ${option} ]]
            then
                if [[ ${option} == "[none]" ]]
                then
                    clear
                    break 
                else
                    clear
                    local optParam=PARAM_${option}
                    if ! [[ -z "${(P)${optParam}}" ]]
                    then 
                        checkParams users_watch ${option} "true"
                        if ! [[ ${addedParams} =~ ${option} ]]
                        then
                            USERS_WATCH_URL+="${tempUrlPar}"
                            addedParams+=( "${option}" )
                            unset tempUrlPar
                        else
                            echo -e "# Error! Parameter already provided before, skipping.\n\n"
                        fi
                    else
                        getParams "users_watch" "${option}" "true"
                        USERS_WATCH_URL+="${tempUrlPar}"
                        unset tempUrlPar
                    fi
                    unset optParam
                fi
            fi
        done
    fi
    execRequest() {
    
        curl -s \
            --request POST \
            ${USERS_WATCH_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${USERS_WATCH_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


verificationCodes_generate() {

    apiQueryRef=( `echo verificationCodes generate`)


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user'
    )


    if [[ -z "${VERIFICATIONCODES_GENERATE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams verificationCodes_generate userKey "false"
            
        else
            getParams "verificationCodes_generate" "userKey"
        fi
        declare -g "VERIFICATIONCODES_GENERATE_userKey=${userKey}"

    fi

    

    VERIFICATIONCODES_GENERATE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/verificationCodes/generate?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${VERIFICATIONCODES_GENERATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${VERIFICATIONCODES_GENERATE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


verificationCodes_invalidate() {

    apiQueryRef=( `echo verificationCodes invalidate`)


    userKeyMeta=( 
        'string'
        'Email or immutable ID of the user'
    )


    if [[ -z "${VERIFICATIONCODES_INVALIDATE_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams verificationCodes_invalidate userKey "false"
            
        else
            getParams "verificationCodes_invalidate" "userKey"
        fi
        declare -g "VERIFICATIONCODES_INVALIDATE_userKey=${userKey}"

    fi

    

    VERIFICATIONCODES_INVALIDATE_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/verificationCodes/invalidate?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request POST \
            ${VERIFICATIONCODES_INVALIDATE_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --header "Content-Type: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request POST \\ 
        ${VERIFICATIONCODES_INVALIDATE_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --header "Content-Type: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}


verificationCodes_list() {

    apiQueryRef=( `echo verificationCodes list`)


    userKeyMeta=( 
        'string'
        'Identifies the user in the API request. The value can be the user'\''s primary email address, alias email address, or unique user ID.'
    )


    if [[ -z "${VERIFICATIONCODES_LIST_userKey}" ]]
    then
        if ! [[ -z "${PARAM_userKey}" ]]
        then 
            checkParams verificationCodes_list userKey "false"
            
        else
            getParams "verificationCodes_list" "userKey"
        fi
        declare -g "VERIFICATIONCODES_LIST_userKey=${userKey}"

    fi

    

    VERIFICATIONCODES_LIST_URL="https://www.googleapis.com/admin/directory/v1/users/${userKey}/verificationCodes?key=${CLIENTID}"

    execRequest() {
    
        curl -s \
            --request GET \
            ${VERIFICATIONCODES_LIST_URL} \
            --header "Authorization: Bearer ${ACCESSTOKEN}" \
            --header "Accept: application/json" \
            --compressed \
            | jq -c '.' \
            | read -r outputJson
        export outputJson

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        cat << EOIF

    curl -s \\ 
        --request GET \\ 
        ${VERIFICATIONCODES_LIST_URL} \\ 
EOIF
        cat << EOIF
        --header "Authorization: Bearer ${ACCESSTOKEN}" \\ 
EOIF
        cat << EOIF
        --header "Accept: application/json" \\ 
EOIF
        cat << EOIF
        --compressed
EOIF

        echo -e "\n\n"
        echo -e "#########################\n"
    }
    execRequest

}

