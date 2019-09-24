//
//  ClampingTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 25/06/2019.
//

import XCTest
@testable import Clamping

final class ClampingTests: XCTestCase {
    
    @Clamping(range: 0...1)
    var alpha: Double = 0.3

    override func setUp() {
        alpha = 0.3
    }
    
    // MARK: Get

    func testGet() {
        XCTAssertEqual(alpha, 0.3)
    }

    // MARK: Init
    
    func testInitInRange() {
        _alpha = Clamping(wrappedValue: 0.5, range: 0...1)
        XCTAssertEqual(alpha, 0.5)
    }

    func testInitLessOrEqualThanLowerBound() {
        [-Double.greatestFiniteMagnitude, -1.0, 0.0].forEach { value in
            _alpha = Clamping(wrappedValue: value, range: 0...1)
            XCTAssertEqual(alpha, 0)
        }
    }

    func testInitBiggerOrEqualThanUpperBound() {
        [1.0, 1.5, Double.greatestFiniteMagnitude, Double.infinity].forEach { value in
            _alpha = Clamping(wrappedValue: value, range: 0...1)
            XCTAssertEqual(alpha, 1)
        }
    }

    // MARK: Set
    
    func testSetInRange() {
        alpha = 0.5
        XCTAssertEqual(alpha, 0.5)
    }

    func testSetLessOrEqualThanLowerBound() {
        [-Double.greatestFiniteMagnitude, -1.0, 0.0].forEach { value in
            alpha = value
            XCTAssertEqual(alpha, 0)
        }
    }

    func testSetBiggerOrEqualThanUpperBound() {
        [1.0, 1.5, Double.greatestFiniteMagnitude, Double.infinity].forEach { value in
            alpha = value
            XCTAssertEqual(alpha, 1)
        }
    }

    // MARK: Utils
    
    static var allTests = [
        ("testGet", testGet),
        ("testInitInRange", testInitInRange),
        ("testInitLessOrEqualThanLowerBound", testInitLessOrEqualThanLowerBound),
        ("testInitBiggerOrEqualThanUpperBound", testInitBiggerOrEqualThanUpperBound),
        ("testSetInRange", testSetInRange),
        ("testSetLessOrEqualThanLowerBound", testSetLessOrEqualThanLowerBound),
        ("testSetBiggerOrEqualThanUpperBound", testSetBiggerOrEqualThanUpperBound),
    ]
}
