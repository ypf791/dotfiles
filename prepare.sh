#!/bin/bash

_show_help() {
	cat >&2 << EOF
USAGE: `basename $0` [-h] [-k]
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

RepoList="main universe restricted multiverse"

Echo "check all repositories available"

# check add-apt-repository can execute
type add-apt-repository >/dev/null 2>&1 || apt-get install -y software-properties-common
for repo in $RepoList; do
	add-apt-repository $repo
done

Echo "update and upgrade"

apt update
apt -y upgrade

Echo "install necessary packages"

# install necessary things
apt install -y git openssh-server telnetd nfs-kernel-server samba cifs-utils system-config-samba python python3 vim apache2

Echo "install convenient packages"

# install good things
# id-utils for gj, a vim's plugin
apt install -y ctags tmux silversearcher-ag jq xsel rake id-utils

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

cd
if [ -z "$UseSSHKey" ]; then
	git clone https://github.com/ypf791/dotfiles.git
else
	git clone git@github.com:ypf791/dotfiles.git
fi

