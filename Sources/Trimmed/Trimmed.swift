//
//  Trimmed.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 03/07/2019.
//
import Foundation

/// A wrapper arround a string that automatically trims both on initialization and reassignment.
///
/// By default it trimms white spaces and new lines, but the character set to use can be also passed during construction.
/// Usage:
/// ```
/// @Trimmed
/// var text = " \n Hello, World! \n\n    "
///
/// print(text) // "Hello, World!"
///
/// // By default trims white spaces and new lines, but it also supports any character set
/// @Trimmed(characterSet: .whitespaces)
/// var text = " \n Hello, World! \n\n    "
/// print(text) // "\n Hello, World! \n\n"
/// ```
@propertyWrapper
public struct Trimmed {
    private var storage: String!
    private let characterSet: CharacterSet
    
    public var wrappedValue: String {
        get { storage }
        set { storage = newValue.trimmingCharacters(in: characterSet) }
    }
    
    public init(initialValue: String) {
        self.characterSet = .whitespacesAndNewlines
        wrappedValue = initialValue
    }
    
    public init(initialValue: String, characterSet: CharacterSet) {
        self.characterSet = characterSet
        wrappedValue = initialValue
    }
}
