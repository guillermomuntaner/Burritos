//
//  DynamicUIColor.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 19/06/2019.
//  Original credit to @bardonadam
//

#if canImport(UIKit)

import UIKit

/// A property wrapper arround UIColor to support dark mode.
///
/// By default in iOS >= 13 it uses the new system wide user interface style trait and dynamic
/// UIColor constructor to support dark mode without any extra effort.
/// On prior iOS versions it defaults to light.
/// ```
/// @DynamicUIColor(light: .white, dark: .black)
/// var backgroundColor: UIColor
///
/// // The color will automatically update when traits change
/// view.backgroundColor = backgroundColor
/// ```
///
/// To support older iOS versions  and custom logics (e.g. a switch in your app settings) the
/// constructor can take an extra `style` closure that dynamically dictates which
/// color to use. Returning a `nil` value results in the prior default behaviour. This logic
/// allows easier backwards compatiblity by doing:
/// ```
/// let color = DynamicUIColor(light: .white, dark: .black) {
///     if #available(iOS 13.0, *) { return nil }
///     else { return Settings.isDarkMode ? .dark : .light }
/// }
///
/// view.backgroundColor = color.value
///
/// // On iOS <13 you might need to manually observe your custom dark
/// // mode settings & re-bind your colors on changes:
/// if #available(iOS 13.0, *) {} else {
///     Settings.onDarkModeChange { [weak self] in
///         self?.view.backgroundColor = self?.color.value
///     }
/// }
/// ```
///
/// [Courtesy of @bardonadam](https://twitter.com/bardonadam)
@propertyWrapper
public struct DynamicUIColor {

    /// Backwards compatible wrapper arround UIUserInterfaceStyle
    public enum Style {
        case light, dark
    }
    
    let light: UIColor
    let dark: UIColor
    let styleProvider: () -> Style?

    public init(
        light: UIColor,
        dark: UIColor,
        style: @autoclosure @escaping () -> Style? = nil
    ) {
        self.light = light
        self.dark = dark
        self.styleProvider = style
    }

    public var wrappedValue: UIColor {
        switch styleProvider() {
        case .dark: return dark
        case .light: return light
        case .none:
            // UIColor(dynamicProvider:) only available on iOS >=13+ & tvOS >=13
            #if os(iOS) || os(tvOS)
            if #available(iOS 13.0, tvOS 13.0, *) {
                return UIColor { traitCollection -> UIColor in
                    switch traitCollection.userInterfaceStyle {
                    case .dark: return self.dark
                    case .light, .unspecified: return self.light
                    @unknown default: return self.light
                    }
                }
            } else {
                return light
            }
            #else
            return light
            #endif
        }
    }
}

#endif
