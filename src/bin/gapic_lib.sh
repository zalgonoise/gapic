#!/bin/zsh

gapicSets=( ASPs Users )

ASPs=( aspDelete aspGet aspList )
Users=( usersDelete usersGet usersList )
aspDelete() {



    if [[ -z "${ASP_DELETE_CODEID}" ]]
    then

        if ! [[ -z "${SAVED_REQPAR}" ]] \
        && [[ ${SAVED_REQPAR} =~ "CODEID" ]]
        then 
            echo -en "# Do you want to reuse last saved CODEID: ${SAVED_REQVAL}? [y/n]\n~> "
            read -r reuseReqParOpt
            clear

            if ! [[ ${reuseReqParOpt} =~ "n" ]] \
            && ! [[ ${reuseReqParOpt} =~ "N" ]]
            then
                ASP_DELETE_REQPAR=${SAVED_REQPAR}
                ASP_DELETE_REQVAL=${SAVED_REQVAL}
                declare -g "ASP_DELETE_CODEID=${SAVED_REQVAL}"
            else
                echo -en "# Please supply CODEID.\n~> "
                read -r ASP_DELETE_CODEID
                clear
                declare -g "SAVED_REQPAR=CODEID"
                declare -g "SAVED_REQVAL=${ASP_DELETE_CODEID}"


                if [[ -f ${credFileParams} ]] \
                && ! [[ `grep "SAVED_REQPAR=CODEID" ${credFileParams}` ]] \
                && ! [[ `grep "SAVED_REQVAL=${ASP_DELETE_CODEID}" ${credFileParams}` ]]
                then
                    cat << EOIF >> ${credFileParams}
SAVED_REQPAR=CODEID
SAVED_REQVAL=${ASP_DELETE_CODEID}
EOIF
                fi
            fi
        else
            echo -en "# Please supply CODEID.\n~> "
            read -r ASP_DELETE_CODEID
            clear
            declare -g "SAVED_REQPAR=CODEID"
            declare -g "SAVED_REQVAL=${ASP_DELETE_CODEID}"

            if [[ -f ${credFileParams} ]] \
            && ! [[ `grep "SAVED_REQPAR=CODEID" ${credFileParams}` ]] \
            && ! [[ `grep "SAVED_REQVAL=${ASP_DELETE_CODEID}" ${credFileParams}` ]]
            then
                cat << EOIF >> ${credFileParams}
SAVED_REQPAR=CODEID
SAVED_REQVAL=${ASP_DELETE_CODEID}
EOIF
            fi
        fi
    fi

    if [[ -z "${ASP_DELETE_USERKEY}" ]]
    then

        if ! [[ -z "${SAVED_REQPAR}" ]] \
        && [[ ${SAVED_REQPAR} =~ "USERKEY" ]]
        then 
            echo -en "# Do you want to reuse last saved USERKEY: ${SAVED_REQVAL}? [y/n]\n~> "
            read -r reuseReqParOpt
            clear

            if ! [[ ${reuseReqParOpt} =~ "n" ]] \
            && ! [[ ${reuseReqParOpt} =~ "N" ]]
            then
                ASP_DELETE_REQPAR=${SAVED_REQPAR}
                ASP_DELETE_REQVAL=${SAVED_REQVAL}
                declare -g "ASP_DELETE_USERKEY=${SAVED_REQVAL}"
            else
                echo -en "# Please supply USERKEY.\n~> "
                read -r ASP_DELETE_USERKEY
                clear
                declare -g "SAVED_REQPAR=USERKEY"
                declare -g "SAVED_REQVAL=${ASP_DELETE_USERKEY}"


                if [[ -f ${credFileParams} ]] \
                && ! [[ `grep "SAVED_REQPAR=USERKEY" ${credFileParams}` ]] \
                && ! [[ `grep "SAVED_REQVAL=${ASP_DELETE_USERKEY}" ${credFileParams}` ]]
                then
                    cat << EOIF >> ${credFileParams}
SAVED_REQPAR=USERKEY
SAVED_REQVAL=${ASP_DELETE_USERKEY}
EOIF
                fi
            fi
        else
            echo -en "# Please supply USERKEY.\n~> "
            read -r ASP_DELETE_USERKEY
            clear
            declare -g "SAVED_REQPAR=USERKEY"
            declare -g "SAVED_REQVAL=${ASP_DELETE_USERKEY}"

            if [[ -f ${credFileParams} ]] \
            && ! [[ `grep "SAVED_REQPAR=USERKEY" ${credFileParams}` ]] \
            && ! [[ `grep "SAVED_REQVAL=${ASP_DELETE_USERKEY}" ${credFileParams}` ]]
            then
                cat << EOIF >> ${credFileParams}
SAVED_REQPAR=USERKEY
SAVED_REQVAL=${ASP_DELETE_USERKEY}
EOIF
            fi
        fi
    fi

    ASP_DELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${ASP_DELETE_USERKEY}/asps/${ASP_DELETE_CODEID}?key=${CLIENTID}"


    echo -en "# Would you like to define extra input parameters? [y/n] \n~> "
    read -r inputParChoice
    clear


    if [[ ${inputParChoice} =~ "y" ]] || [[ ${inputParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= 0 ; i++ ))
        do

            select option in  none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        clear
                        echo -en "# Define ${option}:\n~> "
                        read -r inParDef
                        clear

                        declare -g "ASP_DELETE_PAR_${option:u}=${inParDef}"
                        declare -g "SAVED_PAR_${option:u}=${inParDef}"

                        ASP_DELETE_URL+="&${option}=${inParDef}"

                        break
                    fi
                fi
            done
        done
    fi

    unset inputParChoice option

    curl -s \
        --request DELETE \
        ${ASP_DELETE_URL} \
        --header "Authorization: Bearer ${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \n    --request DELETE \n    ${ASP_DELETE_URL} \n    --header \"Authorization: Bearer ${ACCESSTOKEN}\"\n    --header \"Accept: application/json\"\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

aspGet() {



    if [[ -z "${ASP_GET_CODEID}" ]]
    then

        if ! [[ -z "${SAVED_REQPAR}" ]] \
        && [[ ${SAVED_REQPAR} =~ "CODEID" ]]
        then 
            echo -en "# Do you want to reuse last saved CODEID: ${SAVED_REQVAL}? [y/n]\n~> "
            read -r reuseReqParOpt
            clear

            if ! [[ ${reuseReqParOpt} =~ "n" ]] \
            && ! [[ ${reuseReqParOpt} =~ "N" ]]
            then
                ASP_GET_REQPAR=${SAVED_REQPAR}
                ASP_GET_REQVAL=${SAVED_REQVAL}
                declare -g "ASP_GET_CODEID=${SAVED_REQVAL}"
            else
                echo -en "# Please supply CODEID.\n~> "
                read -r ASP_GET_CODEID
                clear
                declare -g "SAVED_REQPAR=CODEID"
                declare -g "SAVED_REQVAL=${ASP_GET_CODEID}"


                if [[ -f ${credFileParams} ]] \
                && ! [[ `grep "SAVED_REQPAR=CODEID" ${credFileParams}` ]] \
                && ! [[ `grep "SAVED_REQVAL=${ASP_GET_CODEID}" ${credFileParams}` ]]
                then
                    cat << EOIF >> ${credFileParams}
SAVED_REQPAR=CODEID
SAVED_REQVAL=${ASP_GET_CODEID}
EOIF
                fi
            fi
        else
            echo -en "# Please supply CODEID.\n~> "
            read -r ASP_GET_CODEID
            clear
            declare -g "SAVED_REQPAR=CODEID"
            declare -g "SAVED_REQVAL=${ASP_GET_CODEID}"

            if [[ -f ${credFileParams} ]] \
            && ! [[ `grep "SAVED_REQPAR=CODEID" ${credFileParams}` ]] \
            && ! [[ `grep "SAVED_REQVAL=${ASP_GET_CODEID}" ${credFileParams}` ]]
            then
                cat << EOIF >> ${credFileParams}
SAVED_REQPAR=CODEID
SAVED_REQVAL=${ASP_GET_CODEID}
EOIF
            fi
        fi
    fi

    if [[ -z "${ASP_GET_USERKEY}" ]]
    then

        if ! [[ -z "${SAVED_REQPAR}" ]] \
        && [[ ${SAVED_REQPAR} =~ "USERKEY" ]]
        then 
            echo -en "# Do you want to reuse last saved USERKEY: ${SAVED_REQVAL}? [y/n]\n~> "
            read -r reuseReqParOpt
            clear

            if ! [[ ${reuseReqParOpt} =~ "n" ]] \
            && ! [[ ${reuseReqParOpt} =~ "N" ]]
            then
                ASP_GET_REQPAR=${SAVED_REQPAR}
                ASP_GET_REQVAL=${SAVED_REQVAL}
                declare -g "ASP_GET_USERKEY=${SAVED_REQVAL}"
            else
                echo -en "# Please supply USERKEY.\n~> "
                read -r ASP_GET_USERKEY
                clear
                declare -g "SAVED_REQPAR=USERKEY"
                declare -g "SAVED_REQVAL=${ASP_GET_USERKEY}"


                if [[ -f ${credFileParams} ]] \
                && ! [[ `grep "SAVED_REQPAR=USERKEY" ${credFileParams}` ]] \
                && ! [[ `grep "SAVED_REQVAL=${ASP_GET_USERKEY}" ${credFileParams}` ]]
                then
                    cat << EOIF >> ${credFileParams}
SAVED_REQPAR=USERKEY
SAVED_REQVAL=${ASP_GET_USERKEY}
EOIF
                fi
            fi
        else
            echo -en "# Please supply USERKEY.\n~> "
            read -r ASP_GET_USERKEY
            clear
            declare -g "SAVED_REQPAR=USERKEY"
            declare -g "SAVED_REQVAL=${ASP_GET_USERKEY}"

            if [[ -f ${credFileParams} ]] \
            && ! [[ `grep "SAVED_REQPAR=USERKEY" ${credFileParams}` ]] \
            && ! [[ `grep "SAVED_REQVAL=${ASP_GET_USERKEY}" ${credFileParams}` ]]
            then
                cat << EOIF >> ${credFileParams}
SAVED_REQPAR=USERKEY
SAVED_REQVAL=${ASP_GET_USERKEY}
EOIF
            fi
        fi
    fi

    ASP_GET_URL="https://www.googleapis.com/admin/directory/v1/users/${ASP_GET_USERKEY}/asps/${ASP_GET_CODEID}?key=${CLIENTID}"


    echo -en "# Would you like to define extra input parameters? [y/n] \n~> "
    read -r inputParChoice
    clear


    if [[ ${inputParChoice} =~ "y" ]] || [[ ${inputParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= 0 ; i++ ))
        do

            select option in  none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        clear
                        echo -en "# Define ${option}:\n~> "
                        read -r inParDef
                        clear

                        declare -g "ASP_GET_PAR_${option:u}=${inParDef}"
                        declare -g "SAVED_PAR_${option:u}=${inParDef}"

                        ASP_GET_URL+="&${option}=${inParDef}"

                        break
                    fi
                fi
            done
        done
    fi

    unset inputParChoice option

    curl -s \
        --request GET \
        ${ASP_GET_URL} \
        --header "Authorization: Bearer ${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \n    --request GET \n    ${ASP_GET_URL} \n    --header \"Authorization: Bearer ${ACCESSTOKEN}\"\n    --header \"Accept: application/json\"\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

aspList() {



    if [[ -z "${ASP_LIST_USERKEY}" ]]
    then

        if ! [[ -z "${SAVED_REQPAR}" ]] \
        && [[ ${SAVED_REQPAR} =~ "USERKEY" ]]
        then 
            echo -en "# Do you want to reuse last saved USERKEY: ${SAVED_REQVAL}? [y/n]\n~> "
            read -r reuseReqParOpt
            clear

            if ! [[ ${reuseReqParOpt} =~ "n" ]] \
            && ! [[ ${reuseReqParOpt} =~ "N" ]]
            then
                ASP_LIST_REQPAR=${SAVED_REQPAR}
                ASP_LIST_REQVAL=${SAVED_REQVAL}
                declare -g "ASP_LIST_USERKEY=${SAVED_REQVAL}"
            else
                echo -en "# Please supply USERKEY.\n~> "
                read -r ASP_LIST_USERKEY
                clear
                declare -g "SAVED_REQPAR=USERKEY"
                declare -g "SAVED_REQVAL=${ASP_LIST_USERKEY}"


                if [[ -f ${credFileParams} ]] \
                && ! [[ `grep "SAVED_REQPAR=USERKEY" ${credFileParams}` ]] \
                && ! [[ `grep "SAVED_REQVAL=${ASP_LIST_USERKEY}" ${credFileParams}` ]]
                then
                    cat << EOIF >> ${credFileParams}
SAVED_REQPAR=USERKEY
SAVED_REQVAL=${ASP_LIST_USERKEY}
EOIF
                fi
            fi
        else
            echo -en "# Please supply USERKEY.\n~> "
            read -r ASP_LIST_USERKEY
            clear
            declare -g "SAVED_REQPAR=USERKEY"
            declare -g "SAVED_REQVAL=${ASP_LIST_USERKEY}"

            if [[ -f ${credFileParams} ]] \
            && ! [[ `grep "SAVED_REQPAR=USERKEY" ${credFileParams}` ]] \
            && ! [[ `grep "SAVED_REQVAL=${ASP_LIST_USERKEY}" ${credFileParams}` ]]
            then
                cat << EOIF >> ${credFileParams}
SAVED_REQPAR=USERKEY
SAVED_REQVAL=${ASP_LIST_USERKEY}
EOIF
            fi
        fi
    fi

    ASP_LIST_URL="https://www.googleapis.com/admin/directory/v1/users/${ASP_LIST_USERKEY}/asps?key=${CLIENTID}"


    echo -en "# Would you like to define extra input parameters? [y/n] \n~> "
    read -r inputParChoice
    clear


    if [[ ${inputParChoice} =~ "y" ]] || [[ ${inputParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= 0 ; i++ ))
        do

            select option in  none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        clear
                        echo -en "# Define ${option}:\n~> "
                        read -r inParDef
                        clear

                        declare -g "ASP_LIST_PAR_${option:u}=${inParDef}"
                        declare -g "SAVED_PAR_${option:u}=${inParDef}"

                        ASP_LIST_URL+="&${option}=${inParDef}"

                        break
                    fi
                fi
            done
        done
    fi

    unset inputParChoice option

    curl -s \
        --request GET \
        ${ASP_LIST_URL} \
        --header "Authorization: Bearer ${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \n    --request GET \n    ${ASP_LIST_URL} \n    --header \"Authorization: Bearer ${ACCESSTOKEN}\"\n    --header \"Accept: application/json\"\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

usersDelete() {



    if [[ -z "${USERS_DELETE_USERKEY}" ]]
    then

        if ! [[ -z "${SAVED_REQPAR}" ]] \
        && [[ ${SAVED_REQPAR} =~ "USERKEY" ]]
        then 
            echo -en "# Do you want to reuse last saved USERKEY: ${SAVED_REQVAL}? [y/n]\n~> "
            read -r reuseReqParOpt
            clear

            if ! [[ ${reuseReqParOpt} =~ "n" ]] \
            && ! [[ ${reuseReqParOpt} =~ "N" ]]
            then
                USERS_DELETE_REQPAR=${SAVED_REQPAR}
                USERS_DELETE_REQVAL=${SAVED_REQVAL}
                declare -g "USERS_DELETE_USERKEY=${SAVED_REQVAL}"
            else
                echo -en "# Please supply USERKEY.\n~> "
                read -r USERS_DELETE_USERKEY
                clear
                declare -g "SAVED_REQPAR=USERKEY"
                declare -g "SAVED_REQVAL=${USERS_DELETE_USERKEY}"


                if [[ -f ${credFileParams} ]] \
                && ! [[ `grep "SAVED_REQPAR=USERKEY" ${credFileParams}` ]] \
                && ! [[ `grep "SAVED_REQVAL=${USERS_DELETE_USERKEY}" ${credFileParams}` ]]
                then
                    cat << EOIF >> ${credFileParams}
SAVED_REQPAR=USERKEY
SAVED_REQVAL=${USERS_DELETE_USERKEY}
EOIF
                fi
            fi
        else
            echo -en "# Please supply USERKEY.\n~> "
            read -r USERS_DELETE_USERKEY
            clear
            declare -g "SAVED_REQPAR=USERKEY"
            declare -g "SAVED_REQVAL=${USERS_DELETE_USERKEY}"

            if [[ -f ${credFileParams} ]] \
            && ! [[ `grep "SAVED_REQPAR=USERKEY" ${credFileParams}` ]] \
            && ! [[ `grep "SAVED_REQVAL=${USERS_DELETE_USERKEY}" ${credFileParams}` ]]
            then
                cat << EOIF >> ${credFileParams}
SAVED_REQPAR=USERKEY
SAVED_REQVAL=${USERS_DELETE_USERKEY}
EOIF
            fi
        fi
    fi

    USERS_DELETE_URL="https://www.googleapis.com/admin/directory/v1/users/${USERS_DELETE_USERKEY}?key=${CLIENTID}"


    echo -en "# Would you like to define extra input parameters? [y/n] \n~> "
    read -r inputParChoice
    clear


    if [[ ${inputParChoice} =~ "y" ]] || [[ ${inputParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= 0 ; i++ ))
        do

            select option in  none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        clear
                        echo -en "# Define ${option}:\n~> "
                        read -r inParDef
                        clear

                        declare -g "USERS_DELETE_PAR_${option:u}=${inParDef}"
                        declare -g "SAVED_PAR_${option:u}=${inParDef}"

                        USERS_DELETE_URL+="&${option}=${inParDef}"

                        break
                    fi
                fi
            done
        done
    fi

    unset inputParChoice option

    curl -s \
        --request DELETE \
        ${USERS_DELETE_URL} \
        --header "Authorization: Bearer ${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \n    --request DELETE \n    ${USERS_DELETE_URL} \n    --header \"Authorization: Bearer ${ACCESSTOKEN}\"\n    --header \"Accept: application/json\"\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

usersGet() {



    if [[ -z "${USERS_GET_USERKEY}" ]]
    then

        if ! [[ -z "${SAVED_REQPAR}" ]] \
        && [[ ${SAVED_REQPAR} =~ "USERKEY" ]]
        then 
            echo -en "# Do you want to reuse last saved USERKEY: ${SAVED_REQVAL}? [y/n]\n~> "
            read -r reuseReqParOpt
            clear

            if ! [[ ${reuseReqParOpt} =~ "n" ]] \
            && ! [[ ${reuseReqParOpt} =~ "N" ]]
            then
                USERS_GET_REQPAR=${SAVED_REQPAR}
                USERS_GET_REQVAL=${SAVED_REQVAL}
                declare -g "USERS_GET_USERKEY=${SAVED_REQVAL}"
            else
                echo -en "# Please supply USERKEY.\n~> "
                read -r USERS_GET_USERKEY
                clear
                declare -g "SAVED_REQPAR=USERKEY"
                declare -g "SAVED_REQVAL=${USERS_GET_USERKEY}"


                if [[ -f ${credFileParams} ]] \
                && ! [[ `grep "SAVED_REQPAR=USERKEY" ${credFileParams}` ]] \
                && ! [[ `grep "SAVED_REQVAL=${USERS_GET_USERKEY}" ${credFileParams}` ]]
                then
                    cat << EOIF >> ${credFileParams}
SAVED_REQPAR=USERKEY
SAVED_REQVAL=${USERS_GET_USERKEY}
EOIF
                fi
            fi
        else
            echo -en "# Please supply USERKEY.\n~> "
            read -r USERS_GET_USERKEY
            clear
            declare -g "SAVED_REQPAR=USERKEY"
            declare -g "SAVED_REQVAL=${USERS_GET_USERKEY}"

            if [[ -f ${credFileParams} ]] \
            && ! [[ `grep "SAVED_REQPAR=USERKEY" ${credFileParams}` ]] \
            && ! [[ `grep "SAVED_REQVAL=${USERS_GET_USERKEY}" ${credFileParams}` ]]
            then
                cat << EOIF >> ${credFileParams}
SAVED_REQPAR=USERKEY
SAVED_REQVAL=${USERS_GET_USERKEY}
EOIF
            fi
        fi
    fi

    USERS_GET_URL="https://www.googleapis.com/admin/directory/v1/users/${USERS_GET_USERKEY}?key=${CLIENTID}"


    echo -en "# Would you like to define extra input parameters? [y/n] \n~> "
    read -r inputParChoice
    clear


    if [[ ${inputParChoice} =~ "y" ]] || [[ ${inputParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= 0 ; i++ ))
        do

            select option in  none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        clear
                        echo -en "# Define ${option}:\n~> "
                        read -r inParDef
                        clear

                        declare -g "USERS_GET_PAR_${option:u}=${inParDef}"
                        declare -g "SAVED_PAR_${option:u}=${inParDef}"

                        USERS_GET_URL+="&${option}=${inParDef}"

                        break
                    fi
                fi
            done
        done
    fi

    unset inputParChoice option

    USERS_GET_OPTPARAMS=( projection viewType )
    projection=( basic projectionUndefined custom full )
    viewType=( admin_view view_type_undefined domain_public )

    echo -en "# Would you like to define any of these preset parameters? [y/n]\n~> "
    read -r inputOptChoice
    clear

    if [[ ${inputOptChoice} =~ "y" ]] || [[ ${inputOptChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= 2 ; i++ ))
        do

            select option in projection viewType none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        select sec_option in ${(P)option} none
                        do
                            if [[ -n ${sec_option} ]]
                            then
                                if [[ ${sec_option} =~ "none" ]]
                                then
                                    clear
                                    break 2
                                else
                                    clear
                                    declare -g "USERS_GET_PAR_NAME=${option}"
                                    declare -g "USERS_GET_PAR_VAL=${sec_option}"
                                    declare -g "SAVED_PAR_NAME=${option}"
                                    declare -g "SAVED_PAR_VAL=${sec_option}"
                                    USERS_GET_URL+="&${option}=${sec_option}"
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



    curl -s \
        --request GET \
        ${USERS_GET_URL} \
        --header "Authorization: Bearer ${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \n    --request GET \n    ${USERS_GET_URL} \n    --header \"Authorization: Bearer ${ACCESSTOKEN}\"\n    --header \"Accept: application/json\"\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

usersList() {



    USERS_LIST_URL="https://www.googleapis.com/admin/directory/v1/users?key=${CLIENTID}"

    if [[ -z ${USERS_LIST_DOMAIN} ]] \
    && [[ -z ${USERS_LIST_CUSTOMER} ]]
    then
        echo -e "# Mandatory to define one of the following parameters:"
        select option in domain customer
        do
            if [[ -n ${option} ]]
            then
                customParameterOption=${option}
                clear
                break
            fi
        done
        if [[ ${SAVED_CUSTPAR} =~ ${customParameterOption} ]] \
        && ! [[ -z ${SAVED_CUSTVAL} ]]
        then
            echo -en "# Would you like to use your saved ${SAVED_CUSTPAR}: ${SAVED_CUSTVAL}? [y/n]\n\n~> "
            read -r reuseCustParOpt
            clear

            if ! [[ ${reuseCustParOpt} =~ "n" ]] \
            && ! [[ ${reuseCustParOpt} =~ "N" ]]
            then
                USERS_LIST_CUSTPAR=${SAVED_CUSTPAR}
                USERS_LIST_CUSTVAL=${SAVED_CUSTVAL}
                USERS_LIST_URL+="&${USERS_LIST_CUSTPAR}=${USERS_LIST_CUSTVAL}"
            else

                declare -g "USERS_LIST_CUSTPAR=${customParameterOption}"
                declare -g "SAVED_CUSTPAR=${customParameterOption}"
                
                echo -en "# Please supply ${customParameterOption:u}.\n\n~> "
                read -r USERS_LIST_CUSTVAL 
                clear
                declare -g "SAVED_CUSTVAL=${USERS_LIST_CUSTVAL}"
                USERS_LIST_URL+="&${USERS_LIST_CUSTPAR}=${USERS_LIST_CUSTVAL}"
            fi
        else
            declare -g "USERS_LIST_CUSTPAR=${customParameterOption}"
            declare -g "SAVED_CUSTPAR=${customParameterOption}"
            echo -en "# Please supply ${customParameterOption:u}.\n\n~> "
            read -r USERS_LIST_CUSTVAL
            clear

            declare -g "SAVED_CUSTVAL=${USERS_LIST_CUSTVAL}"
            USERS_LIST_URL+="&${USERS_LIST_CUSTPAR}=${USERS_LIST_CUSTVAL}"
        fi

        if [[ -f ${credFileParams} ]] \
        && ! [[ `grep "SAVED_CUSTPAR=${USERS_LIST_CUSTPAR}" ${credFileParams}` ]]
        then
            cat << EOIF >> ${credFileParams}
SAVED_CUSTPAR=${USERS_LIST_CUSTPAR}
EOIF
        fi


        if [[ -f ${credFileParams} ]] \
        && ! [[ `grep "SAVED_CUSTVAL=${USERS_LIST_CUSTVAL}" ${credFileParams}` ]]
        then
            cat << EOIF >> ${credFileParams}
SAVED_CUSTVAL=${USERS_LIST_CUSTVAL}
EOIF
        fi
        clear
    fi

    echo -en "# Would you like to define extra input parameters? [y/n] \n~> "
    read -r inputParChoice
    clear


    if [[ ${inputParChoice} =~ "y" ]] || [[ ${inputParChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= 4 ; i++ ))
        do

            select option in customFieldType maxResults pageToken query none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        clear
                        echo -en "# Define ${option}:\n~> "
                        read -r inParDef
                        clear

                        declare -g "USERS_LIST_PAR_${option:u}=${inParDef}"
                        declare -g "SAVED_PAR_${option:u}=${inParDef}"

                        USERS_LIST_URL+="&${option}=${inParDef}"

                        break
                    fi
                fi
            done
        done
    fi

    unset inputParChoice option

    USERS_LIST_OPTPARAMS=( projection viewType orderBy showDeleted sortOrder )
    projection=( basic projectionUndefined custom full )
    viewType=( admin_view view_type_undefined domain_public )
    orderBy=( orderByUndefined email familyName givenName )
    showDeleted=( true false )
    sortOrder=( DESCENDING ASCENDING SORT_ORDER_UNDEFINED )

    echo -en "# Would you like to define any of these preset parameters? [y/n]\n~> "
    read -r inputOptChoice
    clear

    if [[ ${inputOptChoice} =~ "y" ]] || [[ ${inputOptChoice} =~ "Y" ]]
    then
        for (( i = 1 ; i <= 5 ; i++ ))
        do

            select option in projection viewType orderBy showDeleted sortOrder none
            do
                if [[ -n ${option} ]]
                then
                    if [[ ${option} =~ "none" ]]
                    then
                        clear
                        break 2
                    else
                        select sec_option in ${(P)option} none
                        do
                            if [[ -n ${sec_option} ]]
                            then
                                if [[ ${sec_option} =~ "none" ]]
                                then
                                    clear
                                    break 2
                                else
                                    clear
                                    declare -g "USERS_LIST_PAR_NAME=${option}"
                                    declare -g "USERS_LIST_PAR_VAL=${sec_option}"
                                    declare -g "SAVED_PAR_NAME=${option}"
                                    declare -g "SAVED_PAR_VAL=${sec_option}"
                                    USERS_LIST_URL+="&${option}=${sec_option}"
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



    curl -s \
        --request GET \
        ${USERS_LIST_URL} \
        --header "Authorization: Bearer ${ACCESSTOKEN}" \
        --header "Accept: application/json" \
        --compressed \
        | jq -c '.' \
        | read -r outputJson
        export outputJson

        sentRequest="curl -s \n    --request GET \n    ${USERS_LIST_URL} \n    --header \"Authorization: Bearer ${ACCESSTOKEN}\"\n    --header \"Accept: application/json\"\n    --compressed"

        echo -e "# Request issued:\n\n"
        echo -e "#########################\n"
        echo "${sentRequest}" 
        echo -e "\n\n"
        echo -e "#########################\n"


}

