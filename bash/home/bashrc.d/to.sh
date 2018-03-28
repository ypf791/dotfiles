#!/bin/bash

to() {
	if [ ! -x ~/.bashrc.d/src/to_int ]; then
		echo "to: missing internal binary" >&2
		return 255
	fi

	cd_path=$(~/.bashrc.d/src/to_int "$@")
	if [ 0 -eq $? -a -n "${cd_path}" ]; then
		cd ${cd_path}
	fi
	return $?
}

