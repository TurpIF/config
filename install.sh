#!/bin/sh
# Intallation script

file_installed=".installed"
dotfiles_dir="dotfiles"
config_dir="config"
etc_dir="etc"
bundle_dir="bundle"

add_not_installed=false
recursive=false

# Utility function to add a symbolic link from $2$1 to $PWD/$1
# Param 1: filename of the file to link
# Param 2: filename of the link
# Param 3: file containing the list of all installed link
#
# Print a warning if there is already a file $2$1 wich isn't a sym link
# Append in the file $3 the path of the installed link ($HOME/.$1)
install_symlink()
{
    local target="$2"
    local from="$1"
    local file_installed="$3"

    touch $file_installed

    if [ -e "$target" ]; then
        if [ ! -L "$target" ]; then
            if [ -d "$target" ] && [ -d "$from" ] && $recursive; then
                echo "WARNING: $targets is an existing directory. Pass recursivly inside."
                for file in $from/*; do
                    new_target="$target/$(basename $file)"
                    install_symlink $file $new_target $file_installed
                done
            else
                echo "WARNING: $target exists but is not a symlink."
            fi
        else
            cat $file_installed | grep $target > /dev/null
            if [ ! $? -eq 0 ]; then
                if $add_not_installed; then
                    echo "Add already installed file $target"
                    echo "$target" >> $file_installed
                else
                    echo "WARNING: $target exists but is not in $file_installed"
                fi
            else
                echo "IGN: $from -> $target already installed"
            fi
        fi
    else
        echo "Install $from -> $target"
        ln -s $from $target && echo "$target" >> $file_installed
    fi
}

# Place all files in dotfiles dir in the home dir as hidden files (by a symbolic link).
install_all()
{
    for file in $dotfiles_dir/*; do
        file=$(basename $file)
        install_symlink $PWD/$dotfiles_dir/$file $HOME/.$file $file_installed
    done
}

help()
{
    echo "Utilisation : $0 [OPTION]...
Create symlink to install this repository. Symlink are placed
inside the home directory of the current user.
Links from the ./etc, ./bundle and ./dotfiles/* ./config* are
done. Those from ./config are place in the local .config of the user
(home/user/.config by default).
Created symlinks are put in the file .installed (by default)
to help user to remove all links.

Les arguments obligatoires pour les options longues le sont aussi pour les
options courtes.
-a, --add-not-installed    Add in .installed all symlink even if the
                            links already exist
-h, --help                 Show this help
-r, --recursive            If a directory has to be linked but there is
                            an existing directory, pass inside and link
                            recursivly the content of the directory.
"
}

invalid_option()
{
    echo "$1 : option invalid -- $2"
    echo "Saisissez « $1 --help » pour plus d'informations."
}

# Main
while [ "$1" != "" ]; do
    case $1 in
        -a | --add-not-installed )
            add_not_installed=true
            ;;
        -r | --recursive )
            recursive=true
            ;;
        -h | --help )
            help
            exit
            ;;
        * )
            invalid_option $0 $1
            exit 1
    esac
    shift
done

install_all
