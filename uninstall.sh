#!/bin/sh
# Uninstallation script

file_installed=".installed"

for file in `cat $file_installed`; do
    rm --interactive $file && echo "uninstalled: $file"
    cat $file_installed | grep -v $file > $file_installed
done
