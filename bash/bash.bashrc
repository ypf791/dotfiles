# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='${debian_chroot:+($debian_chroot)}[\u@\h \A][$(printf "%2x" $?)][\w] $ '

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ] && [ ! -e "$HOME/.hushlogin" ] ; then
	case " $(groups) " in
	*\ admin\ *|*\ sudo\ *)
		if [ -x /usr/bin/sudo ]; then
			cat <<-EOF
			To run a command as administrator (user "root"), use "sudo <command>".
			See "man sudo_root" for details.

			EOF
		fi
	esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
		# check because c-n-f could've been removed in the meantime
		if [ -x /usr/lib/command-not-found ]; then
			/usr/lib/command-not-found -- "$1"
			return $?
		elif [ -x /usr/share/command-not-found/command-not-found ]; then
			/usr/share/command-not-found/command-not-found -- "$1"
			return $?
		else
			printf "%s: command not found\n" "$1" >&2
			return 127
		fi
	}
fi

# one may need to add customized path in PATH
# need to support globally
_oo_addpath() {
	while [ 0 -lt $# ]; do
		if path=`unset CDPATH && cd "$1" && pwd -P`; then
			if ! echo $PATH | grep -- "$path" >/dev/null 2>&1; then
				PATH=$PATH:$path
			fi
		else
			echo "_oo_addpath: ${1}: ignored invalid path" >&2
		fi
		shift
	done
}
