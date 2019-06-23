//
//  UndoRedoTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 23/06/2019.
//

import XCTest
@testable import UndoRedo

final class UndoRedoTests: XCTestCase {
    
    @UndoRedo var text = "Hello, World!"
    
    override func setUp() {
        $text = UndoRedo<String>(initialValue: "Hello, World!")
    }
    
    func testGet() {
        XCTAssertEqual(text, "Hello, World!")
    }
    
    func testSet() {
        text = "Hello"
        XCTAssertEqual(text, "Hello")
    }
    
    // MARK: Undo
    
    func testCanUndo() {
        text = "Hello"
        XCTAssertTrue($text.canUndo)
        XCTAssertEqual(text, "Hello")
    }
    
    func testUndo() {
        text = "Hello"
        XCTAssertTrue($text.undo())
        XCTAssertEqual(text, "Hello, World!")
    }
    
    func testCannotUndoFirstValue() {
        text = "Hello"
        $text.undo()
        XCTAssertEqual(text, "Hello, World!")
        XCTAssertFalse($text.canUndo)
        XCTAssertFalse($text.undo())
        XCTAssertEqual(text, "Hello, World!")
    }
    
    // MARK: Redo
    
    func testCanRedo() {
        text = "Hello"
        $text.undo()
        XCTAssertTrue($text.canRedo)
        XCTAssertEqual(text, "Hello, World!")
    }
    
    func testRedo() {
        text = "Hello"
        $text.undo()
        XCTAssertEqual(text, "Hello, World!")
        XCTAssertTrue($text.redo())
        XCTAssertEqual(text, "Hello")
    }
    
    func testCannotRedoLastValue() {
        text = "Hello"
        text = "Hello world"
        XCTAssertFalse($text.canRedo)
        XCTAssertFalse($text.redo())
    }
    
    func testCannotRedoAfterSettingValue() {
        text = "Hello"
        text = "Hello world"
        $text.undo() // text == "Hello"
        
        XCTAssertTrue($text.canRedo)
        
        text = "Hello world!"
        
        XCTAssertFalse($text.canRedo)
        XCTAssertFalse($text.redo())
    }
    
    // MARK: Others
    
    func testClearHistory() {
        text = "Hello, World"
        text = "Hello"
        text = "Hello world"
        text = "Hello world!"
        $text.undo() // text == "Hello world"
        $text.undo() // text == "Hello"
        $text.undo() // text == "Hello, World"
        $text.redo() // text == "Hello"
        
        XCTAssertEqual(text, "Hello")
        XCTAssertTrue($text.canUndo)
        XCTAssertTrue($text.canRedo)
        
        $text.cleanHistory()
        
        XCTAssertEqual(text, "Hello")
        XCTAssertFalse($text.canUndo)
        XCTAssertFalse($text.canRedo)
    }
    
    static var allTests = [
        ("testGet", testGet),
        ("testSet", testSet),
        // Undo
        ("testCanUndo", testCanUndo),
        ("testUndo", testUndo),
        ("testCannotUndoFirstValue", testCannotUndoFirstValue),
        // Redo
        ("testCanRedo", testCanRedo),
        ("testRedo", testRedo),
        ("testCannotRedoLastValue", testCannotRedoLastValue),
        ("testCannotRedoAfterSettingValue", testCannotRedoAfterSettingValue),
        // Others
        ("testClearHistory", testClearHistory),
    ]
}
