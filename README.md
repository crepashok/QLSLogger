# QLSLogger

[![CI Status](http://img.shields.io/travis/Pasha/QLSLogger.svg?style=flat)](https://travis-ci.org/Pasha/QLSLogger)
[![Version](https://img.shields.io/cocoapods/v/QLSLogger.svg?style=flat)](http://cocoapods.org/pods/QLSLogger)
[![License](https://img.shields.io/cocoapods/l/QLSLogger.svg?style=flat)](http://cocoapods.org/pods/QLSLogger)
[![Platform](https://img.shields.io/cocoapods/p/QLSLogger.svg?style=flat)](http://cocoapods.org/pods/QLSLogger)

## Requirements
```ruby
'CocoaLumberjack/Swift', '~> 2.3.0'
'SwiftHEXColors', '~> 1.0'
```

## Installation

QLSLogger is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "QLSLogger"
```

##Usage

First of all you have to init logger somewhere in your app delegate, in the `- applicationDidFinishLaunching: withOptions:` method call the logger initializer:

```swift
QLSLogger.log.setupSharedLogInstance()
```
After this you are able to call logger methods:

```swift
QLSLogger.log.verbose("Verbose", LogModule: {module});
QLSLogger.log.debug("Debug", LogModule: {module});
QLSLogger.log.info("Info", LogModule: {module});
QLSLogger.log.warn("Warn", LogModule: {module});
QLSLogger.log.error("Error", LogModule: {module});
```

### Available modules
Http, CoreData, JSON, UI, None and Custom(String). Custom log module can be setted to specify your own log-module, but the length of this custom string should be shorter than 10 characters

## Screenshot
![alt tag](http://cretsu.name/pods/QLSLogger.png)


## Author

Pasha, pasha.cretsu@gmail.com

## License

QLSLogger is available under the MIT license. See the LICENSE file for more info.
