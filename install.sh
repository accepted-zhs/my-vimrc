#!/bin/bash

function get_time(){
    echo `date "+%Y-%m-%d%H%M%S"`
}

function print_info(){
    local choice
    echo "This is an alpha version and many features are currently unavailable. (like custom configuration)"
    echo -n "Continue? [y/N] "
    read choice
    if [ "$choice" != "y" ] && [ "$choice" != "Y" ];then
        echo Exiting.
        exit 1 
    fi
}

function backup_file(){
    local cur="`get_time`"
    local choice
    echo "It's going to backup your own vim configuration."
    if [ -e ~/.vimrc ];then
        echo -n "~/.vimrc found. Backup? [Y/n] "
        read choice
        if [ "$choice" != "n" ] && [ "$choice" != "N" ];then
            cp ~/.vimrc ~/.vimrc_bak_$cur
        fi
    fi

    if [ -d ~/.vim ];then
        echo -n "~/.vim found. Backup? [Y/n] "
        read choice
        if [ "$choice" != "n" ] && [ "$choice" != "N" ];then
            cp -r ~/.vim ~/.vim_bak_$cur
        fi
    fi
}

function install_font(){
    mkdir -p ~/.local/share/fonts/firacode
    cp $(pwd)/fonts/*.otf ~/.local/share/fonts/firacode
}

function install_myvimrc(){
    echo Installing... 
    rm -i ~/.vimrc
    rm -rf ~/.vim
    ln -s $(pwd)/.vimrc ~/.vimrc
    sleep 0.5

    echo
    echo Done!
    echo Open vim to complete the configuration.
}

print_info
backup_file
install_myvimrc
