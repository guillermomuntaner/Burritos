//
//  NotificationHandlerss.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 01/07/2019.
//

import Foundation

/// A wrapper arround a property that posts a notification every time its value changes.
///
/// ```
/// // Define the notification name to use
/// let progressDidChange: Notification.Name("progressDidChange")
///
/// @NotificationPublisher(initialValue: 0, notificationName: progressDidChange)
/// var progress: Double
///
/// progress = 0.1 // This posts a progressDidChange notification
/// ```
@propertyWrapper
public struct NotificationPublisher<Value> {

    public let name: Notification.Name

    public let notificationCenter: NotificationCenter
    
    public var value: Value
    
    public var wrappedValue: Value {
        get {
            return value
        }
        set {
            value = newValue
            notificationCenter.post(name: name, object: newValue)
        }
    }
    
    public init(
        initialValue: Value,
        notificationName: Notification.Name,
        notificationCenter: NotificationCenter = .default
        ) {
        self.value = initialValue
        self.name = notificationName
        self.notificationCenter = notificationCenter
    }
    
    // MARK: Helpers
    
    /// A notification subscriber for this specific publisher notifications.
    public var notificationSubscriber: NotificationSubscriber<Value> {
        return NotificationSubscriber(
            initialValue: wrappedValue,
            notificationName: name,
            notificationCenter: notificationCenter
        )
    }
}

/// A wrapper arround a property that auto updates its value when it receives a notification.
///
/// TODO: Usage.
@propertyWrapper
public class NotificationSubscriber<Value> {
    
    public let notificationCenter: NotificationCenter
    
    public let name: Notification.Name
    public let object: Any?
    public let queue: OperationQueue?
    
    var observer: NSObjectProtocol? = nil
    
    // TODO: This doesn't seem that convenient
    public var didSet: (() -> Void)?
    
    public private(set) var wrappedValue: Value {
        didSet { didSet?() }
    }
    
    public init(
        initialValue: Value,
        notificationName: Notification.Name,
        object: Any? = nil,
        queue: OperationQueue? = nil,
        notificationCenter: NotificationCenter = .default,
        didSet: (() -> Void)? = nil
    ) {
        wrappedValue = initialValue
        self.notificationCenter = notificationCenter
        self.name = notificationName
        self.object = object
        self.queue = queue
        self.didSet = didSet
        // Add observer
        observer = notificationCenter.addObserver(
            forName: name,
            object: object,
            queue: queue
        ) { [weak self] notification in
            guard let self = self, let value = notification.object as? Value else { return }
            self.wrappedValue = value
        }
    }
    
    deinit {
        if let observer = observer {
            notificationCenter.removeObserver(observer)
        }
    }
    
    // MARK: Helpers
    
    /// A notification publisher that can post notifications for this specific subscriber.
    public var notificationPublisher: NotificationPublisher<Value> {
        return NotificationPublisher(
            initialValue: wrappedValue,
            notificationName: name,
            notificationCenter: notificationCenter
        )
    }
}
