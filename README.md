# Shiny

[![Build Status](https://travis-ci.org/efremidze/Shiny.svg?branch=master)](https://travis-ci.org/efremidze/Shiny)
[![Language](https://img.shields.io/badge/Swift-5-orange.svg?style=flat)](https://swift.org)
[![Version](https://img.shields.io/cocoapods/v/Shiny.svg?style=flat)](http://cocoapods.org/pods/Shiny)
[![License](https://img.shields.io/cocoapods/l/Shiny.svg?style=flat)](http://cocoapods.org/pods/Shiny)
[![Platform](https://img.shields.io/cocoapods/p/Shiny.svg?style=flat)](http://cocoapods.org/pods/Shiny)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

**Shiny** is an iOS library that generates an iridescent effect view matched to the gyroscope, similar to the Apple Pay Cash card in the Wallet app.

<img src="https://raw.githubusercontent.com/efremidze/Shiny/master/Images/applepay.png" width="318" alt="Apple Pay" />
<img src="https://thumbs.gfycat.com/NewGrotesqueKitten-size_restricted.gif" width="320">

[Demo Video](https://gfycat.com/gifs/detail/NewGrotesqueKitten)

```
$ pod try Shiny
```

## Requirements

- iOS 9.0+
- Xcode 9.0+
- Swift 5 (Shiny 2.x), Swift 4 (Shiny 1.x)

## Usage

Adding `ShinyView` programmatically (supports storyboard/xib too):

```swift
import Shiny

let shinyView = ShinyView(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
shinyView.colors = [.gray, .red, .green, .blue, .gray]
shinyView.startUpdates() // necessary
view.addSubview(shinyView)
```

You must call `startUpdates()` for the instance to observe motion changes. Calling `stopUpdates()` on the instance will stop motion updates.

```swift
func startUpdates() // Starts listening to motion updates.
func stopUpdates() // Stops listening to motion updates.
```

### Customization

The `ShinyView` exposes several properties to customize the radial gradient used to create the shiny effect:

```swift
var colors: [UIColor] // The color of each gradient stop.
var locations: [CGFloat]? // The location of each gradient stop. The default is `nil`.
var scale: CGFloat // The scale factor of the gradient. The default is `2.0`.
```

## Installation

Shiny is available via CocoaPods and Carthage.

### CocoaPods
To install with [CocoaPods](http://cocoapods.org/), simply add this in your `Podfile`:
```ruby
use_frameworks!
pod "Shiny"
```

### Carthage
To install with [Carthage](https://github.com/Carthage/Carthage), simply add this in your `Cartfile`:
```ruby
github "efremidze/Shiny"
```

## Mentions

- [iOS Dev Weekly 332](http://iosdevweekly.com/issues/332#start)

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Apps Using _Shiny_

Feel free to submit a PR if you’re using this library in your apps.

## License

Shiny is available under the MIT license. See the LICENSE file for more info.
