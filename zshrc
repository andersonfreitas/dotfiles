source ~/.dotfiles/zsh/env.zsh
source ~/.dotfiles/zsh/config.zsh
source ~/.dotfiles/zsh/aliases.zsh
source ~/.dotfiles/zsh/save_current_dir.zsh
source ~/.dotfiles/zsh/git-flow-completion.zsh

# Add RVM to PATH for scripting
# PATH=$PATH:$HOME/.rvm/

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if [ -f `brew --prefix`/etc/autojump ]; then
    . `brew --prefix`/etc/autojump
fi
