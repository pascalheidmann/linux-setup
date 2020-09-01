#/bin/bash
if ! [ $(id -u) = 0 ]; then
	return 1;
fi
apt update -y
apt upgrade -y
apt-get install vim git docker docker-compose snapd chromium thunderbird gparted libreoffice

if [ $(echo $XDG_CURRENT_DESKTOP | grep -i "gnome" | wc -l) -gt 0 ]; then
    apt-get install gnome-shell-extensions;
fi

snap install --classic slack
snap install spotify
snap install postman
[ ! -d "jetbrains-toolbox-1.17.7391" ] && wget -qO- "https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.17.7391.tar.g" | tar xvz
groupadd docker
usermod -aG docker $(whoami)
newgrp docker
systemctl enable docker

