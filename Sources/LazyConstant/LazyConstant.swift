//
//  LazyConstant.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 26/06/2019.
//

/// A property wrapper which delays instantiation until first read access and prevents
/// changing or mutating its wrapped value.
///
/// Usage:
/// ```
/// @Lazy var result = expensiveOperation()
/// ...
/// print(result) // expensiveOperation() is executed at this point
///
/// result = newResult // Compiler error
/// ```
///
/// As an extra on top of `lazy` it offers reseting the wrapper to its "uninitialized" state.
///
/// - Note: This wrapper prevents reassigning the wrapped property value but *NOT* the wrapper itself.
/// Reassigning the wrapper `_value = LazyConstant(wrappedValue: "Hola!")` is possible and
/// since wrappers themselves need to be declared variable there is no way to prevent it.
@propertyWrapper
public struct LazyConstant<Value> {
    
    private(set) var storage: Value?
    let constructor: () -> Value
    
    /// Creates a constnat lazy property with the closure to be executed to provide an initial value once the wrapped property is first accessed.
    ///
    /// This constructor is automatically used when assigning the initial value of the property, so simply use:
    ///
    ///     @Lazy var text = "Hello, World!"
    ///
    public init(wrappedValue constructor: @autoclosure @escaping () -> Value) {
        self.constructor = constructor
    }
    
    public var wrappedValue: Value {
        mutating get {
            if storage == nil {
                storage = constructor()
            }
            return storage!
        }
    }
    
    /// Resets the wrapper to its initial state. The wrapped property will be initialized on next read access.
    public mutating func reset() {
        storage = nil
    }
}
