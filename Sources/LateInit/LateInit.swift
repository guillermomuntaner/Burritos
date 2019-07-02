//
//  LateInit.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 17/06/2019.
//

/// A property wrapper which lets you left a stored property uninitialized during construction and set its value later.
///
/// In Swift *classes and structures must set all of their stored properties to an appropriate initial value by the time
/// an instance of that class or structure is created. Stored properties cannot be left in an indeterminate state. *.
///
/// LateInit lets you work around this restriction and leave a stored properties uninitialized. This also means you are
/// responsible of initializing the property before it is accessed. Failing to do so will result in a fatal error.
/// Sounds familiar? LateInit is an reimplementation of a Swift "Implicitly Unwrapped Optional".
/// 
/// Usage:
/// ```
/// @LateInit var text: String
///
/// // Note: Access before initialization triggers a fatal error:
/// // print(text) // -> fatalError("Trying to access LateInit.value before setting it.")
///
/// // Initialize later in your code:
/// text = "Hello, World!"
///
@propertyWrapper
public struct LateInit<Value> {
    
    var storage: Value?
    
    public init() {
        storage = nil
    }
    
    public var wrappedValue: Value {
        get {
            guard let storage = storage else {
                fatalError("Trying to access LateInit.value before setting it.")
            }
            return storage
        }
        set {
            storage = newValue
        }
    }
}
