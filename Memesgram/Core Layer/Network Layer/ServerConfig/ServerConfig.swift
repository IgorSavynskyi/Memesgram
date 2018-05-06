import Foundation

enum HostPath: String {
    case redditBase = "https://www.reddit.com"
}

enum EndPoint {
    static let top = "/top.json"
}

struct ServerConfig {
    let name: String
    let baseUrl: String
    let headers: HeadersDict
    let timeout: TimeInterval = 40.0    /// Global timeout for any request

    let emptyDataStatusCodes: Set<Int> = [204, 205]
    
    static func defaultConfig() -> ServerConfig {
        let cfg = ServerConfig(name: "Reddit Dev",
                               baseUrl: HostPath.redditBase.rawValue,
                               headers: [:])
        return cfg
    }
}

