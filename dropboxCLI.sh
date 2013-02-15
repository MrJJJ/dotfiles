#32-bit:
#cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -

#64-bit:
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

#Ensuite, lancez le démon Dropbox à partir du nouveau fichier .dropbox-dist.
~/.dropbox-dist/dropboxd
