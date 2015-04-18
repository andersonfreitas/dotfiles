#zmodload zsh/zprof
#time zsh -i -c "print -n"
source ~/.dotfiles/zsh/env.zsh
source ~/.dotfiles/zsh/aliases.zsh
source ~/.dotfiles/zsh/save_current_dir.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/andersonfreitas/Library/Enthought/Canopy_64bit/User/bin/aws_zsh_completer.sh

source `brew --prefix`/etc/profile.d/z.sh

source ~/.dotfiles/zsh/config.zsh

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

