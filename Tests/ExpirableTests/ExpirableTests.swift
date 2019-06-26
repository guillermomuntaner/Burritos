//
//  ExpirableTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 23/06/2019.
//

import XCTest
@testable import Expirable

final class ExpirableTests: XCTestCase {
    
    @Expirable(duration: 0.2)
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
        Thread.sleep(forTimeInterval: 0.3)
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
        Thread.sleep(forTimeInterval: 0.3)
        XCTAssertNil(token)
    }
    
    func testInitWithExistingValidToken() {
        let expirationDate = Date().addingTimeInterval(0.2)
        $token = Expirable<String>(initialValue: "abc", expirationDate: expirationDate, duration: 0.2)
        XCTAssertEqual(token, "abc")
        Thread.sleep(forTimeInterval: 0.1)
        XCTAssertEqual(token, "abc")
        Thread.sleep(forTimeInterval: 0.3)
        XCTAssertNil(token)
    }
    
    func testInitWithExistingExpiredToken() {
        let pastDate = Date().addingTimeInterval(-0.1)
        $token = Expirable<String>(initialValue: "abc", expirationDate: pastDate, duration: 0.2)
        XCTAssertNil(token)
    }
    
    func testSetWithCustomDate() {
        $token.set("abc", expirationDate: Date().addingTimeInterval(0.2))
        XCTAssertEqual(token, "abc")
        Thread.sleep(forTimeInterval: 0.1)
        XCTAssertEqual(token, "abc")
        Thread.sleep(forTimeInterval: 0.3)
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
