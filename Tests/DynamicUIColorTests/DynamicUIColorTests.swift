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

    static var style: DynamicUIColor.Style = .light
    
    func testGetWithDefaultStyle() {
        _backgroundColor = DynamicUIColor(light: .white, dark: .black)
        
        if #available(iOS 13, tvOS 13, *) {
            let lightTrait = UITraitCollection(userInterfaceStyle: .light)
            XCTAssertEqual(backgroundColor.resolvedColor(with: lightTrait), .white)
            let darkTrait = UITraitCollection(userInterfaceStyle: .dark)
            XCTAssertEqual(backgroundColor.resolvedColor(with: darkTrait), .black)
        } else {
            XCTAssertEqual(backgroundColor, .white)
        }
    }
    
    func testGetWithNilStyle() {
        _backgroundColor = DynamicUIColor(light: .white, dark: .black, style: nil)
        
        if #available(iOS 13, tvOS 13, *) {
            let lightTrait = UITraitCollection(userInterfaceStyle: .light)
            XCTAssertEqual(backgroundColor.resolvedColor(with: lightTrait), .white)
            let darkTrait = UITraitCollection(userInterfaceStyle: .dark)
            XCTAssertEqual(backgroundColor.resolvedColor(with: darkTrait), .black)
        } else {
            XCTAssertEqual(backgroundColor, .white)
        }
    }
    
    func testGetWithCustomStyle() {
        _backgroundColor = DynamicUIColor(light: .white, dark: .black, style: DynamicUIColorTests.style)
        
        DynamicUIColorTests.style = .light
        XCTAssertEqual(backgroundColor, .white)
        
        DynamicUIColorTests.style = .dark
        XCTAssertEqual(backgroundColor, .black)
    }

    static var allTests = [
        ("testGetWithDefaultStyle", testGetWithDefaultStyle),
        ("testGetWithNilStyle", testGetWithNilStyle),
        ("testGetWithCustomStyle", testGetWithCustomStyle),
    ]
}

#endif
