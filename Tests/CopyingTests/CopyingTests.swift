//
//  CopyingTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 17/06/2019.
//

import XCTest
@testable import Copying

final class CopyingTests: XCTestCase {
    
    class SomeClass: NSCopying {
        func copy(with zone: NSZone? = nil) -> Any { return SomeClass() }
    }
    
    let initialInstance = SomeClass()
    
    @Copying var instance: SomeClass = .init() // Dummy value
    
    override func setUp() {
        _instance = Copying(wrappedValue: initialInstance)
    }
    
    func testCopyOnDefaultInit() {
        XCTAssert(instance !== initialInstance)
    }
    
    func testInitWithoutCopying() {
        _instance = Copying(withoutCopying: initialInstance)
        XCTAssert(instance === initialInstance)
    }
    
    func testCopyOnReassign() {
        let newInstance = SomeClass()
        instance = newInstance
        XCTAssert(instance !== newInstance)
    }
    
    func testGetWithoutCopying() {
        let newInstance = SomeClass()
        _instance.storage = newInstance
        XCTAssert(instance === newInstance)
    }
    
    // MARK: - allTests
    
    static var allTests = [
        ("testCopyOnDefaultInit", testCopyOnDefaultInit),
        ("testInitWithoutCopying", testInitWithoutCopying),
        ("testCopyOnReassign", testCopyOnReassign),
        ("testGetWithoutCopying", testGetWithoutCopying),
    ]
}
