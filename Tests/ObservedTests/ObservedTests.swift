//
//  ObservedTests.swift
//  Burritos-FrameworkTests
//
//  Created by Thibault Wittemberg on 2019-07-14.
//  Copyright © 2019 Thibault Wittemberg. All rights reserved.
//

import XCTest
@testable import Observed

private struct User: Equatable {
    var name: String
    var age: Int
}

private class IntObserver: Observer {
    
    var hasUpdated = false
    var value = 0
    
    func update(value: Int) {
        self.hasUpdated = true
        self.value = value
    }
}

private class UserObserver: Observer {
    
    var numberOfUpdateCalls = 0
    var value: User?
    
    func update(value: User) {
        self.numberOfUpdateCalls += 1
        self.value = value
    }
}

final class ObservedTests: XCTestCase {
    
    @Observed
    private var index = 0
    
    @Observed
    fileprivate var user = User(name: "john doe", age: 20)
    
    override func setUp() {
        super.setUp()
        self.index = 0
        self.user = User(name: "john doe", age: 20)
    }
    
    override func tearDown() {
        self.index = 0
        self.user = User(name: "john doe", age: 20)
        super.tearDown()
    }
    
    func testObserver_isCalled() {
        
        // Given: a IntObserver, observing a int property
        let intObserver = IntObserver()
        $index.add(observer: intObserver.toAnyObserver())
        
        // When: mutating the int property
        self.index = 10
        
        // Then: the observer has been notified
        XCTAssertTrue(intObserver.hasUpdated)
        XCTAssertEqual(10, intObserver.value)
        XCTAssertEqual(10, self.index)
    }
    
    func testObserver_isNotCalled_whenObserverHasBeenRemoved() {
        
        // Given: a IntObserver, observing a int property and then unregistered from observation
        let intObserver = IntObserver()
        let anyObserver = intObserver.toAnyObserver()
        $index.add(observer: anyObserver)
        $index.remove(observer: anyObserver)
        
        // When: mutating the int property
        self.index = 10
        
        // Then: the observer has not been notified
        XCTAssertFalse(intObserver.hasUpdated)
        XCTAssertEqual(0, intObserver.value)
        XCTAssertEqual(10, self.index)
    }
    
    func testObserver_isCalled_forComplexTypes() {
        
        // Given: a UserObserver, observing a user property
        let userObserver = UserObserver()
        $user.add(observer: userObserver.toAnyObserver())
        
        // When: mutating the user property
        self.user.name = "jane doe"
        self.user.age = 30
        
        // Then: the observer has been notified 2 times
        XCTAssertEqual(userObserver.numberOfUpdateCalls, 2)
        XCTAssertEqual(User(name: "jane doe", age: 30), userObserver.value)
        XCTAssertEqual("jane doe", self.user.name)
        XCTAssertEqual(30, self.user.age)
    }
    
    static var allTests = [
        ("testObserver_isCalled", testObserver_isCalled),
        ("testObserver_isNotCalled_whenObserverHasBeenRemoved", testObserver_isNotCalled_whenObserverHasBeenRemoved),
        ("testObserver_isCalled_forComplexTypes", testObserver_isCalled_forComplexTypes)
    ]
}
