#!/usr/bin/env bash

function _rofi {
rofi -i -dmenu -p password: -width 30 -bw 2 -lines 10 -font 'M+ 1mn 12' -separator-style none -color-enabled
}

shopt -s nullglob globstar

typeit=0
if [[ $1 == "--type" ]]; then
	typeit=1
	shift
fi

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

password=$(printf '%s\n' "${password_files[@]}" | _rofi "$@")

[[ -n $password ]] || exit

if [[ $typeit -eq 0 ]]; then
	pass show -c "$password" 2>/dev/null
else
	pass show "$password" | { read -r pass; printf %s "$pass"; } |
		xdotool type --clearmodifiers --file -
fi
