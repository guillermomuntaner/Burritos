import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AtomicWriteTests.allTests),
        testCase(CopyingTests.allTests),
        #if canImport(UIKit) {
            testCase(DynamicUIColor.allTests),
        }
        testCase(LateInitTests.allTests),
        testCase(LazyTests.allTests),
        testCase(UserDefaultTests.allTests),
    ]
}
#endif
