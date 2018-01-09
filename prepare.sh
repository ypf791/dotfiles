#!/bin/bash

_show_help() {
	cat >&2 << EOF
USAGE: `basename ${BASH_SOURCE[0]}` [-h] [-k]
OPTIONS
	-h	show this message
	-k	confirm to generate ssh-key ~/.ssh/id_rsa[.pub] with empty phrase
EOF
}

UseSSHKey=
OPTIND= OPTARG= opt=
while getopts "hk" opt; do
	case $opt in
	h)	_show_help; exit
		;;
	k)	UseSSHKey=on
		;;
	?)	_show_help; exit 1
		;;
	esac
done

shift $((OPTIND-1))

Echo() {
	echo; echo "===== $@ ====="
}

InstallPkgs="/tmp/install_pkgs.sh"

install_pkgs_brew() {
}

install_pkgs_yum() {
	# TODO
	# Once I have to setup a system using yum, I may complete this.
}

install_pkgs_apt() {
	wget https://raw.githubusercontent.com/ypf791/dotfiles/master/prepare_pkgs/apt.sh -O "$InstallPkgs"
	sh "$InstallPkgs"
	rm "$InstallPkgs"
}

case `uname -s` in
Darwin)
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	install_pkgs_brew
	;;
Linux)
	if command -v yum; then
		install_pkgs_yum
	elif command -v apt-get; then
		install_pkgs_apt
	else
		echo "unrecognized package manager" >&2
		exit 1
	fi
	;;
esac

if [ "$UseSSHKey" ]; then
	Echo "ssh key"

	# generate key if not exists
	if [ ! -f ~/.ssh/id_rsa ]; then
		ssh-keygen -t rsa -f ~/.ssh/id_rsa -P ""
	else
		echo "~/.ssh/id_rsa already exists"
	fi

	# show public key for user to copy, registering it to their Git server
	if [ -f ~/.ssh/id_rsa ]; then
		if xsel -b < ~/.ssh/id_rsa.pub; then
			echo "the public key has been copied to your clipboard."
			
		else
			echo
			cat ~/.ssh/id_rsa.pub;
			echo
			echo "please copy the public key above, and"
		fi
		echo "register it to your Github account to go on cloning projects"
		read -p "Are you ready to go on? (Y/n)" key
		if [ "xn" = "x$key" -o "xN" = "x$key" ]; then
			exit 0
		fi
	else
		echo "ssh key not found!!"
		echo "does ssh-keygen failed?"
		exit 1
	fi
fi

Echo "dotfile project"

ssh-keyscan -H github.com >> ~/.ssh/known_hosts

if [ -z "$UseSSHKey" ]; then
	git clone https://github.com/ypf791/dotfiles.git
else
	git clone git@github.com:ypf791/dotfiles.git
fi

