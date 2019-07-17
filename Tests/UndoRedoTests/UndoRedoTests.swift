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
        _text = UndoRedo<String>(initialValue: "Hello, World!")
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
        XCTAssertTrue(_text.canUndo)
        XCTAssertEqual(text, "Hello")
    }
    
    func testUndo() {
        text = "Hello"
        XCTAssertTrue(_text.undo())
        XCTAssertEqual(text, "Hello, World!")
    }
    
    func testCannotUndoFirstValue() {
        text = "Hello"
        _text.undo()
        XCTAssertEqual(text, "Hello, World!")
        XCTAssertFalse(_text.canUndo)
        XCTAssertFalse(_text.undo())
        XCTAssertEqual(text, "Hello, World!")
    }
    
    // MARK: Redo
    
    func testCanRedo() {
        text = "Hello"
        _text.undo()
        XCTAssertTrue(_text.canRedo)
        XCTAssertEqual(text, "Hello, World!")
    }
    
    func testRedo() {
        text = "Hello"
        _text.undo()
        XCTAssertEqual(text, "Hello, World!")
        XCTAssertTrue(_text.redo())
        XCTAssertEqual(text, "Hello")
    }
    
    func testCannotRedoLastValue() {
        text = "Hello"
        text = "Hello world"
        XCTAssertFalse(_text.canRedo)
        XCTAssertFalse(_text.redo())
    }
    
    func testCannotRedoAfterSettingValue() {
        text = "Hello"
        text = "Hello world"
        _text.undo() // text == "Hello"
        
        XCTAssertTrue(_text.canRedo)
        
        text = "Hello world!"
        
        XCTAssertFalse(_text.canRedo)
        XCTAssertFalse(_text.redo())
    }
    
    // MARK: Others
    
    func testClearHistory() {
        text = "Hello, World"
        text = "Hello"
        text = "Hello world"
        text = "Hello world!"
        _text.undo() // text == "Hello world"
        _text.undo() // text == "Hello"
        _text.undo() // text == "Hello, World"
        _text.redo() // text == "Hello"
        
        XCTAssertEqual(text, "Hello")
        XCTAssertTrue(_text.canUndo)
        XCTAssertTrue(_text.canRedo)
        
        _text.cleanHistory()
        
        XCTAssertEqual(text, "Hello")
        XCTAssertFalse(_text.canUndo)
        XCTAssertFalse(_text.canRedo)
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
