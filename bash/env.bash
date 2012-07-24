export CLICOLOR=1
#export EDITOR="mate -w"
#export EDITOR="vim"
#export EDITOR="mvim -f"
export EDITOR="subl -w"
export GIT_EDITOR="vim"
#export EDITOR='mvim -f -c "au VimLeave * \!open -a iTerm"'

export PATH=~/bin:~/bin/araxis-utils:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:/Developer/usr/bin:$PATH
export PATH=$PATH
export HISTSIZE=10000
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}"; echo -ne "\007"'
export PAGER='less' # less is more (than more)
export LESSEDIT='mate -l %lm %f' # open in textmate from less
export LESS='-XFRf' # don't clear screen on exit, show colors

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"