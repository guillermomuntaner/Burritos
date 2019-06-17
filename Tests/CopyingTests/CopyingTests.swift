//
//  CopyingTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 17/06/2019.
//

import XCTest
@testable import Copying

fileprivate class EmptyClass: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any { return EmptyClass() }
}

fileprivate let initialInstance = EmptyClass()

final class CopyingTests: XCTestCase {
    
    // MARK: testCopyOnDefaultInit
    
    @Copying private var copying1: EmptyClass = initialInstance
    
    func testCopyOnDefaultInit() {
        XCTAssert(copying1 !== initialInstance)
    }
    
    
    // MARK: testInitWithoutCopying
    
    @Copying(withoutCopying: initialInstance)
    private var copying2: EmptyClass
    
    func testInitWithoutCopying() {
        XCTAssert(copying2 === initialInstance)
    }
    
    
    // MARK: testCopyOnReassign
    
    @Copying private var copying3: EmptyClass = EmptyClass()
    
    func testCopyOnReassign() {
        let newInstance = EmptyClass()
        copying3 = newInstance
        XCTAssert(copying3 !== newInstance)
    }
    
    
    // MARK: testGetWithoutCopying
    
    @Copying private var copying4: EmptyClass = EmptyClass()
    
    func testGetWithoutCopying() {
        let newInstance = EmptyClass()
        $copying4.storage = newInstance
        XCTAssert(copying4 === newInstance)
    }
    
    
    // MARK: - allTests
    
    static var allTests = [
        ("testCopyOnDefaultInit", testCopyOnDefaultInit),
        ("testInitWithoutCopying", testInitWithoutCopying),
        ("testCopyOnReassign", testCopyOnReassign),
        ("testGetWithoutCopying", testGetWithoutCopying),
    ]
}
