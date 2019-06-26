//
//  DynamicUIColorTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 19/06/2019.
//

#if canImport(UIKit)
import UIKit
import XCTest
@testable import DynamicUIColor

final class DynamicUIColorTests: XCTestCase {

    @DynamicUIColor(light: .white, dark: .black)
    var backgroundColor: UIColor

    func testGetLight() {
        if #available(iOS 13, tvOS 13, *) {
            let lightTrait = UITraitCollection(userInterfaceStyle: .light)
            XCTAssertEqual(backgroundColor.resolvedColor(with: lightTrait), .white)
        }
    }

    func testGetDark() {
        if #available(iOS 13, tvOS 13, *) {
            let darkTrait = UITraitCollection(userInterfaceStyle: .dark)
            XCTAssertEqual(backgroundColor.resolvedColor(with: darkTrait), .black)
        }
    }

    func testLessThaniOS13() {
        if #available(iOS 13, tvOS 13, *) {} else {
            XCTAssertEqual(backgroundColor, .white)
        }
    }

    static var allTests = [
        ("testGetLight", testGetLight),
        ("testGetDark", testGetDark),
        ("testLessThaniOS13", testLessThaniOS13),
    ]
}

#endif
