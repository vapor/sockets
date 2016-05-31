//
//  RawSocketTest.swift
//  Socks
//
//  Created by Matthias Kreileder on 12/04/2016.
//
//

import XCTest
@testable import SocksCore

class RawSocketTest: XCTestCase {

    func testRawSocket(){
        let socketConfig = SocketConfig(addressFamily: .inet, socketType: .stream, protocolType: .TCP)
        let resolver = Resolver(config: socketConfig)
        
        let userProvidedInternetAddress = InternetAddress(hostname : "google.com", port : .portNumber(80))
        let _ = try! resolver.resolve(internetAddress: userProvidedInternetAddress)
        
        let raw = try! RawSocket(socketConfig: socketConfig)
        
        XCTAssertTrue(raw.descriptor > 0)
    }
}
