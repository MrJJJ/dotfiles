#git init
#git add *
#git commit -m "Message log"
#git remote add origin git@github.com:tejr/dotfiles.git
#git push -u origin master



files="bashrc tmux.conf vimrc zshrc"

mkdir -p ~/.dotfiles
for f in $files; do
	mv ~/.$f ~/.dotfiles
	ln -s ~/dotfiles/$f ~/.$f
done
