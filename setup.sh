#!/bin/bash

# copy for HOME folder
for file in `find $HOME/dotfiles -name '.*' | grep -v 'dotfiles/.git$' | perl -nle 'm!dotfiles/(.+)$! and print $1'`; do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

# delete gitignote 
rm $HOME/.gitignore

# install spacemacs
git clone git@github.com:bussorenre/spacemacs.git $HOME/.emacs.d

# change shell to zsh
chsh -s /bin/zsh


case $OSTYPE in 
    darwin*)
        brew install reattach-to-user-namespace
        ;;
    linux*)
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
        ;; 

esac

# node でjavascript 保管等に必要なパッケージを入れる
npm install -g tern js-beautify jshint
