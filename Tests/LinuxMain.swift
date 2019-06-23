import XCTest

import AtomicWriteTests
import CopyingTests
import LateInitTests
import LazyTests
import UndoRedoTests
import UserDefaultTests

var tests = [XCTestCaseEntry]()
tests += AtomicWriteTests.allTests()
tests += CopyingTests.allTests()
// DynamicUIColor is only supported in iOS (UIKit)
tests += LateInitTests.allTests()
tests += LazyTests.allTests()
tests += UndoRedoTests.allTests()
tests += UserDefaultTests.allTests()

XCTMain(tests)
