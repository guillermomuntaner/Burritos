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
/// @AtomicWrite var count = 0
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
@propertyWrapper
public struct AtomicWrite<Value> {
    var storage: Value
    
    private let lock: AtomicLock = {
        if #available(OSX 10.12, iOS 10, tvOS 10, watchOS 3, *) {
            return UnfairLock()
        } else {
            return PThreadLock()
        }
    }()

    public init(initialValue value: Value) {
        self.storage = value
    }
    
    public var wrappedValue: Value {
        get {
            return lock.perform { storage }
        }
        set {
            lock.perform { storage = newValue }
        }
    }
    
    /// Atomically mutate the variable (read-modify-write).
    ///
    /// - parameter action: A closure executed with atomic in-out access to the wrapped property.
    public mutating func mutate(_ mutation: (inout Value) throws -> Void) rethrows {
        return try lock.perform {
            try mutation(&storage)
        }
    }
}

private protocol AtomicLock {
    func perform<Result>(block: () throws -> Result) rethrows -> Result
}

private class PThreadLock: AtomicLock {
    private var mutex = pthread_mutex_t()

    init() {
        pthread_mutex_init(&mutex, nil)
    }

    deinit {
        pthread_mutex_destroy(&mutex)
    }

    func perform<Result>(block: () throws -> Result) rethrows -> Result {
        pthread_mutex_lock(&mutex)
        defer { pthread_mutex_unlock(&mutex) }
        return try block()
    }
}

@available(OSX 10.12, iOS 10, tvOS 10, watchOS 3, *)
private class UnfairLock: AtomicLock {
    private var mutex = os_unfair_lock()

    func perform<Result>(block: () throws -> Result) rethrows -> Result {
        os_unfair_lock_lock(&mutex)
        defer { os_unfair_lock_unlock(&mutex) }
        return try block()
    }
}

