. ~/bin/dotfiles/bash/env.bash
. ~/bin/dotfiles/bash/config.bash
. ~/bin/dotfiles/bash/aliases.bash

# Add RVM to PATH for scripting
# PATH=$PATH:$HOME/.rvm/bin

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
