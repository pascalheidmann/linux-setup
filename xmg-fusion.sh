#/bin/bash
if ! [ $(id -u) = 0 ]; then
    echo "Run as root!"
	exit 1;
fi

apt update -y
apt install python3 python3-pip linux-headers-$(uname -r) dkms git
pip3 install pyusb
pip3 install Pillow
pip3 install ite8291r3-ctl

if [ ! -f "/etc/udev/rules.d/99-ite8291.rules" ]; then
    echo "set udev rule"
    echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="048d", ATTRS{idProduct}=="ce00", MODE:="0666"' > "/etc/udev/rules.d/99-ite8291.rules"
    udevadm control --reload
    sudo udevadm trigger
fi

if [ ! -d qc71_laptop ]; then
    git clone https://github.com/pobrn/qc71_laptop
    cd qc71_laptop
    make dkmsinstall
    modprobe qc71_laptop
fi

if [ ! -f "/etc/udev/rules.d/99-qc71_laptop.rules" ]; then
    echo "set udev rule"
    echo 'ACTION=="add", SUBSYSTEM=="leds", KERNEL=="qc71_laptop::lightbar", RUN+="/bin/chmod a+w /sys/class/leds/%k/brightness"' >> "/etc/udev/rules.d/99-qc71_laptop.rules"
    echo 'ACTION=="add", SUBSYSTEM=="leds", KERNEL=="qc71_laptop::lightbar", RUN+="/bin/chmod a+w /sys/class/leds/%k/brightness_s3"' >> "/etc/udev/rules.d/99-qc71_laptop.rules"
    echo 'ACTION=="add", SUBSYSTEM=="leds", KERNEL=="qc71_laptop::lightbar", RUN+="/bin/chmod a+w /sys/class/leds/%k/color"' >> "/etc/udev/rules.d/99-qc71_laptop.rules"
    echo 'ACTION=="add", SUBSYSTEM=="leds", KERNEL=="qc71_laptop::lightbar", RUN+="/bin/chmod a+w /sys/class/leds/%k/rainbow_mode"' >> "/etc/udev/rules.d/99-qc71_laptop.rules"
    udevadm control --reload
    sudo udevadm trigger
fi