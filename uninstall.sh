#!/bin/sh
# Uninstallation script

file_installed=".installed"

prechoice="y"

for file in `cat $file_installed`; do
    read -p "Uninstall $file ? [$prechoice] " input
    if [ "$input" = "y" ] || [ "$input" = "Y" ] || ([ "$prechoice" = "y" ] && [ -z "$input" ]); then
        prechoice="y"
        unlink $file
        t=$(cat $file_installed | grep -v "^$file$")
        echo "$t" > $file_installed
    else
        prechoice="n"
    fi
done
