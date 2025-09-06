#/bin/bash
if ! [ $(id -u) = 0 ]; then
    echo "Run as root..."
    exit 1;
fi

JETBRAINS_TOOLBOX_VERSION="1.25.12999"

echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/idea.conf
sysctl -p --system

apt-get -y install vim git ca-certificates curl snapd thunderbird gparted libreoffice keepassxc php php-dom 

# needed for docker
apt-get update -y
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

if [ $(echo $XDG_CURRENT_DESKTOP | grep -i "gnome" | wc -l) -gt 0 ]; then
    apt-get install gnome-shell-extensions gnome-shell-extension-multi-monitors gnome-tweaks;
fi

snap install --classic slack
snap install spotify
snap install postman

# libfuse is broken on ubuntu 22.04
#[ ! -d "jetbrains-toolbox-$JETBRAINS_TOOLBOX_VERSION" ] && wget -qO- "https://download.jetbrains.com/toolbox/jetbrains-toolbox-$JETBRAINS_TOOLBOX_VERSION.tar.gz" | tar xvz && echo "run ./jetbrains-toolbox-$JETBRAINS_TOOLBOX_VERSION/jetbrains-toolbox to install toolbox"

# add user to docker group if not already
CURRENT_USER=$(env | grep SUDO_USER | cut -d= -f2)
_IGNORE=`getent group docker || groupadd docker`

if [ -z `getent group docker | grep "$CURRENT_USER"` ]; then
	echo "Adding $CURRENT_USER to docker group"

	usermod -aG docker $CURRENT_USER
	systemctl enable docker
fi
echo "Docker group:"
getent group docker

echo "Consider restarting your system"

exit 0
