//
//  File.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 16/06/2019.
//

@propertyDelegate
public struct Lazy<Value> {
    
    var storage: Value?
    let constructor: () -> Value
    
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
