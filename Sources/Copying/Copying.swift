//
//  File.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 17/06/2019.
//

import Foundation

/// A property wrapper that copies the value both on initialization and reassignment.
///
/// - Source:
/// [Proposal SE-0258](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md#nscopying)
/// [WWDC 2019 Modern Swift API Design](https://developer.apple.com/videos/play/wwdc2019/415/)
@available(iOS 2.0, OSX 10.0, tvOS 9.0, watchOS 2.0, *)
@propertyWrapper
public struct Copying<Value: NSCopying> {
    var storage: Value
    
    public init(initialValue value: Value) {
        storage = value.copy() as! Value
    }
    
    public init(withoutCopying value: Value) {
        storage = value
    }
    
    public var value: Value {
        get { return storage }
        set { storage = newValue.copy() as! Value }
    }
}
