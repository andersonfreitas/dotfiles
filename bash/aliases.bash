# Command Enhancements

# Colored grep
alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'

# https://github.com/paulhammond/webkit2png/
alias ss='/usr/bin/python ~/bin/webkit2png/webkit2png --width=1024 --thumb --scale=1'

# Utility
alias reload='source ~/.dotfiles/bash/{aliases.bash,env.bash}'
alias ea="$EDITOR ~/.dotfiles/bash/aliases.bash && reload" # Edit aliases
alias ee="$EDITOR ~/.dotfiles/bash/env.bash && reload"
alias ec="$EDITOR ~/.dotfiles/ && reload"

# Common -- Some are from Damian Conway
alias a='ls -A' # -A all except literal . ..
alias la="ls -A -l -G"
#alias cdd='cd -'  # goto last dir cd'ed from
alias cl='clear; l'
function cdc() {
    cd $1; ls
}
alias cls='clear; ls'
alias h='history'
alias l.='ls -d .[^.]*'
alias ll.='ls -l -d .[^.]*'
alias l='ls -lhGt'  # -l long listing, most recent first
                    # -G color
alias lh="ls -lh"
alias ll='ls -lhG'  # -l long listing, human readable, no group info
alias lt='ls -lt' # sort with recently modified first
alias md='mkdir -p'
alias ..='cd ..'   # up one dir

function mkcd() {
    mkdir -p "$1"
    cd "$1"
}

function dec() {
	jad -s java $1
	mate `basename $1 .class`.java
}

function decdir() {
	for a in $(find . -name '*.class')
	do
		jad -s java -d `dirname $a` $a
	done
}

function jgrep() {
	fgrep -i "$*" `find . -name '*.java'`
}


alias e='exit'
alias k9="killall -9"
function killnamed () {
    ps ax | grep $1 | cut -d ' ' -f 2 | xargs kill
}

function zipr() {
  zip -r $1.zip $1
}

function zipd() {
	zip -r $1-`date "+%Y-%m-%d"`.zip $1
}

function zipdt() {
	zip -x \*.log tmp  -r $1-`date "+%Y.%m.%d-%H-%M-%S"`.zip $1
}

# Finder
alias o='open . &'

# Processes
alias tu='top -o cpu' # cpu
alias tm='top -o vsize' # memory
alias top=htop
alias tu='htop --sort-key PERCENT_CPU' # cpu
alias tm='htop --sort-key PERCENT_MEM' # memory



alias orig-remove="find . -name '*.orig' -exec rm -rf {} \;"

# Git
#alias ungit="find . -name '.git' -exec rm -rf {} \;"
alias gi='git add -i'
alias gc='git commit -v'
alias g.='git add .'
alias gca='git commit -v -a'
# Commit pending changes and quote all args as message
function gg() {
    git commit -v -a -m "$*"
}
alias gd='git diff --word-diff'
alias gdm='git diff --word-diff master'
alias gs='git status'
alias gw='git whatchanged'

# git pull push origin current
alias gppoc="BRANCH=`git branch --no-color 2>/dev/null | grep '*' | awk '{ print $2 }'` git pull origin $BRANCH && git push origin $BRANCH"
alias gppom="git pull origin master && git push origin master"

function gdiff() {
	find . -name "*$**" -exec git diff HEAD -- {} +;
}

# Undo a `git push`
alias undopush="git push -f origin HEAD^:master"

# from http://github.com/revans/bash-it/blob/master/plugins/git.plugins.bash
function git_remove_missing_files() {
  git ls-files -d -z | xargs -0 git update-index --remove
}

alias g='git'
alias eg='mate .git/config'

# Quickly clobber a file and checkout
function grf() {
  rm $1
  git checkout $1
}

## Rails
alias r=rails

alias rl='less log/development.log'

alias rrails='touch tmp/restart.txt'

# From http://github.com/suztomo/dotfiles
function rmf(){
    for file in $*
    do
        __rm_single_file $file
    done
}

