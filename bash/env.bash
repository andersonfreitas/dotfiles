export CLICOLOR=1
#export EDITOR="mate -w"
#export EDITOR="vim"
export EDITOR="mvim -f"
# export EDITOR="subl -w"
#export EDITOR='mvim -f -c "au VimLeave * \!open -a iTerm"'

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/usr/local/share/python:$PATH

# Node - NPM binaries
export PATH=$PATH:/usr/local/share/npm/bin

export HISTSIZE=100000
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}"; echo -ne "\007"'
export PAGER='less' # less is more (than more)
export LESSEDIT='mate -l %lm %f' # open in textmate from less
export LESS='-XFRf' # don't clear screen on exit, show colors

export NODE_PATH=/usr/local/lib/node_modules

export MAKEFLAGS=-j2 # faster builds, where 2 is the number of cores

# coreutils
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export GOPATH=/usr/local/opt/go

export PATH=$PATH:$GOPATH/bin

# I don't like this new behavior in 1.7.10
export GIT_MERGE_AUTOEDIT=no

# se for pra usar o pyenv
#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# VI mode in Bash
set -o vi

export GZIP=-9

# Added by Canopy installer on 2014-03-16
# VIRTUAL_ENV_DISABLE_PROMPT can be set to '' to make bashprompt show that Canopy is active, otherwise 1
VIRTUAL_ENV_DISABLE_PROMPT=1 source /Users/andersonfreitas/Library/Enthought/Canopy_64bit/User/bin/activate


export WM5_PATH=~/Development/WildMagic5


# Docker
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/andersonfreitas/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1


# Android
export NDKROOT=~/Development/android/ndk
export ANDROID_ROOT=~/Development/android/sdk
export PATH=$PATH:$ANDROID_ROOT/tools
export PATH=$PATH:$ANDROID_ROOT/platform-tools
