import XCTest

import AtomicWriteTests
import ClampingTests
import CopyingTests
import DefaultValueTests
import EnvironmentVariableTests
import ExpirableTests
import LateInitTests
import LazyTests
import TrimmedTests
import UndoRedoTests
import UserDefaultTests
import ObservedTests

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
tests += Trimmed.allTests()
tests += UndoRedoTests.allTests()
tests += UserDefaultTests.allTests()
tests += ObservedTests.allTests()

XCTMain(tests)
