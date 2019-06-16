# Burritos 🌯

A collection of Swift property wrappers.

## About property wrappers (or property delegates)

TODO


## @Lazy

A reimplementation of swift `lazy` syntax sugar using a property wrapper.

```
lazy var helloWorld = "Hello, World!"

@Lazy var helloWorld = "Hello, World!"
```

## @UserDefault

Type safe access to `UserDefaults` with support 
```
@UserDefault("test", defaultValue: "Hello, World!")
var test: String
```

By default it uses the standard user defauls. You can pass the instance you want to use via its constructor:

```
@UserDefault("test", defaultValue: "Hello, World!", userDefaults: UserDefaults(suiteName: "your.app.group"))
var test: String
```

## @LateInit

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
