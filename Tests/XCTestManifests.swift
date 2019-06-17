import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(LateInitTests.allTests),
        testCase(LazyTests.allTests),
        testCase(UserDefaultTests.allTests),
    ]
}
#endif
