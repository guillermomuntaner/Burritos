//
//  Observed.swift
//  Burritos-Framework
//
//  Created by Thibault Wittemberg on 2019-07-14.
//  Copyright © 2019 Thibault Wittemberg. All rights reserved.
//

/// A property wrapper to transform any property into an observable property.
/// Step 1: Implement a class conforming to Observer (the associatedtype must be of the same type as the wrapped value)
/// Step 2: Register the observer to the property wrapper
/// Step 3: All the property mutations will trigger the update function of the Observer
///
/// ```
/// struct User {
///     var name: String
///     var age: Int
/// }
///
/// class UserObserver: Observer {
///     func update(value: User) {
///         print ("New user received: \(user)")
///     }
/// }
///
/// @Observed
/// var user = User(name: "john doe", age: 20)
///
/// let userObserver = UserObserver().toAnyObserver()
/// $user.add(observer: userObserver)
///
/// user.name = "jane doe"
/// user.age = 30
///
/// will print:
/// New user received: User(name: "jane doe", age: 20)
/// New user received: User(name: "jane doe", age: 30)
/// ```

public protocol Observer: AnyObject {
    associatedtype Value
    func update(value: Value)
}

public class AnyObserver<Value>: Observer {
    private let updateClosure: (Value) -> Void
    
    init<ObserverType: Observer>(with observer: ObserverType) where ObserverType.Value == Value {
        self.updateClosure = observer.update
    }
    
    public func update(value: Value) {
        self.updateClosure(value)
    }
}

extension Observer {
    func toAnyObserver () -> AnyObserver<Value> {
        return AnyObserver<Value>(with: self)
    }
}

public protocol Subject {
    associatedtype Value
    mutating func add(observer: AnyObserver<Value>)
    mutating func remove(observer: AnyObserver<Value>)
}

@propertyWrapper
public struct Observed<Value>: Subject {
    
    public init (initialValue: Value) {
        self.wrappedValue = initialValue
    }
    
    init (initialValue: Value, by observer: AnyObserver<Value>) {
        self.wrappedValue = initialValue
        self.observers.append(observer)
    }
    
    public var wrappedValue: Value {
        didSet {
            self.fireNotification()
        }
    }
    
    private var observers = [AnyObserver<Value>]()
    
    public mutating func add(observer: AnyObserver<Value>) {
        self.observers.append(observer)
    }
    
    public mutating func remove(observer: AnyObserver<Value>) {
        self.observers.removeAll { $0 === observer }
    }
    
    private func fireNotification() {
        self.observers.forEach { $0.update(value: self.wrappedValue) }
    }
}
