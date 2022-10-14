//
//  MappingSetter.swift
//
//
//  Created by Roman Podymov on 16/10/2019.
//

/// A property wrapper that maps the value passed to setter.
///
/// Usage:
/// ```
/// @MappingSetter(mappingSetter: { String($0.prefix(5)) })
/// var upToFive: String = "Hello, World!"
/// ...
/// print(upToFive) // "Hello"
/// ```
///
@propertyWrapper
public struct MappingSetter<Value> {
    private var value: Value!
    private let mappingSetter: (Value) -> Value

    public var wrappedValue: Value {
        get { value }
        set { value = mappingSetter(newValue) }
    }

    public init(wrappedValue: Value, mappingSetter: @escaping (Value) -> Value) {
        self.mappingSetter = mappingSetter
        self.wrappedValue = wrappedValue
    }
}
