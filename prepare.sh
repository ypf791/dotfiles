#!/bin/bash

UseSSHKey=
SSHKeyName=id_rsa

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
apt install -y ctags tmux silversearcher-ag jq xsel rake

if [ "$UseSSHKey" ]; then
	Echo "ssh key"

	# generate key if not exists
	if [ ! -f ~/.ssh/$SSHKeyName ]; then
		ssh-keygen -t rsa -f ~/.ssh/$SSHKeyName -P "echo -n $RANDOM | md5sum"
	else
		echo "~/.ssh/$SSHKeyName already exists"
	fi

	# show public key for user to copy, registering it to their Git server
	if [ -f ~/.ssh/$SSHKeyName ]; then
		if xsel < ~/.ssh/$SSHKeyName.pub; then
			echo "the public key has been copied to your clipboard."
			
		else
			echo
			cat ~/.ssh/$SSHKeyName.pub;
			echo
			echo "please copy the public key above, and"
		fi
		echo "register it to your Github account if needed."
		read -p "press any key to continue..." ___key
		unset ___key
	else
		echo "ssh key not found!!"
		echo "does ssh-keygen failed?"
	fi

fi

Echo "dependent project"

mkdir -p ext_proj; cd ext_proj
for proj in `cat ../prepare.ext.list`; do
	proj_name=${proj##*/}
	proj_name=${proj_name##*:}
	proj_path=https://${proj%:*}.git
	[ -d $proj_name ] && echo "$proj_name already exists" || git clone $proj_path $proj_name
done
cd ..
