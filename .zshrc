#!/bin/zsh
# vim set filetype=zsh

ZDOTDIR=~/.zsh

# Load configuration:
for rc in $ZDOTDIR/*.sh
do
    source $rc
done
unset rc

if [[ ( -f /usr/bin/alsi || -f /usr/local/bin/alsi )]]; then
    alsi
fi
