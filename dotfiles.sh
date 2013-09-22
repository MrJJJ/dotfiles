#git init
#git add *
#git commit -m "Message log"
#git remote add origin git@github.com:tejr/dotfiles.git
#git push -u origin master


files="tmux.conf vimrc zshrc"

mkdir -p ~/.dotfiles
for f in $files; do
	mv ~/.$f ~/.dotfiles
	ln -s ~/dotfiles/$f ~/.$f
done

#Install NeoBundle
if [ ! -d ~/.vim/bundle/neobundle.vim ] ; then
	mkdir -p ~/.vim/bundle
	git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi
