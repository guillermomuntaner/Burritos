//
//  StackTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 23/06/2019.
//

import XCTest
@testable import Stack

final class StackTests: XCTestCase {
    
    struct Sample: Equatable {
        let value: Int
    }
    
    @Stack var sample = Sample(value: 0)
    
    override func setUp() {
        $sample = Stack<Sample>(initialValue: Sample(value: 0))
    }
    
    // MARK: Property wrapper
    
    func testGet() {
        XCTAssertEqual(sample, Sample(value: 0))
    }
    
    func testGetNil() {
        _ = $sample.pop()
        XCTAssertEqual(sample, nil)
    }
    
    func testSet() {
        // NOTE: - Direct set results in segmentation fault
        // sample = Sample(value: 1)
        $sample.wrappedValue = Sample(value: 1)
        XCTAssertEqual(sample, Sample(value: 1))
    }
    
    func testSetNil() {
        // NOTE: - Direct set results in segmentation fault
        // sample = nil
        $sample.wrappedValue = nil
        XCTAssertEqual(sample, Sample(value: 0))
    }
    
    // MARK: Stack API: Push - Pop - Peek
    
    func testPush() {
        $sample.push(Sample(value: 1))
        XCTAssertEqual(sample, Sample(value: 1))
    }
    
    func testPop() {
        $sample.push(Sample(value: 1))
        XCTAssertEqual($sample.pop(), Sample(value: 1))
        XCTAssertEqual(sample, Sample(value: 0))
    }
    
    func testPopNil() {
        _ = $sample.pop()
        XCTAssertNil($sample.pop())
    }
    
    func testPeak() {
        $sample.push(Sample(value: 1))
        XCTAssertEqual($sample.peak(), Sample(value: 1))
        XCTAssertEqual($sample.peak(), Sample(value: 1))
    }
    
    
    static var allTests = [
        // Property wrapper
        ("testGet", testGet),
        ("testGetNil", testGetNil),
        ("testSet", testSet),
        ("testSetNil", testSetNil),
        // Stack API
        ("testPop", testPop),
        ("testPopNil", testPopNil),
        ("testPush", testPush),
        ("testPeak", testPeak),
    ]
}
