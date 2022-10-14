//
//  MappingSetterTests.swift
//  
//
//  Created by Roman Podymov on 16/10/2019.
//

import XCTest
@testable import MappingSetter

final class MappingSetterTests: XCTestCase {

    @MappingSetter(mappingSetter: { $0.trimmingCharacters(in: .whitespacesAndNewlines) })
    var trimmed: String = "   Hello, World! \n   \n"

    @MappingSetter(mappingSetter: { String($0.prefix(5)) })
    var upToFive: String = "Hello, World!"

    @MappingSetter(mappingSetter: { $0 })
    var unmodified: String = "Hello, "

    @MappingSetter(mappingSetter: { abs($0) })
    var absDouble = -100.0

    @MappingSetter(mappingSetter: { $0.filter { $0 < 10 } })
    var lessThanTen = [1, 2, 14, 20, 5, 30]

    func testTrimmed() {
        trimmed += "\n \n"
        XCTAssertEqual(trimmed, "Hello, World!")
    }

    func testUpToFive() {
        upToFive += "\n \n"
        XCTAssertEqual(upToFive, "Hello")
    }

    func testUnmodified() {
        unmodified += "World!"
        XCTAssertEqual(unmodified, "Hello, World!")
    }

    func testAbsDouble() {
        absDouble += 50
        XCTAssertEqual(absDouble, 150)
    }

    func testLessThanTen() {
        lessThanTen += [8, 9, 50, 4]
        XCTAssertEqual(lessThanTen, [1, 2, 5, 8, 9, 4])
    }

    static var allTests = [
        ("testTrimmed", testTrimmed),
        ("testUpToFive", testUpToFive),
        ("testUnmodified", testUnmodified),
        ("testAbsDouble", testAbsDouble),
        ("testLessThanTen", testLessThanTen),
    ]
}
