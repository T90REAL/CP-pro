import socket
import json

def receive_data(port):
    try:
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)  # Set socket option
        server_socket.bind(('localhost', port))
        server_socket.listen(1)
        print(f"Listening on port {port}...")

        connection, address = server_socket.accept()
        print(f"Connected by {address[0]}:{address[1]}")

        # Read the HTTP request
        request = b""
        while b"\r\n\r\n" not in request:
            data = connection.recv(4096)
            if not data:
                break
            request += data

        # Extract the JSON data from the request body
        body_start = request.find(b"\r\n\r\n") + len(b"\r\n\r\n")
        request_body = request[body_start:]
        json_data = request_body.decode('utf-8')

        print("Received data:", json_data)

        if json_data.strip():
            try:
                # Parse the received data as JSON
                message = json.loads(json_data)
                print("Parsed JSON:", message)

                # Extract input and output data from the received message
                tests = message.get('tests', [])

                for i, test in enumerate(tests, start=1):
                    input_data = test.get('input')
                    output_data = test.get('output')

                    if input_data is not None:
                        write_to_file(f'sol_{i}.in', input_data)
                    if output_data is not None:
                        write_to_file(f'ans_{i}.out', output_data)

                print("Data has been written to sol_*.in and ans_*.out")

            except json.JSONDecodeError as e:
                print("Error: Invalid JSON data received.")
                print(e)
        else:
            print("Error: Empty data received.")

        connection.close()

    except KeyboardInterrupt:
        print("Stopping the server...")
    finally:
        server_socket.close()

def write_to_file(filename, data):
    if data is None:
        return

    with open(filename, 'w') as file:
        file.write(data)

if __name__ == "__main__":
    port = 10043  # Port number to listen on
    receive_data(port)


