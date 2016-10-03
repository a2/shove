Shove
=====

A simple APNS interface in Swift.

## Installation

### SPM (Swift Package Manager)

You can easily integrate Shove in your app with SPM. Just add Shove as a dependency:

```swift
import PackageDescription

let package = Package(
    name: "MyAwesomeApp",
    dependencies: [
        .Package(url: "https://github.com/a2/shove.git", majorVersion: 0, minor: 1),
    ]
)
```

## Version

0.1.1 supports Swift 3.

## Xcode Support

As Shove supports Swift Package Manager, you can develop the library in your text editor of choice. If you want to use Xcode, generate an Xcode projec with the following command:

```sh
$ swift package generate-xcodeproj
```

## Authors

Alexsander Akers, me@a2.io

## License

Shove is available under the MIT license. See the LICENSE file for more info.
