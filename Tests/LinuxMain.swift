import XCTest

import AtomicWriteTests
import ClampingTests
import CopyingTests
import DefaultValueTests
import EnvironmentVariableTests
import ExpirableTests
import LateInitTests
import LazyTests
import UndoRedoTests
import UserDefaultTests

var tests = [XCTestCaseEntry]()
tests += AtomicWriteTests.allTests()
tests += ClampingTests.allTests()
tests += CopyingTests.allTests()
tests += DefaultValueTests.allTests()
// DynamicUIColor is only supported in iOS (UIKit)
tests += EnvironmentVariableTests.allTests()
tests += ExpirableTests.allTests()
tests += LateInitTests.allTests()
tests += LazyTests.allTests()
tests += LazyConstantTests.allTests()
tests += UndoRedoTests.allTests()
tests += UserDefaultTests.allTests()

XCTMain(tests)
