#!/bin/bash

to() {
	local ret=0
	local isShowHelp=

	OPTIND= OPTARG= opt=
	while getopts "h" opt; do
		if [ "${OPTARG#-}" != "$OPTARG" ]; then
			echo "to: option requires an argument -- $opt" >&2
			opt=?
		fi
		case $opt in
			h)	isShowHelp=yes
				;;
			?)	isShowHelp=yes
				ret=1
				;;
		esac
	done

	shift $((OPTIND-1))

	if [ -n "$isShowHelp" ]; then
		cat >&2 << EOF
USAGE: to [-h] <back pattern>
OPTIONS
	-h	show this message
ARGUMENTS
	specify the back pattern of the destination directory.
EOF
		return $ret
	fi

	if [ -z "$1" ]; then
		echo "to: must specify back pattern" >&2
		return 1
	fi

	pattern=$1
	dir=`pwd`
	while [ "/" != "$dir" ]; do
		dir=`dirname $dir`
		base=`basename $dir`
		if echo "$base" | grep -q -- "^$pattern" >/dev/null 2>&1; then
			echo "back to ${dir}"
			cd $dir
			return 0
		fi
	done

	echo "to: not available back pattern" >&2
	return 2
}

