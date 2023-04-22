# Nice Keylogger
### CMSC414 Spring 2023 Semester Assignment
___ 
### Purpose
This project was intended to explore the creation of either a defense against malicious code, or a malicious code.  
We chose to construct a keylogger

### Target
We are targeting the user of an older Raspberry Pi, when the units initialized with a standard username and password.

### Flow
 - Coordinator: The entry point is the file [coordinator.sh](/src/coordinator.sh). This file elevates the user's 
privileges, removes the need for passwords while using `sudo`, downloads all needed files, sets files as executable, 
installs the service file with systemd to ensure runtime after a reboot, launches [restart.sh](/src/restart.sh), 
and finally displays a picture of a puppy as the decoy payload.
 - restart: This script is responsible for launching the main component of the keylogger, 
[controller.py](/src/controller.py), and then running a loop for reporting home.
 - controller: The controller is the main function of the keylogger. It begins by finding the event file used for 
the victim's keyboard (using [find_keyboard.py](/src/find_keyboard.py)), then listens to that file for changes. On 
a keypress, the contents are mapped through [keymap.py](/src/keymap.py) which converts from the Linux key codes to
human-readable text. This text is then appended to a newly created file, out.txt.

### On Reboot
The script installs a service, [nice-keylogger.service](/src/nicekeylogger.service) that is registered with systemd 
to run each time the system reboots.

### The Server
The server application is run on the attacking machine. It receives TCP messages from the victim, saving them as new
files that are named based on the time the message was received.