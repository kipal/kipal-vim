#!/bin/bash

set -x

if [[ -n "$DOCKER_MACHINE_NAME" ]];
then
	su -c "$*"

	exit 0
fi


if [[ -z $USERNAME ]];
then
	echo "Please specify environment variable USERNAME"

	exit 1
fi

USERGROUP="whatever"
USERHOME=/home/whatever/

mkdir $USERHOME

# ensure $UID and $GID are set
if [[ -z $UID ]]; then
	echo "Please specify environment variable UID (eg: -e UID=\$(id -u))"

	exit 1
elif [[ -z $GID ]]; then
	echo "Please specify environment variable GID (eg: -e GID=\$(id -g))"

	exit 1
fi

# create user and group
if [ 0 -eq $(cat /etc/group | grep ":$GID:" | wc -l) ];
then
	groupadd -g "$GID" -r "$USERGROUP"
else
	USERGROUP=$(cat /etc/group | grep ":$GID:" | cut -d':' -f1)
fi

useradd -u "$UID" -r -g "$USERGROUP" -d "$USERHOME" -s /bin/bash "$USERNAME"

vim $*

chown -R $UID:$GID /root/vim-workspace


