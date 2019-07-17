//
//  File.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 23/06/2019.
//

import Foundation

/// A property wrapper arround a value that can expire.
///
/// Getting the value after given duration or expiration date will return nil.
///
/// Usage:
/// ```
/// @Expirable(duration: 60)
/// var apiToken: String?
///
/// // New values will be valid for 60s
/// apiToken = "123456abcd"
/// print(apiToken) // "123456abcd"
/// sleep(61)
/// print(apiToken) // nil
///
/// // You can also construct an expirable with an initial value and expiration date:
/// @Expirable(initialValue: "zyx987", expirationDate: date, duration: 60)
/// var apiToken: String?
/// // or just update an existing one:
/// _apiToken.set("zyx987", expirationDate: date)
/// ```
///
/// [Courtesy of @v_pradeilles](https://twitter.com/v_pradeilles)
@propertyWrapper
public struct Expirable<Value> {
    
    let duration: TimeInterval
    
    /// Stores a value toguether with its expiration date.
    var storage: (value: Value, expirationDate: Date)?
    
    /// Instantiate the wrapper with no initial value.
    public init(duration: TimeInterval) {
        self.duration = duration
        storage = nil
    }
    
    /// Instantiate the wrapper with an initial value and its expiration date, toguether with a duration.
    ///
    /// This method is meant to be used when a value is restored from some form of persistent storage and the expiration
    /// is well known and doesn't depend on the current date. It is perfectly fine to pass an expiration date in the past; the
    /// wrapper will simply treat the initial value as expired inmediatly.
    ///
    /// The duration will be ignored for this initial value but will be used as soon as a new value is set.
    public init(initialValue: Value, expirationDate: Date, duration: TimeInterval) {
        self.duration = duration
        storage = (initialValue, expirationDate)
    }
    
    public var wrappedValue: Value? {
        get {
            isValid ? storage?.value : nil
        }
        set {
            storage = newValue.map { newValue in
                let expirationDate = Date().addingTimeInterval(duration)
                return (newValue, expirationDate)
            }
        }
    }
    
    /// A Boolean value that indicates whether the expirable value is still valid or has expired.
    public var isValid: Bool {
        guard let storage = storage else { return false }
        return storage.expirationDate >= Date()
    }
    
    /// Set a new value toguether with its expiration date.
    ///
    /// By calling this method the duration set while constructing the property wrapper will be ignored for this concrete new value.
    /// Setting a new value without using this method will revert back to use the duration to compute the expiration date.
    public mutating func set(_ newValue: Value, expirationDate: Date) {
        storage = (newValue, expirationDate)
    }
}
