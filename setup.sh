function relink() {
  if [[ -h "$1" ]]; then
    echo "Relinking $1"
    # Symbolic link? Then recreate.
    rm "$1"
    ln -sn "$2" "$1"
  elif [[ ! -e "$1" ]]; then
    echo "Linking $1"
    ln -sn "$2" "$1"
  else
    echo "$1 exists as a real file, skipping."
  fi
}

cd ~
mkdir -p .ssh
relink bin                ~/.dotfiles/bin
relink .ackrc             ~/.dotfiles/ackrc
relink .bash_profile      ~/.dotfiles/bashrc
relink .bashrc            ~/.dotfiles/bashrc
relink .gdbinit           ~/.dotfiles/gdbinit
relink .gemrc             ~/.dotfiles/gemrc
relink .gitconfig         ~/.dotfiles/gitconfig
relink .gitignore_global  ~/.dotfiles/gitignore_global
relink .gvimrc            ~/.dotfiles/vim/gvimrc
relink .hushlogin         ~/.dotfiles/hushlogin
relink .irbrc             ~/.dotfiles/irbrc
relink .screenrc          ~/.dotfiles/screenrc
relink .ssh/config        ~/.dotfiles/ssh/config
relink .tmux.conf         ~/.dotfiles/tmux
relink .vim               ~/.dotfiles/vim
relink .vimrc             ~/.dotfiles/vim/vimrc
relink .zshrc             ~/.dotfiles/zshrc
relink .powconfig         ~/.dotfiles/powconfig

cd -

