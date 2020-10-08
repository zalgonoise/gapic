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


# Schema explorer / fuzzy finder

gapicFuzzySchema() {
    cat ${1} \
    | jq 'path(..) | map(tostring) | join(".")' \
    | sed "s/\"//g" \
    | sed "s/^/./" \
    | sed "s/\.\([[:digit:]]\+\)/[\1]/g" \
    | fzf  \
    --preview "cat <(jq -C {1} < ${1})" \
    --bind "ctrl-s:execute% cat <(jq -c {1} < ${1}) | less -R > /dev/tty 2>&1 %" \
    --bind "ctrl-b:preview(cat <(jq -c {1} < ${1}) | base64 -d)" \
    --bind "ctrl-k:preview(cat <(jq -c {1} < ${1}) | jq '. | keys[]')" \
    --bind "tab:replace-query" \
    --bind "ctrl-space:execute% cat <(jq -C {1} < ${1}) | less -R > /dev/tty 2>&1 %" \
    --bind "change:top" \
    --layout=reverse-list \
    --prompt="~ " \
    --pointer="~ " \
    --header="# Fuzzy Object Explorer #" \
    --color=dark \
    --black \
    | xargs -ri jq -C {} <(cat ${1})
}

gapicFuzzyResources() {
    sed 's/ /\n/g' \
    | fzf \
    --preview \
        "cat \
          <( cat ${1} | jq -C  \
            '.resources.{}.methods | keys[]')
        " \
    --bind "tab:replace-query" \
    --bind "ctrl-space:execute% cat ${1}  | jq --sort-keys -C .resources.{}.methods | less -R > /dev/tty 2>&1 %" \
    --bind "change:top" \
    --layout=reverse-list \
    --prompt="~ " \
    --pointer="~ " \
    --header="# Fuzzy Object Explorer #" \
    --color=dark \
    --black 
}

gapicFuzzyMethods() {
    sed 's/ /\n/g' \
    | sed "s/^[^.]*_//g" \
    | fzf \
    --preview \
        "cat \
          <( cat ${1} | jq -C  \
            .resources.${2}.methods.{})
        " \
    --bind "tab:replace-query" \
    --bind "ctrl-space:execute% cat ${1}  | jq --sort-keys -C .resources.${2}.methods.{} | less -R > /dev/tty 2>&1 %" \
    --bind "change:top" \
    --layout=reverse-list \
    --prompt="~ " \
    --pointer="~ " \
    --header="# Fuzzy Object Explorer #" \
    --color=dark \
    --black 
}

fuzzExSimpleParameters() {
    sed 's/ /\n/g' \
    | fzf \
    --bind "tab:replace-query" \
    --bind "change:top" \
    --layout=reverse-list \
    --bind "ctrl-r:execute% source ${gapicParamWiz} && rmParams ${tempPar} {} ${gapicSavedPar} %+preview(cat <(echo -e \# Removed {}))" \
    --preview "cat ${schemaFile} | jq --sort-keys -C  .resources.${1}.methods.${2}.parameters.${3}" \
    --prompt="~ " \
    --pointer="~ " \
    --header="# Fuzzy Object Explorer #" \
    --color=dark \
    --black \
}

fuzzExOptParameters() {
    sed 's/ /\n/g' \
    | fzf \
    --bind "tab:replace-query" \
    --bind "change:top" \
    --layout=reverse-list \
    --preview "cat ${schemaFile} | jq --sort-keys -C  .resources.${1}.methods.${2}.parameters.${3}" \
    --prompt="~ " \
    --pointer="~ " \
    --header="# Fuzzy Object Explorer #" \
    --color=dark \
    --black \
}

fuzzExAllParameters() {
    sed 's/ /\n/g' \
    | fzf \
    --bind "tab:replace-query" \
    --bind "change:top" \
    --layout=reverse-list \
    --preview "cat ${schemaFile} | jq --sort-keys -C  \".resources.${1}.methods.${2}.parameters\"" \
    --prompt="~ " \
    --pointer="~ " \
    --header="# Fuzzy Object Explorer #" \
    --color=dark \
    --black \
}

fuzzExPromptParameters() {
    sed 's/ /\n/g' \
    | fzf \
    --bind "tab:replace-query" \
    --bind "change:top" \
    --layout=reverse-list \
    --preview "cat <(echo ${1} | sed 's/ /\n/g')" \
    --prompt="~ " \
    --pointer="~ " \
    --header="# Fuzzy Object Explorer #" \
    --color=dark \
    --black \
  

}

