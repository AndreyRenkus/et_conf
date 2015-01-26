#!/usr/bin/python
import os
import socket


def main():
    jts_server()


# Runs http server to handle eshtapay admin commands
def jts_server():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(('127.0.0.1', 2000))
    server_socket.listen(1)
    while True:
        connection, client_address = server_socket.accept()
        request = connection.recv(100)
        if "reboot" in request:
            os.system('reboot')
        elif "shutdown" in request:
            os.system('shutdown -P now')
        elif "restart" in request:
            os.system('/etc/init.d/eshtapay-terminals restart')
        else:
            connection.send(b"Unknown command")
        connection.close()

if __name__ == "__main__": main()
