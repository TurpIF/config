Configuration files
===================

- XTerm basic configuration
- URxvt configuration (require Perl scripts)
- Git basic configuration and aliases
- Old Bash config
- Customized Zsh
- Useful Vim configuration (require some plugins)

## Installation
```sh
git clone https://github.com/TurpIF/config.git ~/Config
cd ~/Config
./install.sh -r
```

### URxvt Perl scripts
If you use URxvt, you need to download other dependancy Perl scripts:
- https://aur.archlinux.org/packages/urxvt-perls-git/ (https://github.com/muennich/urxvt-perls)
- https://aur.archlinux.org/packages/urxvt-fullscreen/

```sh
# Using yaourt
yaourt -S urxvt-perls-git
yaourt -S urxvt-fullscreen

# Using pacman
mkdir tmp
cd tmp

wget https://aur.archlinux.org/packages/ur/urxvt-fullscreen/urxvt-fullscreen.tar.gz
tar -xvf urxvt-fullscreen.tar.gz
cd urxvt-fullscreen
makepkg -s
sudo pacman -U urxvt-fullscreen*.pkg.tar.xz
cd ..

wget https://aur.archlinux.org/packages/ur/urxvt-perls-git/urxvt-perls-git.tar.gz
tar -xvf urxvt-perls-git.tar.gz
cd urxvt-perls-git
makepkg -s
sudo pacman -U urxvt-perls-git*.pkg.tar.xz
cd ..

cd ..
```

### Vim plugins
A big part of the submodules are plugins for Vim.

```sh
cd ~/Config
git submodule update --init --recursive
```

