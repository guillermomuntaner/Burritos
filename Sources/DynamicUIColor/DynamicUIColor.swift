//
//  DynamicUIColor.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 19/06/2019.
//  Original credit to @bardonadam
//

#if canImport(UIKit)

import UIKit

/// A property wrapper arround UIColor to  support dark mode.
///
/// Usage:
/// ```
/// @DynamicUIColor(light: .white, dark: .black)
/// var backgroundColor: UIColor
///
/// // Set the color every time traits change
/// view.backgroundColor = backgroundColor
/// ```
///
/// [Courtesy of @bardonadam](https://twitter.com/bardonadam)
@propertyDelegate
public struct DynamicUIColor {
    
    let light: UIColor
    let dark: UIColor
    let userInterfaceStyleProvider: () -> UserInterfaceStyle
    
    public init(
        light: UIColor,
        dark: UIColor,
        userInterfaceStyle: @autoclosure @escaping () -> UserInterfaceStyle = .current
    ) {
        self.light = light
        self.dark = dark
        self.userInterfaceStyleProvider = userInterfaceStyle
    }
    
    public var value: UIColor {
        switch userInterfaceStyleProvider() {
        case .light: return light
        case .dark: return dark
        }
    }
}

/// Backwards compatible wrapper arround UIUserInterfaceStyle
public enum UserInterfaceStyle {
    case light, dark
    
    /// In iOS >=13 it returns `UITraitCollection.current.userInterfaceStyle` mapped to UserInterfaceStyle.
    /// In prior versions it returns .light.
    public static var current: UserInterfaceStyle  {
        #if os(iOS) || os(tvOS)
        if #available(iOS 13.0, tvOS 13.0, *) {
            return .init(style: UITraitCollection.current.userInterfaceStyle)
        } else {
            return .light
        }
        #else
        return .light
        #endif
    }
    
    #if os(iOS) || os(tvOS)
    @available(iOS 12.0, tvOS 10.0, *)
    init(style: UIUserInterfaceStyle) {
        switch style {
        case .light, .unspecified: self = .light
        case .dark: self = .dark
        @unknown default: self = .light
        }
    }
    #endif
}

#endif
