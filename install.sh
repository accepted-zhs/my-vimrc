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

    if [ -e ~/.config/nvim/init.vim ];then
        echo -n "~/.config/nvim/init.vim found. Backup? [Y/n] "
        read choice
        if [ "$choice" != "n" ] && [ "$choice" != "N" ];then
            cp ~/.config/nvim/init.vim ~/.config/nvim/init.vim_$cur
        fi
    fi
}

function install_font(){
    echo Installing FiraCode Nerd Font...
    mkdir -p ~/.local/share/fonts/firacode
    cp $(pwd)/fonts/*.otf ~/.local/share/fonts/firacode
    fc-cache -f -v ~/.local/share/fonts/firacode
    echo Please change your terminal font to FiraCode Nerd Font.
    sleep 0.5
}

function remove_old_configuration(){
    echo Removing old configuration...
    rm -i ~/.vimrc
    rm -rf ~/.vim
    rm -i ~/.config/nvim/init.vim
    sleep 0.5
}

function copy_files_for_vim(){
    which vim > /dev/null
    if [ $? -ne 0 ];then
        echo vim not found. Skipping.
        return
    fi
    echo Copying files for vim...
    ln -s $(pwd)/.vimrc ~/.vimrc
    mkdir ~/.vim
    cp -r $(pwd)/autoload ~/.vim/
    
    if ! [ -e ~/.vimrc_custom_settings ];then
        touch ~/.vimrc_custom_settings
    fi
    if ! [ -e ~/.vimrc_custom_plugins ];then
        touch ~/.vimrc_custom_plugins
    fi
    sleep 0.5
}

function copy_files_for_nvim(){
    which nvim > /dev/null
    if [ $? -ne 0 ];then
        echo nvim not found. Skipping.
        return
    fi
    echo Copying files for nvim...
    mkdir -p ~/.config/nvim
    ln -s $(pwd)/.vimrc ~/.config/nvim/init.vim
    mkdir ~/.vim
    cp -r $(pwd)/autoload ~/.vim/
    
    if ! [ -e ~/.vimrc_custom_settings ];then
        touch ~/.vimrc_custom_settings
    fi
    if ! [ -e ~/.vimrc_custom_plugins ];then
        touch ~/.vimrc_custom_plugins
    fi
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
    copy_files_for_vim
    copy_files_for_nvim
    finally_print_info
}

install_myvimrc
