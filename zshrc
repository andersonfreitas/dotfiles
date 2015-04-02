source ~/.dotfiles/zsh/env.zsh
source ~/.dotfiles/zsh/config.zsh
source ~/.dotfiles/zsh/aliases.zsh
source ~/.dotfiles/zsh/save_current_dir.zsh
source ~/.dotfiles/zsh/git-flow-completion.zsh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/local/share/python/aws_zsh_completer.sh

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

### Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"
#
