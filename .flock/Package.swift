// Don't change!

import PackageDescription
import Foundation

let package = Package(
   name: "Flockfile"
)

let url = URL(fileURLWithPath: "../config/deploy/FlockDependencies.json")
if let data = try? Data(contentsOf: url),
    let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: [[String: Any]]],
    let dependencies = json["dependencies"] {
    
    for dependency in dependencies {
        guard let url = dependency["url"] as? String else {
            print("Ignoring invalid dependency \(dependency)")
            continue
        }
        let dependencyPackage: Package.Dependency
        if let version = dependency["version"] as? String, let packageVersion = Version(version) {
            dependencyPackage = Package.Dependency.Package(url: url, packageVersion)
        } else if let major = dependency["major"] as? Int {
            if let minor = dependency["minor"] as? Int {
                dependencyPackage = Package.Dependency.Package(url: url, majorVersion: major, minor: minor)
            } else {
                dependencyPackage = Package.Dependency.Package(url: url, majorVersion: major)
            }
        } else {
            print("Ignoring invalid dependency \(url)")
            continue
        }
        package.dependencies.append(dependencyPackage)
    }
}
