import PackageDescription

let package = Package(
    name: "Shove",
    dependencies: [
        .Package(url: "https://github.com/vapor/clibressl.git", majorVersion: 1, minor: 0),
    ]
)
