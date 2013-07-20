#32-bit:
#cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -

#64-bit:
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

wget -O ~/bin/dropbox.py "https://www.dropbox.com/download?dl=packages/dropbox.py"
chmod 777 ~/bin/dropbox.py

~/.dropbox-dist/dropboxd &

#~/bin/dropbox.py exclude add ~/Dropbox/Android ~/Dropbox/Camera\ Uploads ~/Dropbox/Chrome ~/Dropbox/ebooks ~/Dropbox/evernote ~/Dropbox/Images ~/Dropbox/Mangas ~/Dropbox/Musique ~/Dropbox/Notes ~/Dropbox/Papiers ~/Dropbox/Photos ~/Dropbox/ppt ~/Dropbox/pss ~/Dropbox/Public
