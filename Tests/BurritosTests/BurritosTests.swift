import XCTest
@testable import Burritos

final class BurritosTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Burritos().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
