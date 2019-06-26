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
        $text = LazyConstant(initialValue: "Hello, World!")
    }
    
    func testLazyInternalStorage() {
        XCTAssertNil($text.storage)
    }
    
    func testGet() {
        XCTAssertEqual(text, "Hello, World!")
        XCTAssertEqual($text.storage, "Hello, World!")
    }
    
    func testReset() {
        _ = text // Force init
        
        $text.reset()
        XCTAssertNil($text.storage)
    }
    
    // MARK : LazyConstant
    
    static var allTests = [
        ("testLazyInternalStorage", testLazyInternalStorage),
        ("testGet", testGet),
        ("testReset", testReset),
    ]
}
