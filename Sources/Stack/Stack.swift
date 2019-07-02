//
//  Stack.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 23/06/2019.
//

/// Implementation of a classic [stack](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)).
/// The property wrapper maps `get` to `pop` and `set` to `push` hence it behaves like a pointer to the top of the stack.
///
/// - Important: Accessing the wrapped property means the most recently added element is removed from the stack.
/// If what you want to do is check the value without removing it then use the property wrapper `peek()` method.
///
/// ```
/// @Stack val topOfTasksStack: Task
///
/// topOfTasksStack = Task(1)
///
/// while let task = self.topOfTasksStack {
///     process(task)
/// }
/// ```
@propertyWrapper
public struct Stack<Value> {
    
    var stackArray: [Value]
    
    public init(initialValue: Value?) {
        self.stackArray = initialValue.map { [$0] } ?? []
    }
    
    // MARK: Property wrapper
    
    public var wrappedValue: Value? {
        mutating get {
            return pop()
        }
        set {
            // Ignore nil values
            guard let newElement = newValue else { return }
            push(newElement)
        }
    }
    
    // MARK: Stack API
    
    /// Adds an element to the stack
    public mutating func push(_ newElement: Value) {
        stackArray.append(newElement)
    }
    
    /// Removes the most recently added element that was not yet removed. If stack is empty it returns nil.
    public mutating func pop() -> Value? {
        return stackArray.isEmpty ? nil : stackArray.removeLast()
    }
    
    /// Returns the element in the top of the stack without removing it. If stack is empty it returns nil.
    public func peak() -> Value? {
        return stackArray.last
    }
    
    // TODO: Navite implementation without using Swift.Array.
}
