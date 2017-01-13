import Flock

class Production: Configuration {
    func configure() {
		// Config.SSHAuthMethod = .key("/path/to/mykey")
    Servers.add(ip: "45.76.84.134", user: "root", roles: [.app], authMethod: .key("/Users/krystof/.ssh/id_rsa"))
    }
}
