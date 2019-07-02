//
//  Clamping.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 25/06/2019.
//

/// A property wrapper that automatically clamps its wrapped value in a range.
///
/// ```
/// @Clamping(range: 0...1)
/// var alpha: Double = 0.0
///
/// alpha = 2.5
/// print(alpha) // 1.0
///
/// alpha = -1.0
/// print(alpha) // 0.0
/// ```
///
/// - Note: Using a Type whose capacity fits your range should always be prefered to using this wrapper; e.g. you can use an UInt8 for 0-255 values.
///
/// [Swift Evolution Proposal example](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md#clamping-a-value-within-bounds)
/// [NSHisper article](https://nshipster.com/propertywrapper/)
@propertyWrapper
public struct Clamping<Value: Comparable> {
    var storage: Value
    let range: ClosedRange<Value>
    
    public init(initialValue: Value, range: ClosedRange<Value>) {
        self.range = range
        self.storage = range.clamp(initialValue)
    }
    
    public var wrappedValue: Value {
        get { storage }
        set { storage = range.clamp(newValue) }
    }
}

fileprivate extension ClosedRange {
    func clamp(_ value : Bound) -> Bound {
        return self.lowerBound > value ? self.lowerBound
            : self.upperBound < value ? self.upperBound
            : value
    }
}
