import Flock

class Production: Configuration {
    func configure() {
		// Config.SSHAuthMethod = .key("/path/to/mykey")
    Servers.add(ip: "104.238.158.157", user: "krystof", roles: [.app], authMethod: .key("/Users/krystof/.ssh/id_rsa"))
    }
}
