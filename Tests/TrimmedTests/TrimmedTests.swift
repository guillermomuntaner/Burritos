//
//  TrimmedTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 03/07/2019.
//

import XCTest
@testable import Trimmed

final class TrimmedTests: XCTestCase {
    
    @Trimmed var text = "   Hello, World! \n   \n"
    
    override func setUp() {
        $text = Trimmed(initialValue: "   Hello, World! \n   \n")
    }
    
    func testGet() {
        XCTAssertEqual(text, "Hello, World!")
    }
    
    func testSet() {
        text = " \n Hi       \n"
        XCTAssertEqual(text, "Hi")
    }
    
    func testCustomCharacterSet() {
        $text = Trimmed(initialValue: "", characterSet: CharacterSet(charactersIn: "abcde"))
        text = "abcdeHello World!abcde"
        XCTAssertEqual(text, "Hello World!")
    }
    
    static var allTests = [
        ("testGet", testGet),
        ("testSet", testSet),
        ("testCustomCharacterSet", testCustomCharacterSet),
    ]
}
