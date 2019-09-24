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
        _text = Lazy(wrappedValue: "Hello, World!")
    }
    
    func testLazyInternalStorage() {
        XCTAssertNil(_text.storage)
    }
    
    func testGet() {
        XCTAssertEqual(text, "Hello, World!")
        XCTAssertEqual(_text.storage, "Hello, World!")
    }
    
    func testSet() {
        text = "New text"
        
        XCTAssertEqual(text, "New text")
        XCTAssertEqual(_text.storage, "New text")
    }
    
    func testReset() {
        _ = text // Force init
        
        _text.reset()
        XCTAssertNil(_text.storage)
    }
    
    static var allTests = [
        ("testLazyInternalStorage", testLazyInternalStorage),
        ("testGet", testGet),
        ("testSet", testSet),
        ("testReset", testReset),
    ]
}
