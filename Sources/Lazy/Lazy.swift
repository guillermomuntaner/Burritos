//
//  Lazy.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 16/06/2019.
//

/// A property wrapper which delays instantiation until first read access.
///
/// It can simply be used such as:
///
///     @Lazy var text = "Hello, World!"
///
/// - Note: This is a reimplementation of Swift `lazy` keyword using property wrappers so is equivalent to using
///     `lazy var text = "Hello, World!"`
@propertyDelegate
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
    
    public var value: Value {
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
}
