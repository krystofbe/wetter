import Flock

class Staging: Configuration {
    func configure() {
		// Servers.add(SSHHost: "StagingServer", roles: [.app, .db, .web])
    Servers.add(ip: "ubuntu", user: "root", roles: [.app], authMethod: .key("/Users/krystof/.ssh/id_rsa"))

    }
}
