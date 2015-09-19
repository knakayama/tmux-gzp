#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${CURRENT_DIR}/helpers.sh"

readonly token="$(get_token)"

[[ -z "$token" ]] && return 1

readonly cmd="$(get_cmd)"

$cmd $(curl \
  --silent \
  --header "Authorization: token $token" \
  "https://api.github.com/user/repos" \
  | jq --raw-output '.[] | .html_url' \
  | peco)

# Local Variables:
# mode: Shell-Script
# sh-indentation: 2
# indent-tabs-mode: nil
# sh-basic-offset: 2
# End:
# vim: ft=sh sw=2 ts=2 et
