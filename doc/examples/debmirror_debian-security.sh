#!/bin/bash

allowed_user=m

if [ "$USER" != "$allowed_user" ]; then
    echo "Abort, wrong user: $USER"
    exit 1
fi

# sourcehost: choose a mirror in your proximity!
HOST=security.debian.org

# destination directory
DEST=/srv/dmirror/debian-security

# Debian version(s) to mirror
DIST=buster/updates

# Debian sections
# SECTIONS=main,contrib,non-free,main/debian-installer
SECTIONS=main,contrib,non-free

# architecture
ARCH=amd64

# verbose as needed
VERBOSE=-v

debmirror ${DEST} \
 --method=rsync \
 --ignore-small-errors \
 --nosource \
 --host=${HOST} \
 --root=/debian-security \
 --dist=${DIST} \
 --section=${SECTIONS} \
 --i18n \
 --arch=${ARCH} \
 --passive --cleanup \
 ${VERBOSE}

#   ***
