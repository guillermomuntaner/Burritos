//
//  EnvironmentVariable.swift
//  
//
//  Created by Luciano Almeida on 30/06/19.
//

import Foundation

/// A  property wrapper to set and get system's environment variables values.
///
/// ```
/// @EnvironmentVariable(name: "PATH")
/// var path: String?
///
/// // You can set the environment variable directly:
/// path = "~/opt/bin:" + path!
///
/// ```
///
/// Some related reads & inspiration:
/// [swift-evolution proposal](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md)
/// [Environment variables in Mac OSX](https://stackoverflow.com/a/4567308)
@propertyWrapper
public struct EnvironmentVariable {
    var name: String
    
    public var wrappedValue: String? {
        get {
            guard let pointer = getenv(name) else { return nil }
            return String(cString: pointer)
        }
        set {
            guard let value = newValue else {
                unsetenv(name)
                return
            }
            setenv(name, value, 1)
        }
    }
}
