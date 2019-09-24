//
//  File.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 26/06/2019.
//

import XCTest
@testable import LazyConstant

final class LazyConstantTests: XCTestCase {
    
    @LazyConstant var text = "Hello, World!"
    
    override func setUp() {
        _text = LazyConstant(wrappedValue: "Hello, World!")
    }
    
    func testLazyInternalStorage() {
        XCTAssertNil(_text.storage)
    }
    
    func testGet() {
        XCTAssertEqual(text, "Hello, World!")
        XCTAssertEqual(_text.storage, "Hello, World!")
    }
    
    func testReset() {
        _ = text // Force init
        
        _text.reset()
        XCTAssertNil(_text.storage)
    }
    
    // MARK : LazyConstant
    
    static var allTests = [
        ("testLazyInternalStorage", testLazyInternalStorage),
        ("testGet", testGet),
        ("testReset", testReset),
    ]
}
