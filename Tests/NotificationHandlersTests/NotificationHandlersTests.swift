//
//  NotificationHandlersTests.swift
//  
//
//  Created by Guillermo Muntaner Perelló on 01/07/2019.
//


import XCTest
@testable import NotificationHandlers

extension Notification.Name {
    static var textDidChange: Notification.Name { return Notification.Name("textDidChange") }
}

final class NotificationHandlersTests: XCTestCase {
    
    // - Note: This syntax causing Abort trap: 6
    // @NotificationSubscriber(notificationName: .textDidChange)
    // var text: String = "Hello, World!"
    
    @NotificationSubscriber(initialValue: "Hello, World!", notificationName: .textDidChange)
    var text: String
    
    @NotificationPublisher(initialValue: "Hello, World!", notificationName: .textDidChange)
    var textPublisher: String
    
    override func setUp() {
        $text = NotificationSubscriber<String>(
            initialValue: "Hello, World!",
            notificationName: .textDidChange
        )
        $textPublisher = NotificationPublisher<String>(
            initialValue: "Hello, World!",
            notificationName: .textDidChange
        )
    }
    
    // MARK: - Subscriber
    
    func testGetSubscriber() {
        XCTAssertEqual(text, "Hello, World!")
    }
    
    func testReceiveSubscriber() {
        NotificationCenter.default.post(name: .textDidChange, object: "Hello from notification center")
        XCTAssertEqual(text, "Hello from notification center")
    }
    
    // MARK: - Publisher
    
    func testGetPublisher() {
        XCTAssertEqual(textPublisher, "Hello, World!")
        
    }
    
    func testPublisherPost() {
        let receiveNotificationExpectation = expectation(description: "Receive notification")
        let observer = NotificationCenter.default
            .addObserver(forName: .textDidChange, object: nil, queue: nil) { notification in
                if notification.object as? String == "Hello my subscribers!" {
                    receiveNotificationExpectation.fulfill()
                }
        }
        
        textPublisher = "Hello my subscribers!"
        wait(for: [receiveNotificationExpectation], timeout: 1)
        
        NotificationCenter.default.removeObserver(observer)
    }
    
    // MARK: - Combinations
    
    func testPostAndReceive() {
        XCTAssertEqual(text, "Hello, World!")
        textPublisher = "Hello my subscribers!"
        XCTAssertEqual(text, "Hello my subscribers!")
    }
    
    func testSubscriberFromPublisher() {
        let subscriber = $textPublisher.notificationSubscriber
        XCTAssertEqual(subscriber.wrappedValue, "Hello, World!")
        
        textPublisher = "Hello my subscribers!"
        XCTAssertEqual(subscriber.wrappedValue, "Hello my subscribers!")
    }
    
    func testPublisherFromSubscriber() {
        var publisher = $text.notificationPublisher
        XCTAssertEqual(publisher.wrappedValue, "Hello, World!")
        
        publisher.wrappedValue = "Hello my subscribers!"
        XCTAssertEqual(text, "Hello my subscribers!")
    }
    
    static var allTests = [
        // Subscriber
        ("testGetSubscriber", testGetSubscriber),
        ("testReceiveSubscriber", testReceiveSubscriber),
        // Publisher
        ("testGetPublisher", testGetPublisher),
        ("testPublisherPost"), testPublisherPost),
        // Combinations
        ("testPostAndReceive", testPostAndReceive),
        ("testSubscriberFromPublisher", testSubscriberFromPublisher),
        ("testPublisherFromSubscriber", testPublisherFromSubscriber),
    ]
}
