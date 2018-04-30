#!/bin/bash

to() {
	local to_int=~/.bashrc.d/src/to_int
	if [ ! -x ${to_int} ]; then
		echo "to: missing internal binary" >&2
		return 255
	fi

	if [ "${COMP_WORDS+isset}" ]; then
		local cur="${COMP_WORDS[COMP_CWORD]}"
		if [ 1 -lt ${COMP_CWORD} ]; then
			local comp_args=${COMP_WORDS[@]:1:COMP_CWORD-1}
		fi
		COMPREPLY=( $(compgen -W "$(${to_int} --complete "${comp_args}")" -- ${cur}) )
		return 0
	fi

	local OPTIND= OPTARG= opt=
	while getopts "dh" opt; do
		case ${opt} in
		d)	_oo_VERBOSE=on
			;;
		h)	${to_int} --help; return 0
			;;
		?)	${to_int} --help; return 1
			;;
		esac
	done

	shift $((OPTIND-1))

	local cd_path=$(env ${_oo_VERBOSE:+_oo_VERBOSE=on} ${to_int} "$@")
	if [ 0 -eq $? -a -n "${cd_path}" ]; then
		cd ${cd_path}
	fi
	return $?
}

complete -F to to
