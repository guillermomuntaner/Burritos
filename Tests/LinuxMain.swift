import XCTest

import AtomicWriteTests
import ClampingTests
import CopyingTests
import ExpirableTests
import LateInitTests
import LazyTests
import UndoRedoTests
import UserDefaultTests

var tests = [XCTestCaseEntry]()
tests += AtomicWriteTests.allTests()
tests += ClampingTests.allTests()
tests += CopyingTests.allTests()
// DynamicUIColor is only supported in iOS (UIKit)
tests += ExpirableTests.allTests()
tests += LateInitTests.allTests()
tests += LazyTests.allTests()
tests += UndoRedoTests.allTests()
tests += UserDefaultTests.allTests()

XCTMain(tests)
