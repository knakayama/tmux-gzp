#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${CURRENT_DIR}/helpers.sh"

readonly token="$(get_token)"

[[ -z "$token" ]] && return 1

readonly page=1
readonly cmd="$(get_cmd)"

while true; do
  typeset -a starred_ary
  readonly starred="$(curl \
    --silent \
    --header "Authorization: token $token" \
    "https://api.github.com/user/starred?page=${page}&per_page=100" \
    | jq --raw-output '.[] | .html_url')"

  if [[ -n "$starred" ]]; then
    starred_ary=($starred_ary $starred)
    page=$(( page + 1 ))
  else
    echo $starred_ary
    break
  fi
done

$cmd $(echo ${starred_ary[@]} \
  | tr ' ' '\n' \
  | peco)

# Local Variables:
# mode: Shell-Script
# sh-indentation: 2
# indent-tabs-mode: nil
# sh-basic-offset: 2
# End:
# vim: ft=sh sw=2 ts=2 et
