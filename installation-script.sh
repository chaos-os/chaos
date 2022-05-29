#!/bin/env bash

cat banner.txt
echo ""
echo "############################################################################" | lolcat
echo "########                   INSTALLING NEON-OS                       ########" | lolcat
echo "############################################################################" | lolcat

echo "---C----           adding and populating pacman-keys                ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow 
sudo pacman-key --init
sudo pacman-key --populate

echo "---C----           syncing and updating repositories                ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
sudo pacman -Syu --noconfirm --needed

echo "---C----           virtual machine or bare metal                    ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
read -p "are you running archlinux in virtual environment [y/n]? " answer
if [[ $answer == "y" || $answer == "Y" ]]
then
    echo "proceeding to install open source graphics drivers" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
    sudo pacman -S xf86-video-fbdev --noconfirm --needed
else
  echo "proceeding with the installation"
fi

echo "---C----              Configuring mirrors                           ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sudo pacman -S reflector rsync --noconfirm --needed
sudo reflector -l 20 -f 5 -a 48 --sort rate --save /etc/pacman.d/mirrorlist
sudo cp pacman.conf /etc/pacman.conf

echo "---C----              Installing linux kernel-headers                ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
read -p "1)linux-zen  2)linux  3)linux-lts  4)other " answer4
if [[ $answer4 == "1" ]]
then
    echo "installing linux-zen-headers"
    sudo pacman -S linux-zen-headers --noconfirm --needed
elif [[ $answer4 == "2" ]]
then
    echo "installing linux-headers"
    sudo pacman -S linux-headers --noconfirm --needed
elif [[ $answer4 == "3" ]]
then
    echo "installing linux-lts-headers"
    sudo pacman -S linux-lts-headers --noconfirm --needed
else
    echo "please install your custom linux headers after install"
fi

echo "---C----             Installing Primary Gpu packages                  ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
read -p "is one of your gpu intel [Y/N]? " answer12
if [[ $answer12 == "Y" || $answer12 == "y" ]]
then
    echo "installing intel gpu driver"
    sudo pacman -S intel-media-driver xf86-video-intel --noconfirm --needed
else
    echo "terminated"
fi

echo "---C----             Installing Appropriate Gpu packages              ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
read -p "1)Nvidia  2)Amd  3)Intel  4)quit " answer5
if [[ $answer5 == "1" ]]
then
    echo "installing Nvidia"
    if [[ $answer4 == "1" ]]
    then
        sudo pacman -S nvidia-dkms nvidia --noconfirm --needed
    else
        sudo pacman -S nvidia --noconfirm --needed
    fi
elif [[ $answer5 == "2" ]]
then
    echo "installing intel"
    sudo pacman -S mesa --noconfirm --needed
elif [[ $answer5 == "3" ]]
then
    echo "installing amd"
    sudo pacman -S mesa mesa-vdpau --noconfirm --needed
    read -p "1)amdgpu  2)radeon " answer11
    if [[ $answer11 == "1" ]]
    then
        echo "installing amdgpu"
        sudo pacman -S xf86-video-amdgpu --noconfirm --needed
    elif [[ $answer11 == "2" ]]
    then
        echo "installing radeon"
        sudo pacman -S xf86-video-ati --noconfirm --needed
    else
        echo "terminated"
    fi
else
    echo "terminated"
fi

echo "---C----              Installing Hybrid Gpu packages                   ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
read -p "1)Nvidia-hybrid  2)Amd-hybrid  3)quit " answer6
if [[ $answer6 == "1" ]]
then
    echo "installing Nvidia-Hybrid"
    read -p "1)Bumblebee  2)nvidia-prime  3)nvidia-xrun " answer7
    if [[ $answer7 == "1" ]]
    then
        sudo pacman -S Bumblebee bbswitch bbswitch-dkms --noconfirm --needed
    elif [[ $answer7 == "2" ]]
    then
        sudo pacman -S nvidia-prime bbswitch bbswitch-dkms --noconfirm --needed
    else
        sudo pacman -S nvidia-xrun bbswitch bbswitch-dkms --noconfirm --needed
    fi
