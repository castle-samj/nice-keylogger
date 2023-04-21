import socket
import sys

server_name = '10.211.55.14'
server_port = 12001

# create a socket object
client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
    client.connect((server_name, server_port))
    sentence = sys.argv[1]
    client.send(sentence.encode())
except FileNotFoundError:
    pass

client.close()
