public enum ServerStatus: Int, CustomStringConvertible {
    case OK = 200
    case badRequest = 400
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case gone = 410
    case payloadTooLarge = 413
    case tooManyRequests = 429
    case internalServerError = 500
    case serviceUnavailable = 503

    public var description: String {
        switch self {
        case .OK:
            return "Success"
        case .badRequest:
            return "Bad request"
        case .forbidden:
            return "There was an error with the certificate or with the provider authentication token"
        case .notFound:
            return "The request contained a bad :path value"
        case .methodNotAllowed:
            return "The request used a bad :method value. Only POST requests are supported."
        case .gone:
            return "The device token is no longer active for the topic."
        case .payloadTooLarge:
            return "The notification payload was too large."
        case .tooManyRequests:
            return "The server received too many requests for the same device token."
        case .internalServerError:
            return "Internal server error"
        case .serviceUnavailable:
            return "The server is shutting down and unavailable."
        }
    }
}
