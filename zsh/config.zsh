# VIM mode!!
function zle-line-init zle-keymap-select {
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

bindkey -v

function vi_mode_prompt_info() {
  # echo "${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
  echo "${${KEYMAP/vicmd/[N]}/(main|viins)/[I]}"
}

# External editor for command line editing (ESC-v)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

bindkey "\e[3~" delete-char # Del
bindkey '^R' history-incremental-search-backward
bindkey -M viins "^A" beginning-of-line
bindkey -M viins "^E" end-of-line

autoload -U colors
colors
setopt prompt_subst

setopt autocd
setopt rmstarwait

# Prompt
local smiley="%(?,→%{$reset_color%},%{$fg[red]%}☹%{$reset_color%})"

PROMPT='
%~
${smiley} %{$reset_color%}'

RPROMPT='$(vi_mode_prompt_info) $(~/.rvm/bin/rvm-prompt)$(~/bin/git-cwd-info.rb) [%*]'

function rbenv_prompt_info() {
  local ruby_version
  ruby_version=$(rbenv version 2> /dev/null) || return
  echo "‹$ruby_version" | sed 's/[ \t].*$/›/'
}
#alias rvm-prompt=rbenv_prompt_info
#alias rvm_prompt_info=rbenv_prompt_info

#RPROMPT='$(vi_mode_prompt_info) $(rbenv_prompt_info)$(~/bin/git-cwd-info.rb)'

# Show completion on first TAB
setopt menucomplete

# completing PIDs with menu selection
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always


zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"



# always use the menu
zstyle ':completion:*' menu select=0 select=long-list

# Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# expand ... automatically to ../..
rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

#############################
# Other Options

# setopt PRINT_EXIT_VALUE

setopt CORRECT
setopt CORRECTALL

setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY # write history only when closing
setopt EXTENDED_HISTORY # add more info

# Other tabbing options
# setopt NO_AUTO_MENU
# setopt BASH_AUTO_LIST

#############################
# Variables

# Quote pasted URLs
autoload url-quote-magic
zle -N self-insert url-quote-magic

HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=10000

#TIMEFMT='%J: %E real'
REPORTTIME=10 # Show elapsed time if command took more than X seconds
LISTMAX=0 # ask to complete if top of list would scroll off screen

# Load completions for Ruby, Git, etc.
autoload compinit
compinit

# Make CTRL-W delete after other chars, not just spaces
WORDCHARS=${WORDCHARS//[&=\/;\!#%\{]}

# TETRIS
autoload -U tetris
zle -N tetris
bindkey tetris tetris

#setopt auto_cd
#cdpath=($HOME/thoughtbot $HOME/src)


