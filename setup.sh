#ln -s $HOME/dotfiles/.gitignore $HOME/.gitignore
ln -s ~/bin/dotfiles/ssh/config ~/.ssh/config
ln -s ~/bin/dotfiles/bashrc ~/.bashrc
ln -s ~/bin/dotfiles/bashrc ~/.bash_profile

git config --global user.name "Anderson Freitas"
git config --global user.email "###@###.com"
#git config --global core.excludesfile "~/.gitignore"
