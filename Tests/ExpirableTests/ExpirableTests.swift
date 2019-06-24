//
//  ExpirableTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 23/06/2019.
//

import XCTest
@testable import Expirable

final class ExpirableTests: XCTestCase {
    
    @Expirable(duration: 1)
    var token: String?
    
    override func setUp() {
        token = "1234"
    }
    
    func testGet() {
        token = "1234"
        XCTAssertEqual(token, "1234")
    }
    
    func testGetExpired() {
        token = "1234"
        sleep(2)
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
        token = "1234"
        sleep(2)
        XCTAssertNil(token)
    }
    
    func testInitWithExistingValidToken() {
        let pastDate = Date().addingTimeInterval(2)
        $token = Expirable<String>(initialValue: "abc", expirationDate: pastDate, duration: 2)
        XCTAssertEqual(token, "abc")
        sleep(1)
        XCTAssertEqual(token, "abc")
        sleep(3)
        XCTAssertNil(token)
    }
    
    func testInitWithExistingExpiredToken() {
        let pastDate = Date().addingTimeInterval(-2)
        $token = Expirable<String>(initialValue: "abc", expirationDate: pastDate, duration: 2)
        XCTAssertNil(token)
    }
    
    func testSetWithCustomDate() {
        $token.set("abc", expirationDate: Date().addingTimeInterval(2))
        XCTAssertEqual(token, "abc")
        sleep(1)
        XCTAssertEqual(token, "abc")
        sleep(3)
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
