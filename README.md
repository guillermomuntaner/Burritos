# 🌯🌯 Burritos 

A collection of Swift Property Wrappers.

- [@LateInit](#LateInit)
- [@Lazy](#Lazy)
- [@UserDefault](#UserDefault)

## 🚧 Beta Software:  🚧 

Property Wrappers were announced by Apple during WWDC 2019. They are a fundamental component in SwiftUI syntax sugar hence Apple pushed them into the Swift 5.1 beta, skipping the normal Swift Evolution process. Final proposals are being discussed right now in the forucs so they are subject to change.

## Requirements
Xcode Beta 11.0 & Swift 5.1

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
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "0.0.1")
]
```

## @LateInit

A reimplementation of Swift Implicitly Unwrapped Optional using a property wrapper.

```swift
@LateInit var text: String

// Note: Accessing it before is is set will result in a fatal error:
// print(text) // -> fatalError("Trying to access LateInit.value before setting it.")

// Later in your code:
text = "Hello, World!"
```

## @Lazy

A reimplementation of Swift `lazy` syntax sugar using a property wrapper.

```swift
lazy var helloWorld = "Hello, World!"

@Lazy var helloWorld = "Hello, World!"
```

## @UserDefault

Type safe access to `UserDefaults` with support 
```swift
@UserDefault("test", defaultValue: "Hello, World!")
var test: String
```

By default it uses the standard user defauls. You can pass the instance you want to use via its constructor:

```swift
@UserDefault("test", defaultValue: "Hello, World!", userDefaults: UserDefaults(suiteName: "your.app.group"))
var test: String
```

## @Cached
TODO

## @Dependency //  Locator pattern
TODO

## Thread safety
TODO

## Command line parameters
TODO

## Locator pattern
TODO

## Singleton?
TODO

## Weak
TODO

## Property observer -> willSet, didSet !
TODO


## About Property Wrappers

A property wrapper, or property delegate, is a pattern to abstract custom read and writte behaviours.
In Swift we can use a generic struct exposing a computed property whose get & set methods we can implement however we want. This allows us to reuse some get/set logic with any type:

```swift
struct SomeWrapper<T> {
let key: String

var value: T {
get {
// Your custom get logic
}
set {
// Your custom set logic
}
}
}
```

In plain old Swift you would have used this as follows:

```
// Instantiate your property wrapper
var wrappedProperty = SomeWrapper<String>("Hello, World!")

// Access its value
wrappedProperty.value

// In order to avoid having to unwrap wrappedProperty.value all the time, you can use a computed property
var value: String {
get { wrappedProperty.value }
set { wrappedProperty.value = newValue }
}

// So now accessing the value is much easier
value
```

Swift 5.1 leverages annotations and the compiler to generate this code for you. It also bridges the assignment operator to the wrapper constructor which leads to a really nice syntax. So now, we can simply use:

```
@SomeWrapper var value = "Hello, World!"

// Access the wrapped value:
value

// You can also access the wrapper by using $
$value // <- This is the SomeWrapper<String> instance
```  

Equivalents in other languages:
* Kotlin has [Delegated Properties](https://kotlinlang.org/docs/reference/delegated-properties.html)


## License

Burritos is released under the [MIT license](https://github.com/guillermomuntaner/Burritos/blob/master/LICENSE).
