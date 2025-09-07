#/bin/bash
sudo apt-get update -y
sudo apt install -y gnome-shell-extension-manager

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['']"