function __rm_single_file(){
    if ! [ -d ~/.Trash/ ]
    then
        command /bin/mkdir ~/.Trash
    fi

    if ! [ $# -eq 1 ]
    then
        echo "__rm_single_file: 1 argument required but $# passed."
        exit
    fi

    if [ -e $1 ]
    then
        BASENAME=`basename $1`
        NAME=$BASENAME
        COUNT=0
        while [ -e ~/.Trash/$NAME ]
        do
            COUNT=$(($COUNT+1))
            NAME="$BASENAME.$COUNT"
        done

        command /bin/mv $1 ~/.Trash/$NAME
    else
        echo "No such file or directory: $file"
    fi
}

function win() {
  osascript 2>/dev/null <<EOF
    tell application "System Events"
      tell process "Terminal" to keystroke "n" using command down
    end
    tell application "Terminal"
      activate
      do script with command "cd \"$PWD\"; $*" in window 1
    end tell
EOF
}

# http://github.com/revans/bash-it/blob/master/plugins/osx.plugin.bash
function tab() {
  osascript 2>/dev/null <<EOF
    tell application "System Events"
      tell process "Terminal" to keystroke "t" using command down
    end
    tell application "Terminal"
      activate
      do script with command "cd \"$PWD\"; $*" in window 1
    end tell
EOF
}

# network utils iftop
alias iftop='sudo iftop -i en1'
alias ntop=iftop
alias wtop=iftop
alias tcptrack=iftop

# Utility for testing upload throughtput
function ssh_network_throughtput() {
	host=$1
	yes | pv | ssh $host "cat > /dev/null"
}

alias count_java='wc -l `find . -name \*.java -print`'
alias count_c='wc -l `find . -name \*.c -print`'

alias rebuild-open-with='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

# 19) RESUME SCP OF A BIG FILE
#
# rsync –partial –progress –rsh=ssh $file_source $user@$host:$destination_file
#
# It can resume a failed secure copy ( usefull when you transfer big files like db dumps through vpn ) using rsync.
# It requires rsync installed in both hosts.
# rsync –partial –progress –rsh=ssh $file_source $user@$host:$destination_file local -> remote
# or
# rsync –partial –progress –rsh=ssh $user@$host:$remote_file $destination_file remote -> local

# 23) THROTTLE BANDWIDTH WITH CSTREAM
#
# tar -cj /backup | cstream -t 777k | ssh host 'tar -xj -C /backup'
#
# this bzips a folder and transfers it over the network to “host” at 777k bit/s.
# cstream can do a lot more, have a look http://www.cons.org/cracauer/cstream.html#usage
# for example:
# echo w00t, i’m 733+ | cstream -b1 -t2

alias noidle="pmset noidle"

###
# Upload a file using ditto and curl
# ditto -cj build/Debug-iphonesimulator/YourApp.app - | curl -F "email=you@somewhere.com" -F "file=@-" http://www.pieceable.com/view/publish
#

# Random password generator
# while true; do cat /dev/urandom | hexdump | tr -cd "a-z" | tr "a-z" "A-Z" | head -c3; echo ""; done;



# → sandbox-exec -p '(version 1) (allow default) (deny network*)' /bin/bash

# https://github.com/rtomayko/bcat

bman () {
    gunzip < `man -w $@` | groff -Thtml -man | bcat
}

manmate () {
  MANWIDTH=80 MANPAGER='col -bx' man $@ | mate
}

alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

alias flush="dscacheutil -flushcache" # Flush DNS cache
alias flushcache='dscacheutil -flushcache'

alias ql="qlmanage -p 2>/dev/null" # preview a file using QuickLook


alias traceroute=mtr

# The files are read in this order:
#   /etc/profile
#   ~/.bash_profile
#   ~/.bash_login (if .bash_profile does not exist)
#   ~/.profile    (if .bash_profile does not exist)
#   .bashrc     (when starting bash from the command line - reads from pwd)
#   ~/.MacOSX/environment.plist
#  or
#   /etc/paths
#   /etc/paths.d/
#
function show_path () {
	echo $PATH | tr ':' '\n' | nl
}

function f() {
  find * -name $1
}

# Exemplos de find
# 	Busca por string em apenas alguns arquivos
# 	find . | grep en.yml | xargs fgrep "example"

# replacement netstat cmd to find ports used by apps on OS X
alias netstat_osx="sudo lsof -i -P"
alias ports="sudo lsof -iTCP -sTCP:LISTEN -P"

# chflags nohidden ~/Library/
alias show_folder="chflags nohidden $1"
alias hide_folder="chflags hidden $1"


# Create a file called ~/.s3key with the following lines:
#   line #1: YOUR AWS ACCESS KEY
#   line #2: YOUR AWS SECRET KEY
#
# usage:
#   s3put mybackup.tgz bucket/name
#
function s3put() {
	local aws_access_key=`awk 'NR==1' ~/.s3key`
	local aws_secret_key=`awk 'NR==2' ~/.s3key`
	local date=`date '+%a, %d %h %Y %T %z'`
	local contentmd5=`openssl dgst -md5 -binary $1 | openssl enc -e -base64`
	local signed=`printf "PUT\n$contentmd5\napplication/octec-stream\n$date\n/$2/$1" | openssl dgst -sha1 -hmac "$aws_secret_key" -binary | openssl base64`

	curl -T $1 \
		--dump-header /dev/null \
		--header "Date: $date" \
		--header "Authorization: AWS $aws_access_key:$signed" \
		--header "Content-Type: application/octec-stream" \
		--header "Content-MD5: $contentmd5" \
		http://s3.amazonaws.com/$2/$1
}

# Vim Utils
# addVimPlugin git://github.com/vim-scripts/L9.git L9
function addVim() {
  cd ~/bin/dotfiles
  git submodule add $1 vim/bundle/$2
  git submodule init && git submodule update
  cd -
}

# add-ssh-key user@host.com
function add-ssh-key() {
  cat ~/.ssh/id_rsa.pub | ssh $1 "cat >> .ssh/authorized_keys"
}

# from https://github.com/mathiasbynens/dotfiles/blob/master/.functions
# Test if HTTP compression (RFC 2616 + SDCH) is enabled for a given URL.
# Send a fake UA string for sites that sniff it instead of using the Accept-Encoding header. (Looking at you, ajax.googleapis.com!)
httpcompression() {
  encoding="$(curl -LIs -H 'User-Agent: Mozilla/5 Gecko' -H 'Accept-Encoding: gzip,deflate,compress,sdch' "$1" | grep '^Content-Encoding:')" && echo "$1 is encoded using ${encoding#* }" || echo "$1 is not using any encoding"
}

# All the dig info
digga() {
  dig +nocmd "$1" any +multiline +noall +answer
}

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a --color=never -o -E \"Host\: .*|GET \/.*\""

# Usage wget-site http://localhost/
function wget-site() {
  wget -r -l0 -np -k -e robots=off $1
}

# ERB to HAML
# gem install hpricot ruby_parser
function erb2haml() {
  for i in `find $1 -name '*.erb'` ; do html2haml -e $i ${i%erb}haml ; rm $i ; done
}

##################
#extract files eg: ex tarball.tar#
##################
# from: http://dotfiles.org/~woodworker/.bashrc
function ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       rar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function hablar() {
  curl -s -A "User-Agent:Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.38 Safari/535.11" "http://translate.google.com/translate_tts?tl=es&q=$(echo $* | sed 's#[ , ]#\+#g')" > ~/Desktop/español/"$*.mp3"
  afplay ~/Desktop/español/"$*.mp3"
}

alias bclc='echo "10 i 2 o $(date +"%H%M"|cut -b 1,2,3,4 --output-delimiter=" ") f"|dc|tac|xargs printf "%04d\n"|tr "01" ".*"'

#spec_end_to_end='`(time -p script/test) 2>&1 1>/dev/null | grep real | cut -d " " -f 2`'

# Slow down HackerNews
# sudo ipfw add 100 pipe 666 ip from news.ycombinator.com to any
# sudo ipfw pipe 666 config bw 3KB/s delay 1000ms

# Ultimate Nmap Scan
# http://richrines.com/post/10886870567/ultimate-nmap-scan
function nmap-ultimate() {
  sudo nmap —spoof-mac Cisco --data-length 9 -f -v -n -O -sS -sV -PN $1
}

alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop"

