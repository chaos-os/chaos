#!/bin/env bash
echo "############################################################################"
echo "########                   INSTALLING NEON-OS                       ########"
echo "############################################################################"

echo "---C----           adding and populating pacman-keys                ---C----"
sudo pacman-key --init
sudo pacman-key --populate

echo "---C----           syncing and updating repositories                ---C----"
sudo pacman -Syu --noconfirm --needed

echo "---C----           virtual machine or bare metal                    ---C----"
read -p "are you running archlinux in virtual environment [y/n]? " answer
if [[ $answer == "y" || $answer == "Y" ]]
then
    echo "proceeding to install open source graphics drivers"
    sudo pacman -S xf86-video-fbdev --noconfirm --needed
else
  echo "proceeding with the installation"
fi

echo "---C----              Configuring mirrors                           ---C----"
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sudo pacman -S reflector rsync --noconfirm --needed
sudo reflector -l 20 -f 5 -a 48 --sort rate --save /etc/pacman.d/mirrorlist
sudo cp pacman.conf /etc/pacman.conf

echo "---C----              Installing linux kernel-headers                ---C----"
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

echo "---C----             Installing Primary Gpu packages                  ---C----"
read -p "is one of your gpu intel [Y/N]? " answer12
if [[ $answer12 == "Y" || $answer12 == "y" ]]
then
    echo "installing intel gpu driver"
    sudo pacman -S intel-media-driver xf86-video-intel --noconfirm --needed
else
    echo "terminated"
fi

echo "---C----             Installing Appropriate Gpu packages              ---C----"
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

echo "---C----              Installing Hybrid Gpu packages                   ---C----"
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

echo "---C----              Installing Cpu Ucodes                         ---C----"
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

echo "---C----              Installing my packages                        ---C----"
sudo pacman -S - < pacman.txt --noconfirm --needed

echo "---C----              running one or multiple monitors              ---C----"
read -p "are you running multiple monitors [Y/N]? " answer3
if [[ $answer3 == "Y" || $answer3 == "y" ]]
then
    echo "installing arandr"
    sudo pacman -S arandr --noconfirm --needed
else
    echo "proceeding with the installation"
fi

echo "---C----              Installing openssh/ssh                        ---C----"
read -p "do you want to install openssh/ssh [Y/N]? " answer10
if [[ $answer10 == "Y" || $answer10 == "y" ]]
then
    echo "installing openssh/ssh"
    sudo pacman -S openssh --noconfirm --needed
    sudo cp sshd_config /etc/ssh/
else
    echo "terminated"
fi

echo "############################################################################"
echo "########                   ADDING LOGIN MANAGER                     ########"
echo "############################################################################"

sudo systemctl enable sddm.service -f

echo "############################################################################"
echo "########                   ENABLING AUR AND SNAP                    ########"
echo "############################################################################"

sudo cp makepkg.conf /etc/
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si

echo "############################################################################"
echo "########             INSTALLING AUR AND SNAP PACKAGES               ########"
echo "############################################################################"

cd 
paru -S - < open-neon-os/yay.txt --noconfirm --needed

echo "---C----              Installing optimus-manager                    ---C----"
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

sudo systemctl enable --now snapd.socket
sudo snap install - < open-neon-os/snap.txt

echo "############################################################################"
echo "########               ADDING WALLPAPERS FOR neon-os                ########"
echo "############################################################################"

cd
mkdir Pictures
mkdir .config
sudo mkdir /usr/share/themes
cd Pictures
git clone https://gitlab.com/dwt1/wallpapers.git

echo "############################################################################"
echo "########                  PLACING THE CONFIG FILES                  ########"
echo "############################################################################"

cd
cd open-neon-os
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
cp -r script-dependencies ~/.config
sudo cp youtube.lua /usr/lib/vlc/lua/playlist/youtube.luac

echo "############################################################################"
echo "########                    CONFIGURING NEOVIM                      ########"
echo "############################################################################"

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "############################################################################"
echo "########                    ENABLING SERVICES                       ########"
echo "############################################################################"

sudo systemctl enable --now bluetooth
sudo systemctl enable --now alsa-state.service
sudo systemctl enable --now alsa-restore.service
sudo systemctl enable --now pulseaudio
systemctl enable --user --now emacs
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

echo "---C----			          LAPTOP OR DESKTOP			              ---C----"
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

echo "############################################################################"
echo "########                   INSTALLING DOOM EMACS                    ########"
echo "############################################################################"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo npm i -g bash-language-server
sudo npm install -g vscode-css-languageserver-bin
sudo npm install -g vscode-html-languageserver-bin
sudo npm i -g typescript-language-server
sudo npm i -g typescript
sudo rustup component add rls rust-analysis rust-src

cd
git clone https://aur.archlinux.org/emacs-git.git
cd emacs-git
sed -i 's/^JIT=\(     \)/JIT="YES"/' PKGBUILD
makepkg --syncdeps --install
cd ~/open-neon-os
cp .emacs.d/ ../
cd

echo "############################################################################"
echo "########                 INSTALLING NEON-BROWSER                    ########"
echo "############################################################################"

git clone https://gitlab.com/NEON-MMD/neon-browser.git
cd neon-browser
./install.sh

echo "############################################################################"
echo "########                  ADDING USER TO GROUPS                     ########"
echo "############################################################################"

sudo usermod -aG kvm,vboxusers ${USER}

echo "############################################################################"
echo "########                      SETTING UP TPM                        ########"
echo "############################################################################"

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

echo "############################################################################"
echo "########                  REPLACING SUDO WITH DOAS                  ########"
echo "############################################################################"

doas -- paru -Qtdq | paru -Rns - sudo

echo "############################################################################"
echo "########                  REBOOTING YOUR SYSTEM                     ########"
echo "############################################################################"

reboot
