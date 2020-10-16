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


# Request history JSON builder

histGenRequest() {
    local currentTimestamp=`date +%s`$((`date +%N`/1000000))

    jq -cn  \
    --arg ts ${currentTimestamp} \
    --arg cid ${1} \
    --arg atk ${2} \
    --arg rtk ${3} \
    --arg res ${4} \
    --arg met ${5} \
    --arg hmt ${6} \
    --arg url ${7} \
    '{timestamp: $ts, auth: { clientId: $cid, accessToken: $atk, refreshToken: $rtk }, request: { resource: $res, method: $met, httpMethod: $hmt, url: $url, headers: [] }}' \
    | read requestPayload

    export requestPayload
}

histListBuild() {
    jq "${1}=[${1}[],\"${2}\"]"
}

histNewEntry() {
    if ! [[ `find  ${2} -type f` ]]
    then 
        echo "[${1}]" > ${2}/${3}
    else
        cat ${2}/${3} \
        | histListBuild "." "${1}" \
        > ${2}/${3}
    fi
}

