//
//  DefaultValueTests.swift
//  DefaultValueTests
//
//  Created by Evgeniy (@own2pwn) on 28/06/2019.
//  Copyright © 2019 Wicked. All rights reserved.
//

@testable import DefaultValue
import XCTest

final class DefaultValueTests: XCTestCase {
    // MARK: - Members

    private static let defaultValue: Double = 4

    @DefaultValue(value: DefaultValueTests.defaultValue)
    var dummy: Double?

    @DefaultValue(value: ComplextType.Default)
    var complextType: ComplextType?

    // MARK: - Tests

    func testGetDefaultValue() {
        let expected: Double = DefaultValueTests.defaultValue
        let actual: Double = $dummy.value

        XCTAssertEqual(actual, expected)
    }

    func testGet() {
        dummy = 5
        let expected: Double = 5
        let actual: Double = $dummy.value

        XCTAssertEqual(actual, expected)
    }

    func testSet() {
        $dummy.value = 6
        let expected: Double = 6
        let actual: Double = $dummy.value

        XCTAssertEqual(actual, expected)
    }

    func testDirect() {
        $dummy.value = 7
        let expected: Double = 7
        let actual: Double? = dummy
        XCTAssertEqual(actual, expected)

        dummy = nil
        XCTAssertEqual($dummy.value, DefaultValueTests.defaultValue)

        $dummy.value = nil
        XCTAssertEqual($dummy.value, DefaultValueTests.defaultValue)
    }

    func testComplextType() {
        let expectedInt: Int = 1
        let expectedStr: String = "2"

        let complexValue: ComplextType = $complextType.value
        let actualInt: Int = complexValue.intVar
        let actualStr: String = complexValue.strVar

        XCTAssertEqual(actualInt, expectedInt)
        XCTAssertEqual(actualStr, expectedStr)
    }

    // MARK: - Helpers

    static var allTests = [
        ("testGetDefaultValue", testGetDefaultValue),
        ("testGet", testGet),
        ("testSet", testSet),
        ("testDirect", testDirect),
        ("testComplextType", testComplextType),
    ]
}

struct ComplextType {
    let intVar: Int
    let strVar: String

    static let Default: ComplextType = {
        ComplextType(intVar: 1, strVar: "2")
    }()
}
