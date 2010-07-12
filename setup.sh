#ln -s $HOME/dotfiles/.gitignore $HOME/.gitignore
ln -s ~/bin/dotfiles/ssh/config ~/.ssh/config
ln -s ~/bin/dotfiles/bashrc ~/.bashrc
ln -s ~/bin/dotfiles/bashrc ~/.bash_profile

git config --global user.name "Anderson Freitas"
git config --global user.email "###@###.com"
git config --global alias.oneline "log --pretty=oneline"
git config --global alias.co "checkout"
git config --global alias.ci "commit"
git config --global alias.br "branch"
git config --global alias.la "log --pretty=\"format:%ad %h (%an): %s\" --date=short"
#git config --global core.excludesfile "~/.gitignore"
