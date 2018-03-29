#!/bin/bash

to() {
	if [ ! -x ~/.bashrc.d/src/to_int ]; then
		echo "to: missing internal binary" >&2
		return 255
	fi

	if [ "${COMP_WORDS+isset}" ]; then
		local cur="${COMP_WORDS[COMP_CWORD]}"
		COMPREPLY=( $(compgen -W "$(~/.bashrc.d/src/to_int --complete "${COMP_LINE}")" -- ${cur}) )
		return 0
	fi

	cd_path=$(~/.bashrc.d/src/to_int "$@")
	if [ 0 -eq $? -a -n "${cd_path}" ]; then
		cd ${cd_path}
	fi
	return $?
}

complete -F to to
