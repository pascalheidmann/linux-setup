#/bin/bash
if ! [ $(id -u) = 0 ]; then
    echo "Run as root..."
	exit 1;
fi

echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/idea.conf
sudo sysctl -p --system

apt update -y
apt upgrade -y
apt-get install vim git docker docker-compose snapd chromium thunderbird gparted libreoffice

if [ $(echo $XDG_CURRENT_DESKTOP | grep -i "gnome" | wc -l) -gt 0 ]; then
    apt-get install gnome-shell-extensions;
fi

snap install --classic slack
snap install spotify
snap install postman
[ ! -d "jetbrains-toolbox-1.18.7455" ] && wget -qO- "https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.18.7455.tar.gz" | tar xvz && echo "run ./jetbrains-toolbox-1.18.7455/jetbrains-toolbox to install toolbox"

getent group docker || groupadd docker
usermod -aG docker $(whoami)
systemctl enable docker

exit 0
