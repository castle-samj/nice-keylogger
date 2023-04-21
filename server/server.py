import socket
import time

server_port = 12001

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(('', server_port))
server.listen(1)

while 1:
    clientConnection, clientAddress = server.accept()
    message = clientConnection.recv(2048).decode().split(", ")[0]
    newfile = time.strftime("%Y%m%d-%H%M%S.txt")
    with open(f"{newfile}", "a") as f:
        f.write(message)

    clientConnection.close()
