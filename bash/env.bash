export CLICOLOR=1
#export EDITOR="mate -w"
#export EDITOR="vim"
#export EDITOR="mvim -f"
export EDITOR="subl -w"
export GIT_EDITOR="vim"
#export EDITOR='mvim -f -c "au VimLeave * \!open -a iTerm"'

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH
# export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export PATH="$(brew --repository)/Library/LinkedKegs/coreutils/libexec/gnubin:$PATH"

export HISTSIZE=10000
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}"; echo -ne "\007"'
export PAGER='less' # less is more (than more)
export LESSEDIT='mate -l %lm %f' # open in textmate from less
export LESS='-XFRf' # don't clear screen on exit, show colors

export NODE_PATH=/usr/local/lib/node_modules

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
