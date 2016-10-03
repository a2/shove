import Foundation

public struct ShoveClientOptions {
    public var sessionConfiguration: URLSessionConfiguration
    public var isDevelopment: Bool
    public var shouldUseAlternatePort: Bool

    public init(sessionConfiguration: URLSessionConfiguration = .default, isDevelopment: Bool = false, shouldUseAlternatePort: Bool = false) {
        self.sessionConfiguration = sessionConfiguration
        self.isDevelopment = isDevelopment
        self.shouldUseAlternatePort = shouldUseAlternatePort
    }

    var port: Int {
        return shouldUseAlternatePort ? 2197 : 443
    }

    var baseURL: URL {
        if isDevelopment {
            return URL(string: "https://api.development.push.apple.com:\(port)/3/device/")!
        } else {
            return URL(string: "https://api.push.apple.com:\(port)/3/device/")!
        }
    }
}
