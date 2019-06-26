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
/// // The color will automatically update when traits change
/// view.backgroundColor = backgroundColor
/// ```
///
/// [Courtesy of @bardonadam](https://twitter.com/bardonadam)
@propertyDelegate
public struct DynamicUIColor {

    let light: UIColor
    let dark: UIColor

    public init(
        light: UIColor,
        dark: UIColor
    ) {
        self.light = light
        self.dark = dark
    }

    public var value: UIColor {
        if #available(iOS 13.0, tvOS 13.0, *) {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark: return self.dark
                case .light, .unspecified: return self.light
                @unknown default: return self.light
                }
            }
        } else {
            return light
        }
    }
}

#endif
