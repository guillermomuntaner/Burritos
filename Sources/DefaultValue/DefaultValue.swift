//
//  DefaultValue.swift
//  Burritos
//
//  Created by Evgeniy (@own2pwn) on 28/06/2019.
//  Copyright © 2019 Wicked. All rights reserved.
//

import Foundation

@propertyWrapper
public struct DefaultValue<Value> {
    // MARK: - Members

    private var storage: Value?

    private let defaultValue: Value

    // MARK: - Interface

    public var value: Value! {
        get {
            if let unboxed = storage {
                return unboxed
            }

            return defaultValue
        }
        set {
            storage = newValue
        }
    }

    // MARK: - Init

    public init(value: Value) {
        defaultValue = value
    }
}
