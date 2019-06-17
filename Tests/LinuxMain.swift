import XCTest

import BurritosTests

var tests = [XCTestCaseEntry]()
tests += LateInitTests.allTests()
tests += LazyTests.allTests()
tests += UserDefaultTests.allTests()
XCTMain(tests)
