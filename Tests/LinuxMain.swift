import XCTest

import BurritosTests

var tests = [XCTestCaseEntry]()
tests += LazyTests.allTests()
XCTMain(tests)
