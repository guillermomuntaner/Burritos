//
//  LazyTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 16/06/2019.
//

import XCTest
@testable import Lazy

final class LazyTests: XCTestCase {
    
    @Lazy var text = "Hello, World!"
    
    override func setUp() {
        $text.storage = nil
    }
    
    func testLazyInternalStorage() {
        XCTAssertNil($text.storage)
    }
    
    func testGet() {
        XCTAssertEqual(text, "Hello, World!")
        XCTAssertEqual($text.storage, "Hello, World!")
    }
    
    func testSet() {
        text = "New text"
        
        XCTAssertEqual(text, "New text")
        XCTAssertEqual($text.storage, "New text")
    }
    
    static var allTests = [
        ("testLazyInternalStorage", testLazyInternalStorage),
        ("testGet", testGet),
        ("testSet", testSet),
    ]
}
