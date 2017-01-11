import PackageDescription

let package = Package(
    name: "muensterwetter",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 3),
        .Package(url: "https://github.com/tid-kijyun/Kanna.git", majorVersion: 2),

    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        ]
)

