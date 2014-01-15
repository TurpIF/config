Installation de Archlinux
=========================

# Création d'une clé usb bootable
Il faut télécharger une image ISO de arch sur le site officiel
[https://www.archlinux.org/download/](https://www.archlinux.org/download/).

Pensez à vérifier si l'image téléchargé est valide avec le checksum MD5 et la
signature :

    md5sum -c md5sum.txt
    pacman-key -v archlinux-dual.iso.sig

Ces deux fichiers doivent se trouver dans le même dossier que l'image ISO.


Il faut ensuite écrire l'image sur sa clé usb.
Vérifiez d'abord quel est le nom associé à votre clé puis assurez vous quelle
n'est pas montée

    sudo fdisk -l
    lsblk


Il est alors possible d'écrire dessus avec la commande *dd* (remplacez sdx par
le nom de la clé)

    dd bs=4M if=archlinux.iso of=/dev/sdx && sync

# Boot sur la clé

Il suffit de redémarrer le PC.
Si l'USB est en premier dans l'ordre de boot, il suffit de laisser.
Sinon, il faut soit changer l'ordre de boot dans le bios, soit demander un boot
sur un endroit spécifié.

Une fois booté sur l'usb, choisissez l'architecture de votre processeur (32bits
ou 64bits).

# Configuration

Le système est directement connecté à root sur la clé usb avec un sh.
Il est possible de le configurer un minimum pour faciliter l'installation.

Changement de la disposition du clavier :

    loadkeys fr-pc


Changement de la date du système (utile pour la vérification des paquets

installés) :

    date -s "mm/dd/yyyy"


Demande d'une ip au réseau avec l'interface ethernet :

    dhcpcd eno1


Si vous vous connectez à un réseau qui necessite une identification sur une
page web, il est possible d'utiliser *wget* (exemple avec l'insa de lyon) :

    wget --no-check--certificate \
    --post-data="fdqm=insa-lyon.fr&user=xxx&password=xxx&submit=Envoyer" \
    -O /dev/null \
    'https://securelogin.arubanetworks.com/cgi-bin/login'


# Partitionnement du disque

Pour partionner le disque, il est possible d'utiliser le mode intéractif de
*fdisk*.

Voici un exemple d'architecture de partitionnement :
- swap : autant que la RAM pour pouvoir utiliser l'hibernaétion du système
- /boot : 100Mo à 200Mo maximum
- /home : autant que vous voulez
- / : environ 20Go à 30Go en fonction de ce que vous voulez mettre dessus

Pour formater les partitions, on utilise ensuite la commande *mkfs*. On utilise
en générale ext4 pour les partitions :

    mkfs.ext4 <dev>


Pour le swap, on utilise *mkswap* :

    mkswap <dev>


# Montage des partitions

Il reste à monter les partitions créées :

    mkdir /mnt && \
    mount <dev> /mnt && \
    mkdir /mnt/boot && \
    mount <dev> /mnt/boot && \
    mkdir /mnt/home && \
    mount <dev> /mnt/home


Il ne faut pas oublier d'activer la swap :

    swapon <dev>


# Installation des paquets

Il ne reste plus qu'à installer les paquets de base dans le nouveau système.

On peut régler la position des mirroirs de téléchargement utilisés dans le
fichier */etc/pacman.d/mirrorlist*

On install un paquet avec *pacstrap* !

    pacstrap /mnt <paquets>


Le groupe *base* contient tous les paquets nécessaire au système. On peut
également ajouter *base-devel* pour pouvoir utiliser l'AUR. Pensez également à
ajouter *syslinux* pour le boot, *wireless_tools* pour la connexion wifi et
*wget* dans le cas ou vous devez l'utiliser pour activer votre connexion.

    pacstrap /mnt base base-devel wireless_tools syslinux wget.


# chroot dans le nouveau système

Avant de chrooter dans le nouveau système installer, on configure son fstab :

    genfstab -U -p /mnt > /mnt/etc/fstab


Puis on peut chroot dedans :

    arch-chroot /mnt


# Derniers préparatifs

Choix de la localité/langue/disposition clavier :

    cat /etc/locale.gen | sed 's/#\(fr_FR UTF-8\)/\1/g' > /etc/logcale.gen
    locale-gen
    echo 'LANG="fr_FR.UTF-8"' > /etc/locale.conf
    echo "KEYMAP=fr-pc" > /etc/vconsole.conf
    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime


Choix du nom de la machine :

    echo "<nom>" > /mnt/etc/hostname


Définition du mot de passe root :

    passwd


Installation de *syslinux* (il faut d'abord vérifier que le bon device est
lancé)

    syslinux-install_update -iam


Ramdisk :

    mkinitcpio -p linux


Il reste a ajouter un utilisateur avec un mot de passe

    useradd -g users -m -s /bin/bash <nom>
    passwd <nom>


Pour qu'il puisse utiliser la commande sudo, on l'inclu dans le groupe wheel.
Il faut également décommenter la ligne correspondante dans le fichier
*/etc/sudoers*

    usermod -a -G wheel <nom>


Activation de la connexion au démarrage en utilisant l'interface ethernet

    systemctl enable dhcpcd@eno1


# Installation des derniers paquets

Le système est opérationnel mais on peut rajouter des paquets pour par exemple
avoir un environnement graphique.

Avec une installation de *yaourt* avant :

    yaourt -S xorg-server xorg-server-utils xorg-xinit \
    nvidia_304xx nvidia_304xx-utils \
    cinnamon blender python2 python python-pip python2-pip \
    vlc gvim git xf86-input-synaptics zsh \
    eyesight evince file-roller gnome-terminal \
    google-chrome-beta
    unzip unrar \
    texlive-core texlive-latexextra texlive-langextra

