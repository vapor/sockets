
import SocksCore

//let raw = try! RawSocket(protocolFamily: .Inet, socketType: .Stream, protocol: .TCP)
let socketConfig = SocketConfig(addressFamily: .Unspecified, socketType: .Stream, protocolType: .TCP)
let addr = InternetAddress(hostname: "google.com", port: .PortNumber(80))
let socket: ClientSocket = try! InternetSocket(socketConfig: socketConfig, address: addr)
try! socket.connect()

//sends a GET / request to google.com at port 80, expects a 302 redirect to HTTPS
try! socket.send(data: "GET /\r\n\r\n".toBytes())

//receiving data
let received = try! socket.recv()

//converting data to a string
let str = try! received.toString()

//yay!
print("Received: \n\(str)")

try! socket.close()

print("successfully sent and received data from google.com")

