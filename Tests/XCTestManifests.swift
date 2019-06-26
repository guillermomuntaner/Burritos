import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AtomicWriteTests.allTests),
        testCase(ClampingTests.allTests),
        testCase(CopyingTests.allTests),
        #if canImport(UIKit) {
            testCase(DynamicUIColor.allTests),
        }
        testCase(ExpirableTests.allTests),
        testCase(LateInitTests.allTests),
        testCase(LazyTests.allTests),
        testCase(UndoRedoTests.allTests),
        testCase(UserDefaultTests.allTests),
    ]
}
#endif
