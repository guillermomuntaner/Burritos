# 🌯🌯 Burritos 

[![Bitrise Build Status](https://img.shields.io/bitrise/82996dff101ee00e.svg?token=C1i6-qS1Bfhz1QvbJPV7GA)](https://app.bitrise.io/app/82996dff101ee00e)
[![Swift Package Manager](https://img.shields.io/badge/swift%20package%20manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Platform](https://img.shields.io/cocoapods/p/Burritos.svg)](https://github.com/guillermomuntaner/Burritos)


A collection of well tested Swift Property Wrappers.

- [@AtomicWrite](#AtomicWrite)
- [@Clamping](#Clamping)
- [@Copying](#Copying)
- [@DefaultValue](#DefaultValue)
- [@DynamicUIColor](#DynamicUIColor)
- [@EnvironmentVariable](#EnvironmentVariable)
- [@Expirable](#Expirable)
- [@LateInit](#LateInit)
- [@Lazy](#Lazy)
- [@LazyConstant](#LazyConstant)
- [@Trimmed](#Trimmed)
- [@UndoRedo](#UndoRedo)
- [@UserDefault](#UserDefault)
- More coming ...

## 🚧 Beta Software:  🚧 

Property Wrappers have a final shape 🎉. [See the accepted proposal](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md)
Expecting bug fixes in incoming betas but no changes.

👉 Did you know: Property Wrappers were announced by Apple during WWDC 2019. They are a fundamental component in SwiftUI syntax sugar hence Apple pushed them into the initial Swift 5.1 beta, skipping the normal Swift Evolution process. This process continued after WWDC and it took 3 reviews to reach their final form on Xcode 11 beta 4.

## Requirements
Xcode 11.0 Beta 4 & Swift 5.1

## Installation

### Swift Package Manager

#### Xcode 11.0+ integration
1.  Open `MenuBar` → `File` → `Swift Packages` → `Add Package Dependency...`
2.  Paste the package repository url `https://github.com/guillermomuntaner/Burritos` and hit Next.
3.  Select your rules. Since this package is in pre-release development, I suggest you specify a concrete tag to avoid pulling breaking changes.


#### Package.swift
If you already have a Package.swift or you are building your own package simply add a new dependency:
```swift
dependencies: [
    .package(url: "https://github.com/guillermomuntaner/Burritos", from: "0.0.2")
]
```


### Cocoapods

Add Burritos to your Podfile:
```rb
pod 'Burritos', '~> 0.0.2'
```

Each wrapper is a submodule, so you add just the one(s) you want
```rb
pod 'Burritos/Copying', '~> 0.0.2'
pod 'Burritos/UndoRedo', '~> 0.0.2'
pod 'Burritos/UserDefault', '~> 0.0.2'
```


## @AtomicWrite

A property wrapper granting atomic write access to the wrapped property.
Reading access is not atomic but is exclusive with write & mutate operations.
Atomic mutation (read-modify-write) can be done using the wrapper `mutate` method.

```swift
@Atomic var count = 0

// You can atomically write (non-derived) values directly:
count = 99

// To mutate (read-modify-write) always use the wrapper method:
DispatchQueue.concurrentPerform(iterations: 1000) { index in
    _count.mutate { $0 += 1 }
}

print(count) // 1099
```

## @Clamping

 A property wrapper that automatically clamps its wrapped value in a range.
 
```swift
@Clamping(range: 0...1)
var alpha: Double = 0.0

alpha = 2.5
print(alpha) // 1.0

alpha = -1.0
print(alpha) // 0.0
```


## @Copying

A property wrapper arround `NSCopying` that copies the value both on initialization and reassignment.
If you are tired of calling  `.copy() as! X` you will love this one.

```swift
@Copying var path: UIBezierPath = .someInitialValue

public func updatePath(_ path: UIBezierPath) {
    self.path = path
    // You don't need to worry whoever called this method mutates the passed by reference path.
    // Your stored self.path contains a copy.
}
```


## @DefaultValue

A property wrapper arround an implicitly unwrapped optional value which fallbacks to a given default value.

```swift
@DefaultValue(default: 0)
var count
count = 100
// or
@DefaultValue(default: 0)
var count = 100

// Assigning nil resets to the default value
print(count) // 100
count = nil
print(count) // 0
```

## @DynamicUIColor

A property wrapper arround UIColor to support dark mode.

By default in iOS >= 13 it uses the new system wide user interface style trait and dynamic UIColor constructor to support dark mode without any extra effort. On prior iOS versions it defaults to light.
```swift
@DynamicUIColor(light: .white, dark: .black)
var backgroundColor: UIColor

// The color will automatically update when traits change
view.backgroundColor = backgroundColor
```

To support older iOS versions  and custom logics (e.g. a switch in your app settings) the constructor can take an extra `style` closure that dynamically dictates which color to use. Returning a `nil` value results in the prior default behaviour. This logic allows easier backwards compatiblity by doing:

```swift
let color = DynamicUIColor(light: .white, dark: .black) {
    if #available(iOS 13.0, *) { return nil }
    else { return Settings.isDarkMode ? .dark : .light }
}

view.backgroundColor = color.value

// On iOS <13 you might need to manually observe your custom dark
// mode settings & re-bind your colors on changes:
if #available(iOS 13.0, *) {} else {
    Settings.onDarkModeChange { [weak self] in
        self?.view.backgroundColor = self?.color.value
    }
}
```

Original idea courtesy of [@bardonadam](https://twitter.com/bardonadam)

## @EnvironmentVariable

A  property wrapper to set and get system environment variables values.

 ```swift
@EnvironmentVariable(name: "PATH")
var path: String?

// You can set the environment variable directly:
path = "~/opt/bin:" + path!

```

## @Expirable

A property wrapper arround a value that can expire. Getting the value after given duration or expiration date will return nil.

```swift
@Expirable(duration: 60)
var apiToken: String?

// New values will be valid for 60s
apiToken = "123456abcd"
print(apiToken) // "123456abcd"
sleep(61)
print(apiToken) // nil

// You can also construct an expirable with an initial value and expiration date:
@Expirable(initialValue: "zyx987", expirationDate: date, duration: 60)
var apiToken: String?
// or just update an existing one:
_apiToken.set("zyx987", expirationDate: date)
```

[Courtesy of @v_pradeilles](https://twitter.com/v_pradeilles)


## @LateInit

A reimplementation of Swift Implicitly Unwrapped Optional using a property wrapper.

```swift
var text: String!
// or 
@LateInit var text: String

// Note: Accessing it before initializing will result in a fatal error:
// print(text) // -> fatalError("Trying to access LateInit.value before setting it.")

// Later in your code:
text = "Hello, World!"
```


## @Lazy

A property wrapper which delays instantiation until first read access.
It is a reimplementation of Swift `lazy` modifier using a property wrapper.

```swift
@Lazy var result = expensiveOperation()
...
print(result) // expensiveOperation() is executed at this point
```

As an extra on top of `lazy` it offers reseting the wrapper to its "uninitialized" state.


## @LazyConstant

Same as [@Lazy](#Lazy) + prevents changing or mutating its wrapped value.

```swift
@LazyConstant var result = expensiveOperation()
...
print(result) // expensiveOperation() is executed at this point

result = newResult // Compiler error
```

**Note**: This wrapper prevents reassigning the wrapped property value but **NOT** the wrapper itself. Reassigning the wrapper `_value = LazyConstant(initialValue: "Hola!")` is possible and since wrappers themselves need to be declared variable there is no way to prevent it.


## @Trimmed

A wrapper that automatically trims strings both on initialization and reassignment.

```swift
@Trimmed
var text = " \n Hello, World! \n\n    "

print(text) // "Hello, World!"

// By default trims white spaces and new lines, but it also supports any character set
@Trimmed(characterSet: .whitespaces)
var text = " \n Hello, World! \n\n    "
print(text) // "\n Hello, World! \n\n"
```


## @UndoRedo

A property wrapper that automatically stores history and supports undo and redo operations.

```swift
@UndoRedo var text = ""

text = "Hello"
text = "Hello, World!"

_text.canUndo // true
_text.undo() // text == "Hello"

_text.canRedo // true
_text.redo() // text == "Hello, World!"
```

You can check at any time if there is an undo or a redo stack using `canUndo` & `canRedo`
properties, which might be particularly usefull to enable/disable user interface buttons.

Original idea by  [@JeffHurray](https://twitter.com/JeffHurray/status/1137816198689673216)


## @UserDefault

Type safe access to `UserDefaults` with support  for default values.
```swift
@UserDefault("test", defaultValue: "Hello, World!")
var test: String
```

By default it uses the standard user defauls. You can pass any other instance of `UserDefaults` you want to use via its constructor, e.g. when you use app groups:

```swift
let userDefaults = UserDefaults(suiteName: "your.app.group")
@UserDefault("test", defaultValue: "Hello, World!", userDefaults: userDefaults)
var test: String
```

## @Cached
TODO

## @Dependency (Service locator pattern)
TODO

## Thread safety
TODO

## Command line parameters
TODO


## Property observer -> willSet, didSet !
TODO: Reimplement 

## Print/Log
TODO: A property wrapper that prints/logs any value set. 

## About Property Wrappers

A property wrapper, or property delegate, is a pattern to abstract custom read and writte behaviours.
In Swift we can use a generic struct exposing a computed property whose get & set methods we can implement however we want. This allows us to reuse some get/set logic with any type:

```swift
struct SomeWrapper<T> {
    ...
    var value: T {
        get {
            // Your custom get logic
            ...
        }
        set {
            // Your custom set logic
            ...
        }
    }
}
```

In plain old Swift you would have used this as follows:

```swift
// Instantiate your property wrapper
var wrappedProperty = SomeWrapper<String>("Hello, World!")

// Access its value
wrappedProperty.value

// In order to avoid having to unwrap wrappedProperty.value all the time, you can use a computed property
var value: String {
    get { return wrappedProperty.value }
    set { wrappedProperty.value = newValue }
}

// So now accessing the value is much easier
value
```

Swift 5.1 leverages annotations and the compiler to generate this code for you. It also bridges the assignment operator to the wrapper constructor which leads to a really nice syntax. So now, we can simply use:

```swift
@SomeWrapper var value = "Hello, World!"

// Access the wrapped value:
value

// You can also access the wrapper by using _
_value // <- This is the SomeWrapper<String> instance
```  


Interesting reads:
* [Original Property Wrappers Proposal](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md)
* [SwiftLee: Property wrappers to remove boilerplate code in Swift](https://www.avanderlee.com/swift/property-wrappers/)
* [Majid's: Understanding Property Wrappers in SwiftUI](https://mecid.github.io/2019/06/12/understanding-property-wrappers-in-swiftui/)
* [Swift by Sundell: The Swift 5.1 features that power SwiftUI’s API](https://www.swiftbysundell.com/posts/the-swift-51-features-that-power-swiftuis-api)
* [NSHipster article](https://nshipster.com/propertywrapper/)


Equivalents in other languages:
* Kotlin has [Delegated Properties](https://kotlinlang.org/docs/reference/delegated-properties.html)


## License

Burritos is released under the [MIT license](https://github.com/guillermomuntaner/Burritos/blob/master/LICENSE).
