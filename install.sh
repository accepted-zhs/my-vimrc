#!/bin/bash

function get_time(){
    echo `date "+%Y-%m-%d-%H%M%S"`
}

function print_info(){
    local choice
    echo "Please read README.md first and install some dependencies manually."
    echo -n "Continue? [y/N] "
    read choice
    if [ "$choice" != "y" ] && [ "$choice" != "Y" ];then
        echo Exiting.
        exit 1 
    fi
}

function backup_file(){
    local cur=`get_time`
    local choice
    echo "Backup old vim configuration..."
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
    echo Installing FiraCode Nerd Font...
    mkdir -p ~/.local/share/fonts/firacode
    cp $(pwd)/fonts/*.otf ~/.local/share/fonts/firacode
    echo Please change your terminal font to FiraCode Nerd Font.
    sleep 0.5
}

function remove_old_configuration(){
    echo Removing old configuration...
    rm -i ~/.vimrc
    rm -rf ~/.vim
    sleep 0.5
}

function copy_files(){
    echo Copying files...
    ln -s $(pwd)/.vimrc ~/.vimrc
    mkdir -p ~/.vim/autoload
    sleep 0.5
}

function finally_print_info(){
    echo
    echo Done!
    echo Open vim to complete the configuration.
}

function install_myvimrc(){
    print_info
    backup_file
    install_font
    remove_old_configuration
    copy_files
    finally_print_info
}

install_myvimrc
