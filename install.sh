#!/bin/bash

# ----------------------------------------------------
# This is simple script to install ZSH configuration.
# ----------------------------------------------------
# AUTHOR: bosha
#   SITE: http://the-bosha.ru
# ----------------------------------------------------

promptyn () {
    if [ -z "$1" ]; then
        1="Confirm?"
    fi
    while true; do
        read -p "$1 (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            "" ) return 0;;
            * ) echo "Please answer yes or no (y/n).";;
        esac
    done
}

if ! which git &> /dev/null; then
    echo "Git not found in \$PATH"
    exit 1
fi

if [[ -d "$HOME"/.zsh ]]; then
    if promptyn "Directory "$HOME"/.zsh/ exists. Wanna continue anyway?"; then
        if mv "$HOME"/.zsh/ "$HOME"/.zsh_old/ &> /dev/null ; then
            echo "Directory renamed to .zsh_old/"
        else
            echo "Something goes wrong while moving directory. Problem with permissions?"
            exit 1
        fi
    else
        exit
    fi
fi
if [[ -f "$HOME"/.zshrc ]]; then
    if promptyn "Directory "$HOME"/.zshrc exists. Wanna continue anyway?"; then
        if mv "$HOME"/.zshrc "$HOME"/.zshrc_old &> /dev/null; then
            echo "File renamed to .zshrc_old"
        else
            echo "Something goes wrong while moving directory. Problem with permissions?"
            exit 1
        fi
    else
        exit
    fi
fi

if [[ -d "/tmp/zshrc" ]]; then
    rm -rf /tmp/zshrc &> /dev/null
fi

cd /tmp
echo "Cloning ZSH configuration.."
git clone https://github.com/Viperoo/zshrc.git &> /dev/null

echo "Applying configuration"
mv zshrc/.zshrc "$HOME"/ &> /dev/null
mv zshrc/.zsh "$HOME"/ &> /dev/null

echo "Cloning zsh-git-prompt..."
mkdir -p "$HOME"/.zsh/plugins/zsh-git-prompt
git clone https://github.com/olivierverdier/zsh-git-prompt.git "$HOME"/.zsh/plugins/zsh-git-prompt/ &> /dev/null

echo "Cloning zsh-syntax-highlighting..."
mkdir -p "$HOME"/.zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME"/.zsh/plugins/zsh-syntax-highlighting/ &> /dev/null

echo "Geting ssh-agent..."
mkdir -p "$HOME"/.zsh/plugins/ssh-agent
wget -O "$HOME"/.zsh/plugins/ssh-agent/ssh-agent.plugin.zsh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/ssh-agent/ssh-agent.plugin.zsh &> /dev/null

echo "Cleaning up.."
rm -rf /tmp/zshrc &> /dev/null

echo "New configuration installed. You will see changes after next login."
