# Contributing Guidelines

Feel free to open pull requests to add new property wrappers (aka burritos!). In order to keep the project organized please follow those guidelines:
* 1 pull request for 1 property wrapper.
* Include a test for your wrapper covering, at least, its basic get/set logic.
* Follow the folder structure and name convention of:
   * `Sources/{PropertyWrapperStructName}/{PropertyWrapperStructName}.swift`
   * `Tests/{PropertyWrapperStructName}Tests/{PropertyWrapperStructName}Tests.swift`
* Add a `static var allTests = []` to your `XCTestCase` with references to your tests. Reference this property from both `LinuxMain.swift` and `XCTestManifests.swift`.
* Configure the `Package.swift` manifest with a new `.target` and `.testTarget`. Add the target to the library inside products.
* Update the `README.md` with a new section including a description and sample usage.

Feel free to open issues or pull requests for any other bug, improvement or fix.

Thank you.
