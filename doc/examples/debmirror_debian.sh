#!/bin/bash

allowed_user=m

if [ "$USER" != "$allowed_user" ]; then
    echo "Abort, wrong user: $USER"
    exit 1
fi

# sourcehost: choose a mirror in your proximity!
HOST=ftp.us.debian.org

# destination directory
DEST=/srv/dmirror/debian

# Debian version(s) to mirror
#   DIST=buster,buster-updates,buster-backports
DIST=buster,buster-updates
#   DIST=buster

# Debian sections
# SECTIONS=main,contrib,non-free,main/debian-installer
SECTIONS=main,contrib,non-free

# architecture
ARCH=amd64

# verbose as needed
VERBOSE=-v

debmirror ${DEST} \
 --ignore-small-errors \
 --nosource \
 --host=${HOST} \
 --root=/debian \
 --dist=${DIST} \
 --section=${SECTIONS} \
 --i18n \
 --arch=${ARCH} \
 --passive --cleanup \
 ${VERBOSE}

#   ***
