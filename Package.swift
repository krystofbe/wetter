import PackageDescription

let package = Package(
    name: "muensterwetter",
    dependencies: [
      .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
        .Package(url: "https://github.com/tid-kijyun/Kanna.git", majorVersion: 2),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", majorVersion: 2, minor: 0),
        .Package(
            url: "https://github.com/PerfectlySoft/Perfect-Curl.git",
            majorVersion: 2, minor: 0
        )




    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        ]
)
