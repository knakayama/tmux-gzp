#!/usr/bin/env bash

get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value=$(tmux show-option -gqv "$option")

  if [[ -z $option_value ]]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

get_cmd() {
  case "$OSTYPE" in
    darwin*)
      echo "open"
      ;;
    linux*)
      echo "xdg-open"
      ;;
  esac
}

set_token() {
  local gh_user gh_token
  local prefix="$(uname -n)"

  gh_user="$(tmux \
    command-prompt -p "Enter github.com username:" \
    "set-environment -g TMUX_GZP_GH_USER %%" \
    && tmux show-environment -g TMUX_GZP_GH_USER \
    | cut -d= -f2)"

  gh_token="$(curl \
    --silent \
    --user "$gh_user" \
    --data "{\"scopes\":[\"repo\"],\"note\":\"tmux-gzp on $prefix\"}" \
    "https://api.github.com/authorizations" \
    | jq '.token')"

  cat <<EOT >"${HOME}/.config/tmux-gzp.json"
{
  "user": "$gh_user",
  "token": $gh_token
}
EOT
}

get_token() {
  local token

  if [[ ! -f "${HOME}/.config/tmux-gzp.json" ]]; then
    set_token
  fi

  cat "${HOME}/.config/tmux-gzp.json" \
    | jq --raw-output '.token'
}

# Local Variables:
# mode: Shell-Script
# sh-indentation: 2
# indent-tabs-mode: nil
# sh-basic-offset: 2
# End:
# vim: ft=sh sw=2 ts=2 et
