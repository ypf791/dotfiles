#!/bin/bash

to() {
	if [ ! -x ~/.bashrc.d/src/to_int ]; then
		echo "to: missing internal binary" >&2
		return 255
	fi

	if [ "${COMP_WORDS+isset}" ]; then
		local cur="${COMP_WORDS[COMP_CWORD]}"
		if [ 1 -lt ${COMP_CWORD} ]; then
			local comp_args=${COMP_WORDS[@]:1:COMP_CWORD-1}
		fi
		COMPREPLY=( $(compgen -W "$(~/.bashrc.d/src/to_int --complete "${comp_args}")" -- ${cur}) )
		return 0
	fi

	local cd_path=$(~/.bashrc.d/src/to_int "$@")
	if [ 0 -eq $? -a -n "${cd_path}" ]; then
		cd ${cd_path}
	fi
	return $?
}

complete -F to to
