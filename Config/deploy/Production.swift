import Flock

class Production: Configuration {
    func configure() {
		// Config.SSHAuthMethod = .key("/path/to/mykey")
    Servers.add(ip: "krystof.eu", user: "krystof", roles: [.app], authMethod: .key("/Users/krystof/.ssh/id_rsa"))
    }
}