elif [[ $answer6 == "2" ]]
then
    echo "putting Amd-Hybrid switch directory with scripts and configs"
    cp -r amd-hybrid-switcher ~/
else
    echo "terminated"
fi

echo "---C----              Installing Cpu Ucodes                         ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
read -p "1)Intel-ucode  2)Amd-ucode  3)quit" answer6
if [[ $answer6 == "1" ]]
then
    echo "installing Intel-ucode"
    sudo pacman -S intel-ucode
    sudo grub-mkconfig -o /boot/grub/grub.cfg
elif [[ $answer6 == "2" ]]
then
    echo "installing Amd-ucode"
    sudo pacman -S amd-ucode
    sudo grub-mkconfig -o /boot/grub/grub.cfg
else
    echo "terminated"
fi

echo "---C----              Installing my packages                        ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
sudo pacman -S - < pacman.txt --noconfirm --needed

echo "---C----              running one or multiple monitors              ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
read -p "are you running multiple monitors [Y/N]? " answer3
if [[ $answer3 == "Y" || $answer3 == "y" ]]
then
    echo "installing arandr"
    sudo pacman -S arandr --noconfirm --needed
else
    echo "proceeding with the installation"
fi

echo "---C----              Installing openssh/ssh                        ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
read -p "do you want to install openssh/ssh [Y/N]? " answer10
if [[ $answer10 == "Y" || $answer10 == "y" ]]
then
    echo "installing openssh/ssh"
    sudo pacman -S openssh --noconfirm --needed
    sudo cp sshd_config /etc/ssh/
else
    echo "terminated"
fi

echo "############################################################################" | lolcat
echo "########                   ADDING LOGIN MANAGER                     ########" | lolcat
echo "############################################################################" | lolcat

sudo systemctl enable sddm.service -f

echo "############################################################################" | lolcat
echo "########                   ENABLING AUR AND SNAP                    ########" | lolcat
echo "############################################################################" | lolcat

sudo cp makepkg.conf /etc/
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si

echo "############################################################################" | lolcat
echo "########                   INSTALLING AUR PACKAGES                  ########" | lolcat
echo "############################################################################" | lolcat

cd 
paru -S - < neon-os/yay.txt --noconfirm --needed

echo "---C----              Installing optimus-manager                    ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
sudo mkdir /etc/sddm.conf.d/
read -p "do you want to install optimus-manager [Y/N]? " answer8
if [[ $answer8 == "Y" || $answer8 == "y" ]]
then
    echo "installing optimus-manager"
    paru -S optimus-manager-qt --noconfirm --needed
    sudo mkdir /etc/optimus-manager
    sudo cp optimus-manager.conf /etc/optimus-manager/
    sudo cp sddm.conf /etc/sddm.conf.d/
else
    echo "terminated"
    sudo cp sddm.conf /etc/sddm.conf.d/
    sudo cp sddm-alt.conf /etc/sddm.conf.d/sddm.conf
fi

echo "############################################################################" | lolcat
echo "########               ADDING WALLPAPERS FOR neon-os                ########" | lolcat
echo "############################################################################" | lolcat

cd
mkdir Pictures
mkdir .config
sudo mkdir /usr/share/themes
cd Pictures
git clone https://gitlab.com/dwt1/wallpapers.git

echo "############################################################################" | lolcat
echo "########                  PLACING THE CONFIG FILES                  ########" | lolcat
echo "############################################################################" | lolcat

