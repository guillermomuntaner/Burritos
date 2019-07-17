//
//  LateInitTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 17/06/2019.
//

import XCTest
@testable import LateInit

final class LateInitTests: XCTestCase {
    
    @LateInit var text: String
    
    override func setUp() {
        _text.storage = nil
    }
    
    func testInternalStorage() {
        XCTAssertNil(_text.storage)
    }
    
    func testGet() {
        // TODO: Test for fatalError() requires work.
    }
    
    func testSet() {
        text = "New text"
        
        XCTAssertEqual(text, "New text")
        XCTAssertEqual(_text.storage, "New text")
    }
    
    static var allTests = [
        ("testInternalStorage", testInternalStorage),
        ("testGet", testGet),
        ("testSet", testSet),
    ]
}
