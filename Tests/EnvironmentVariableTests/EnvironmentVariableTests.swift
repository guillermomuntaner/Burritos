//
//  EnvironmentVariableTests.swift
//  
//
//  Created by Luciano Almeida on 30/06/19.
//

import XCTest
@testable import EnvironmentVariable

final class EnvironmentVariableTests: XCTestCase {
    
    @EnvironmentVariable(name: "ENV_VAR") var envVar: String?
    
    func testGetAndSet() {
        XCTAssertNil(envVar)
        
        envVar = "ENV_VALUE"
        XCTAssertEqual(envVar, "ENV_VALUE")
    }
    
    func testSetNil() {
        envVar = "ENV_VALUE"
        XCTAssertEqual(envVar, "ENV_VALUE")
        
        envVar = nil
        XCTAssertNil(envVar)
    }
    
    static var allTests = [
        ("testGetAndSet", testGetAndSet),
        ("testSetNil", testSetNil)
    ]
}