cd
git clone https://gitlab.com/NEON-MMD/dotfiles.git
cd dotfiles
cp -r qtile ~/.config/
cp -r awesome ~/.config/
cp -r picom ~/.config/
cp -r fish ~/.config/
cp -r mpv  ~/.config/
cp -r nvim ~/.config/
cp -r kitty ~/.config/
cp -r i3 ~/.config/
cp -r i3blocks ~/.config/
cp -r scripts ~/.config/
cp starship.toml ~/.config/starship.toml
cd
cd neon-os
sudo cp -r Arc-Cyberpunk-Neon  /usr/share/themes/
sudo cp -r all-themes-sddm/ /usr/share/sddm/themes/
sudo cp reflector.conf /etc/xdg/reflector/reflector.conf
sudo cp enviroment /etc/
sudo cp doas.conf /etc/
sudo cp ufetch-arch /usr/bin/
sudo cp -r home /etc/snapper/configs/
sudo cp -r root /etc/snapper/configs/
sudo cp paru.conf /etc/paru.conf
sudo cp usr-scripts/* /usr/bin/
cp -r script-dependencies/ ~/.config
sudo cp youtube.lua /usr/lib/vlc/lua/playlist/youtube.luac

echo "############################################################################" | lolcat
echo "########                       CONFIGURING VIM                      ########" | lolcat
echo "############################################################################" | lolcat

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/powerline/fonts
cd fonts
./install.sh
cd ..
rm -rf fonts
sudo fc-cache -r -v

echo "############################################################################" | lolcat
echo "########                    ENABLING SERVICES                       ########" | lolcat
echo "############################################################################" | lolcat

sudo systemctl enable bluetooth
sudo systemctl enable alsa-state.service
sudo systemctl enable alsa-restore.service
sudo systemctl enable pulseaudio
systemctl enable --user emacs
sudo systemctl enable reflector.service
sudo systemctl enable reflector.timer
sudo systemctl enable snapper-timeline.timer
sudo systemctl enable snapper-cleanup.timer
sudo rcvboxdrv modprobe
sudo timedatectl set-ntp true
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
systemctl enable --user pipewire.service p11-kit-server.service pulseaudio.service snapd.session-agent.socket systemd-tmpfiles-clean.timer systemd-tmpfiles-setup.service
sudo systemctl enable clamav-freshclam.service clamav-clamonacc.service clamav-daemon.service clamav-daemon.socket
sudo systemctl enable libvirtd.service

echo "---C----			          LAPTOP OR DESKTOP			              ---C----" | toilet -d /usr/share/figlet/fonts/ -f term -t -F border --rainbow
read -p "are you running a laptop [Y/N]? " answer2
if [[ $answer2 == "y" || $answer2 == "Y" ]]
then
    echo "enabling tlp" 
    sudo cp tlp.conf /etc/
    sudo systemctl enable tlp
    sudo tlp start
else
    echo "proceeding with the installation"
fi

echo "############################################################################" | lolcat
echo "########                   INSTALLING GNU EMACS                     ########" | lolcat
echo "############################################################################" | lolcat

cd
git clone https://aur.archlinux.org/emacs-git.git
cd emacs-git
sed -i 's/^JIT=\(     \)/JIT="YES"/' PKGBUILD
makepkg --syncdeps --install
cd ~/neon-os
cp -r .emacs.d/ ../
cd

echo "############################################################################" | lolcat
echo "########                  ADDING USER TO GROUPS                     ########" | lolcat
echo "############################################################################" | lolcat

sudo usermod -aG kvm,libvirt,libvirt-qemu ${USER}

echo "############################################################################" | lolcat
echo "########                      SETTING UP TPM                        ########" | lolcat
echo "############################################################################" | lolcat

read -p "1)TPM-1.2  2)TPM-2.0  3)Quit " answer
if [[ $answer == "1" ]]
then
    echo "installing TPM-1.2"
    paru -S tpm-tools trousers --noconfirm --needed
    modprobe tpm
    modprobe -a tpm_{atmel,infineon,nsc,tis,crb}
    sudo systemctl enable tcsd.service
elif [[ $answer == "2" ]]
then
    echo "installing TPM-2.0"
    sudo pacman -S tpm2-tools --noconfirm --needed
else
    echo "terminated"
fi

echo "############################################################################" | lolcat
echo "########                  REPLACING SUDO WITH DOAS                  ########" | lolcat
echo "############################################################################" | lolcat

sudo chown -c root:root /etc/doas.conf
sudo chmod -c 0400 /etc/doas.conf
doas -- paru -Qtdq | paru -Rns - sudo

echo "############################################################################" | lolcat
echo "########                  REBOOTING YOUR SYSTEM                     ########" | lolcat
echo "############################################################################" | lolcat

reboot
