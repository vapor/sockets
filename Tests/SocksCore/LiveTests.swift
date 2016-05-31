//
//  LiveTests.swift
//  Socks
//
//  Created by Honza Dvorsky on 3/20/16.
//
//

import XCTest
@testable import SocksCore

class LiveTests: XCTestCase {

    func testLive_Connect_Google() {
        
        let socketConfig = SocketConfig(addressFamily: .unspecified, socketType: .stream, protocolType: .TCP)
        let addr = InternetAddress(hostname: "google.com", port: .portNumber(80))
        let socket = try! InternetSocket(socketConfig: socketConfig, address: addr)
        try! socket.connect()
        try! socket.close()
        print("successfully connected and closed")
    }
    
    func testLive_HTTP_Get_Google() {
        let socketConfig = SocketConfig(addressFamily: .unspecified, socketType: .stream, protocolType: .TCP)
        let addr = InternetAddress(hostname: "google.com", port: .portNumber(80))
        let socket = try! InternetSocket(socketConfig: socketConfig, address: addr)
        try! socket.connect()
        
        //sends a GET / request to google.com at port 80, expects a 302 redirect to HTTPS
        try! socket.send(data: "GET /\r\n\r\n".toBytes())
        
        //receiving data
        let received = try! socket.recv()
        
        //converting data to a string
        let str = try! received.toString()
        
        //yay!
        XCTAssertTrue(received.starts(with: "HTTP/1.0 ".toBytes()), "Instead received: \(str)")
        
        try! socket.close()
        print("successfully sent and received data from google.com")
    }
    
}
