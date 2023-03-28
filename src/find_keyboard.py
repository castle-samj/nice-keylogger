# script to locate the appropriate eventX file on Debian Linux
import re
import sys
from time import sleep


def find_keyboard():
    f = open("/proc/bus/input/devices")
    lines = f.readlines()

    search_term = re.compile("Handlers|EV=")
    handlers = list(filter(search_term.search, lines))

    search_term = re.compile("EV=120013")
    for index, element in enumerate(handlers):
        if search_term.search(element):
            line = handlers[index - 1]

    search_term = re.compile("event[0-9]")
    try:
        keyboard_file = "/dev/input/" + search_term.search(line).group(0)
    except FileNotFoundError:
        print("No keyboard found..?")
        sleep(10)
        sys.exit("No keyboard found..?")

    return keyboard_file


if __name__ == '__main__':
    print("This should not be run directly")
    sys.exit("Call this from another program")
