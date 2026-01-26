ln -i bashrc        ~/.bashrc
ln -i conkyrc       ~/.conkyrc
ln -i dcinit        ~/.dcinit
ln -i gdbinit       ~/.gdbinit
ln -i hexerrc       ~/.hexerrc
ln -i scrc          ~/.scrc
ln -i tmux.conf     ~/.tmux.conf
ln -i vimrc         ~/.vimrc
ln -i Xdefaults     ~/.Xdefaults
ln -i xinitrc       ~/.xinitrc
ln -i zathurarc     ~/.config/zathura/zathurarc

cp -ri mc ~/.config
cp -ri ncmpcpp ~/.ncmpcpp
cp -ri vim ~/.vim

mkdir -p ~/.local/share/mime/packages
ln -i local-mp.xml  ~/.local/share/mime/packages
