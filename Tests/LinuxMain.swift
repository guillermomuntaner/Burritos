import XCTest

import BurritosTests

var tests = [XCTestCaseEntry]()
tests += LazyTests.allTests()
tests += UserDefaultTests.allTests()
XCTMain(tests)
