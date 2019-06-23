//
//  ExpirableTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 23/06/2019.
//

import XCTest
@testable import Expirable

final class ExpirableTests: XCTestCase {
    
    @Expirable(duration: 0.1)
    var token: String?
    
    override func setUp() {
        token = "1234"
    }
    
    func testGet() {
        XCTAssertEqual(token, "1234")
    }
    
    func testGetExpired() {
        usleep(150_000) // 0.15 secs
        XCTAssertFalse($token.isValid)
    }
    
    func testSet() {
        token = "abc"
        XCTAssertEqual(token, "abc")
    }
    
    func testIsValid() {
        XCTAssertTrue($token.isValid)
    }
    
    func testIsValidExpired() {
        usleep(150_000) // 0.15 secs
        XCTAssertNil(token)
    }
    
    func testInitWithExistingValidToken() {
        let pastDate = Date().addingTimeInterval(0.2)
        $token = Expirable<String>(initialValue: "abc", expirationDate: pastDate, duration: 0.2)
        XCTAssertEqual(token, "abc")
        usleep(150_000) // 0.15 secs, bigger than default 0.1 but smaller than custom 0.2.
        XCTAssertEqual(token, "abc")
        usleep(250_000)
        XCTAssertNil(token)
    }
    
    func testInitWithExistingExpiredToken() {
        let pastDate = Date().addingTimeInterval(-0.2)
        $token = Expirable<String>(initialValue: "abc", expirationDate: pastDate, duration: 0.1)
        XCTAssertNil(token)
    }
    
    func testSetWithCustomDate() {
        $token.set("abc", expirationDate: Date().addingTimeInterval(0.2))
        XCTAssertEqual(token, "abc")
        usleep(150_000) // 0.15 secs, bigger than default 0.1 but smaller than custom 0.2.
        XCTAssertEqual(token, "abc")
        usleep(250_000)
        XCTAssertNil(token)
    }
    
    static var allTests = [
        ("testGet", testGet),
        ("testGetExpired", testGetExpired),
        ("testSet", testSet),
        ("testIsValid", testIsValid),
        ("testIsValidExpired", testIsValidExpired),
        ("testInitWithExistingValidToken", testInitWithExistingValidToken),
        ("testInitWithExistingExpiredToken", testInitWithExistingExpiredToken),
        ("testSetWithCustomDate", testSetWithCustomDate),
    ]
}
