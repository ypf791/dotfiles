#!/bin/bash

RepoList="main universe restricted multiverse ppa:deadsnakes/ppa"

Echo() {
	echo; echo "===== $@ ====="
}

Echo "check all repositories available"

# check add-apt-repository can execute
if ! type add-apt-repository >/dev/null 2>&1; then
	apt-get install -y software-properties-common
fi

for repo in $RepoList; do
	add-apt-repository $repo
done

Echo "update repos"

apt update
#apt -y upgrade

Echo "install necessary packages"

# install man pages
apt install -y          \
	manpages-dev        \
	manpages-posix-dev

# install necessary things
apt install -y          \
	net-tools           \
	git                 \
	g++                 \
	make                \
	openssh-server      \
	nfs-kernel-server   \
	samba               \
	cifs-utils          \
	python3             \
	vim                 \
	apache2

# Note: system-config-samba seems not exists on new Ubuntu
apt install -y \
	system-config-samba

Echo "install convenient packages"

# install good things
# Note: id-utils for gj, a vim's plugin
apt install -y          \
	ctags               \
	tmux                \
	silversearcher-ag   \
	jq                  \
	xsel                \
	rake                \
	id-utils            \
	tree

