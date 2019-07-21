#!/bin/sh

# update user keyring:
gpg --no-default-keyring --keyring trustedkeys.gpg --import /usr/share/keyrings/debian-archive-keyring.gpg

# verify user keyring:
gpg --list-keys --keyring trustedkeys.gpg
