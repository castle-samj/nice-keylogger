import socket
import sys
import time

server_port = 12001

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(('', server_port))
server.listen(1)

while 1:
    try:
        clientConnection, clientAddress = server.accept()
        newfile = time.strftime("%Y%m%d-%H%M%S.txt")
        print(f"{newfile} -> New file received!")
        message = clientConnection.recv(2048).decode().split(", ")[0]
        with open(f"{newfile}", "a") as f:
            f.write(message)

        clientConnection.close()
    except KeyboardInterrupt:
        sys.exit("Thank you for hacking")
