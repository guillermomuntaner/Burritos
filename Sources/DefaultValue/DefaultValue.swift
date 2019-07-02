//
//  DefaultValue.swift
//  Burritos
//
//
//  Created by Evgeniy (@own2pwn) on 28/06/2019.
//

/// A property wrapper arround an implicitly unwrapped optional value which fallbacks to a given default value.
///
/// Seting `nil` will reset  the property to the default value. The wrapper will always return non-null value,
/// thanks to the granted default value.
/// Usage:
///
/// ```swift
/// @DefaultValue(default: 0)
/// var count
/// count = 100
/// // or
/// @DefaultValue(default: 0)
/// var count = 100
///
/// // Assigning nil resets to the default value
/// print(count) // 100
/// count = nil
/// print(count) // 0
/// ```
///
/// - Note: Since this wrapper relies on an implicitly unwrapped optional, using optionals as the wrapper type is
/// discouraged since they will be flattered. Getting the value is always a flat implicit unwrapped optional and assigning
/// `nil` is always reseting to the default value. Two levels of optionality need to be nested in order to be able to store
/// null values.
@propertyWrapper
public struct DefaultValue<Value> {
    // MARK: - Members

    private var storage: Value?

    private let defaultValue: Value

    // MARK: - Property wrapper interface

    public var wrappedValue: Value! {
        get {
            if let unboxed = storage {
                return unboxed
            }

            return defaultValue
        }
        set {
            storage = newValue
        }
    }

    // MARK: - Init
    
    public init(initialValue: Value? = nil, default: Value) {
        defaultValue = `default`
        storage = initialValue
    }
    
    // MARK: - Public API
    
    /// Resets the wrapper to its default value.  This is equivalent to setting nil.
    public mutating func reset() {
        storage = nil
    }
}
