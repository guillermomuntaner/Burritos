//
//  AtomicWrite.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 18/06/2019.
//

import Foundation

/// A property wrapper granting atomic write access to the wrapped property.
/// Atomic mutation (read-modify-write) can be done using the wrapper `mutate` method.
/// Reading access is not atomic but is exclusive with write & mutate operations.
///
/// - Note: Getting and then setting is not an atomic operation. It is easy to unknowingly
/// trigger a get & a set, e.g.  when increasing a counter `count += 1`. Sadly such an atomic
/// modification cannot be simply done with getters and setter, hence we expose  the
/// `mutate(_ action: (inout Value) -> Void)`  method on the wrapper for this
/// purpose which you can access with a _ prefix.
///
/// ```
/// @Atomic var count = 0
///
/// // You can atomically write (non-derived) values directly:
/// count = 100
///
/// // To mutate (read-modify-write) always use the wrapper method:
/// _count.mutate { $0 += 1 }
///
/// print(count) // 101
/// ```
///
/// Some related reads & inspiration:
/// [swift-evolution proposal](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md)
/// [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveSwift/blob/master/Sources/Atomic.swift)
/// [obj.io](https://www.objc.io/blog/2019/01/15/atomic-variables-part-2/)
@available(iOS 2.0, OSX 10.0, tvOS 9.0, watchOS 2.0, *)
@propertyWrapper
public struct AtomicWrite<Value> {
    
    // TODO: Faster version with os_unfair_lock?
    
    let queue = DispatchQueue(label: "Atomic write access queue", attributes: .concurrent)
    var storage: Value
    
    public init(initialValue value: Value) {
        self.storage = value
    }
    
    public var wrappedValue: Value {
        get {
            return queue.sync { storage }
        }
        set {
            queue.sync(flags: .barrier) { storage = newValue }
        }
    }
    
    /// Atomically mutate the variable (read-modify-write).
    ///
    /// - parameter action: A closure executed with atomic in-out access to the wrapped property.
    public mutating func mutate(_ mutation: (inout Value) throws -> Void) rethrows {
        return try queue.sync(flags: .barrier) {
            try mutation(&storage)
        }
    }
}
