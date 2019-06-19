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
    
    static var style: UserInterfaceStyle = .light
        
    override func setUp() {
        $backgroundColor = DynamicUIColor(
            light: .white,
            dark: .black,
            userInterfaceStyle: DynamicUIColorTests.style
        )
    }
    
    func testGetLight() {
        DynamicUIColorTests.style = .light
        XCTAssertEqual(backgroundColor, UIColor.white)
    }
    
    func testGetDark() {
        DynamicUIColorTests.style = .dark
        XCTAssertEqual(backgroundColor, UIColor.black)
    }
    
    static var allTests = [
        ("testGetLight", testGetLight),
        ("testGetDark", testGetDark),
    ]
}

#endif
