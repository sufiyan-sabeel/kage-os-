#!/data/data/com.termux/files/usr/bin/bash

clear
echo "====================================="
echo "   KAGE OS INSTALLER (Ubuntu + VNC)  "
echo "====================================="
sleep 2

# Update Termux
pkg update -y && pkg upgrade -y

# Install dependencies
pkg install wget curl proot tar -y

# Setup folder
mkdir -p $HOME/kage-os
cd $HOME/kage-os

# Download Ubuntu script
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Ubuntu/ubuntu.sh

chmod +x ubuntu.sh
./ubuntu.sh

# Start Ubuntu and install GUI
./start-ubuntu.sh <<EOF

apt update && apt upgrade -y

# Desktop choice
echo "Choose Desktop:"
echo "1. XFCE"
echo "2. LXDE"
read choice

if [ \$choice -eq 1 ]; then
    apt install xfce4 xfce4-goodies -y
elif [ \$choice -eq 2 ]; then
    apt install lxde -y
fi

# Install VNC
apt install tightvncserver -y

echo "Set your VNC password:"
vncserver

vncserver -kill :1

echo "startxfce4 &" > ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

vncserver :1

echo "VNC running at localhost:5901"

EOF

echo "[✔] KAGE OS INSTALL COMPLETE!"

