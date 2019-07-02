//
//  Lazy.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 16/06/2019.
//

/// A property wrapper which delays instantiation until first read access.
///
/// It is a reimplementation of Swift `lazy` modifier using a property wrapper.
/// As an extra on top of `lazy` it offers reseting the wrapper to its "uninitialized" state.
///
/// Usage:
/// ```
/// @Lazy var result = expensiveOperation()
/// ...
/// print(result) // expensiveOperation() is executed at this point
/// ```
///
/// As an extra on top of `lazy` it offers reseting the wrapper to its "uninitialized" state.
@propertyWrapper
public struct Lazy<Value> {
    
    var storage: Value?
    let constructor: () -> Value
    
    /// Creates a lazy property with the closure to be executed to provide an initial value once the wrapped property is first accessed.
    ///
    /// This constructor is automatically used when assigning the initial value of the property, so simply use:
    ///
    ///     @Lazy var text = "Hello, World!"
    ///
    public init(initialValue constructor: @autoclosure @escaping () -> Value) {
        self.constructor = constructor
    }
    
    public var wrappedValue: Value {
        mutating get {
            if storage == nil {
                self.storage = constructor()
            }
            return storage!
        }
        set {
            storage = newValue
        }
    }
    
    // MARK: Utils
    
    /// Resets the wrapper to its initial state. The wrapped property will be initialized on next read access.
    public mutating func reset() {
        storage = nil
    }
}
