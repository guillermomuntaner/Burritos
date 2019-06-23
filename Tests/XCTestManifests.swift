import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AtomicWriteTests.allTests),
        testCase(ClampingTests.allTests),
        testCase(CopyingTests.allTests),
        testCase(DefaultValueTests.allTests),
        #if canImport(UIKit) {
            testCase(DynamicUIColor.allTests),
        }
        testCase(EnvironmentVariableTests.allTests),
        testCase(ExpirableTests.allTests),
        testCase(LateInitTests.allTests),
        testCase(LazyTests.allTests),
        testCase(LazyConstantTests.allTests),
        testCase(StackTests.allTests),
        testCase(UndoRedoTests.allTests),
        testCase(UserDefaultTests.allTests),
    ]
}
#endif
