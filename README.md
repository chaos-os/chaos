# ABOUT Neon-OS

**neon-os** is the name that we have chosen for our pre-installation
script which will deploy our configuration files and helper scripts to
create a proper full-fleged desktop experience it is basically our
desktop environment on your machine.

# Preview

## Awesomewm

### Preview coming Soon

## Qtile (Flagship)

### Preview coming Soon

## I3wm

### Preview coming Soon

# NOTE

-   neon-os is only for **x86~64~ architecture** and will mot work on
    arm or any other architectures.

-   The installation-script should only be run after the base install in
    user mode

# What it provides out of the box

## Config files

-   Qtile config
-   Awesomewm Config
-   I3wm config
-   Neovim config
-   Emacs config
-   etc.

## Helper scripts

-   article-viewer-convertor --\> For downloading and reading articles
    offline.
-   battery-notifier (For laptop users) --\> For notifying if battery
    has reached it\'s limits.
-   common-websites --\> Bookmarks for common websites you visit.
-   distro-updater --\> For updating the system to the latest.
-   google-meet --\> To make joining conference call easier.
-   gpu-hybrid-switcher --\> To make switching from one gpu to another
    easier (Specially for AMD gpu users.).
-   search-engines --\> Search through the web using the search engines
    you define.
-   themes-changer --\> Change themes easily with this script.

## Applications/Utilities

-   neon-podcaster --\> To listen to podcast from the terminal, for more
    info please [visit.](https://gitlab.com/NEON-MMD/neon-podcaster)
-   STDM --\> To making searching manual pages easier, for more info
    please [visit.](https://gitlab.com/NEON-MMD/stdm)
-   neon-logout --\> Logout menu, for more info please
    [visit.](https://gitlab.com/NEON-MMD/neon-logout)
-   All the applications I use on daily basis.

# Arch Linux installation recommendations/suggestions

If you want to have increased performance, security and lower power
consumption. Take a look at [RECOMMENDATIONS.org](RECOMMENDTIONS.org).

# prerequisites

Make sure you have installed all of the following prerequisites on your
machine:

1.  Git

``` shell

sudo pacman -Sy git

```

1.  Grub

``` shell

sudo pacman -Sy grub

```

# Installation

``` shell

git clone https://gitlab.com/NEON-MMD/neon-os.git
cd neon-os
chmod +x neon-os
./neon-os

```

# Updating Neon OS

Before running the following commands make sure to backup your config by
running the following commands:

``` shell

cd ~
mv .config .config.bak
mv .emacs.d/init.el .emacs.d/init.el.bak
mv .emacs.d/modules .emacs.d/modules.bak
mv .imwheelrc .imwheelrc.bak
mv .bashrc .bashrc.bak

```

Then run the following commands to update your system:

``` shell

cd /etc/neon-os/dotfiles/
sudo cp -rf .config/ ~/
sudo cp .emacs.d/init.el ~/.emacs.d/
sudo cp -rf .emacs.d/modules ~/.emacs.d/modules
sudo cp .imwheelrc ~/
sudo cp .bashrc ~/

cd ~
sudo chown -R $USER .config/
sudo chown -R $USER .emacs.d/modules
sudo chown $USER .emacs.d/init.el
sudo chown $USER .imwheelrc
sudo chown $USER .bashrc

```

Then run the following command to install packages neccesory for the
update:

``` shell

distro-updater

```

# Notifications in Neon OS

By default Neon OS does not provide any notification server but if you
want to have noftification follow this guides below:

-   <https://github.com/Toqozz/wired-notify>
-   <https://github.com/Toqozz/wired-notify/wiki>

# Contributing

Contributions are welcome. It does not matter who you are you can still
contribute to the project in your way :).

## Not a developer but still want to contribute

Here is [video](https://youtu.be/FccdqCucVSI) by Mr. Nick on how to
contribute and credit to him as well

## Developer

If you are developer, have a look at the
[CONTRIBUTING.org](CONTRIBUTING.org) document for more information.

# advice or suggestions

For any advice or suggestion email us on:

-   archlinuxpackagemaintainer@gmail.com
-   mohammed.patel19@vit.edu

# Post-installation

## Todo

-   Set the theme using lxappearance.
-   Check the aliases to use by running the following command:

``` shell

alias

```

### Neovim

-   To get vim setup launch neovim, ignore all the errors by pressing
    \<enter\> on your keyboard and wait for all the plugins to get
    installed and relaunch if neccessory.

Now you will have neovim setup.

### Emacs

-   To start using emacs, just launch for the first time and wait for
    all the packages to install and relaunch emacs and then do the
    following steps to finish the setup:

    -   **Step 1:**

        Press Alt+x on your keyboard, a popup will appear type
        **all-the-icons-install-fonts** and press \<enter\> and then it
        will prompt you to install some fonts press y on the keyboard.

    -   **Step 2:**

        Press Alt+x on your keyboard and type **emojify-mode** and press
        \<enter\> and then it will prompt you to install some fonts
        press y on the keyboard.

Now you will have emacs setup.

**NOTE:** Before launching emacs for the first time make sure you do not
have emacs running as a daemon.

To stop emacs from running in daemon run the following command:

``` shell

ustop emacs.service

```

or

``` shell

systemctl stop --user emacs.service

```

## common issues

# Credits

-   Mr.Derek Taylor \@gitlab.com/dwt1
-   the lain community
-   the arch community
-   paru aur community
-   awesomewm community
-   qtile community
-   i3 community
-   polybar community
