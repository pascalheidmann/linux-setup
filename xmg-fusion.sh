#/bin/bash
if ! [ $(id -u) = 0 ]; then
    echo "Run as root!"
	exit 1;
fi

apt update -y
apt install python3 python3-pip
pip3 install pyusb
pip3 install Pillow
pip3 install ite8291r3-ctl

if [ ! -f "/etc/udev/rules.d/99-ite8291.rules" ]; then
    echo "set udev rule"
    echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="048d", ATTRS{idProduct}=="ce00", MODE:="0666"' > "/etc/udev/rules.d/99-ite8291.rules"
    udevadm control --reload
    sudo udevadm trigger
fi
