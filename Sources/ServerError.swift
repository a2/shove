public enum ServerError: String, Error, CustomStringConvertible {
    case badCollapseId = "BadCollapseId"
    case badDeviceToken = "BadDeviceToken"
    case badExpirationDate = "BadExpirationDate"
    case badMessageId = "BadMessageId"
    case badPriority = "BadPriority"
    case badTopic = "BadTopic"
    case deviceTokenNotForTopic = "DeviceTokenNotForTopic"
    case duplicateHeaders = "DuplicateHeaders"
    case idleTimeout = "IdleTimeout"
    case missingDeviceToken = "MissingDeviceToken"
    case missingTopic = "MissingTopic supports multiple Topics"
    case payloadEmpty = "PayloadEmpty"
    case topicDisallowed = "TopicDisallowed"
    case badCertificate = "BadCertificate"
    case badCertificateEnvironment = "BadCertificateEnvironment"
    case expiredProviderToken = "ExpiredProviderToken"
    case forbidden = "Forbidden"
    case invalidProviderToken = "InvalidProviderToken"
    case missingProviderToken = "MissingProviderToken"
    case badPath = "BadPath"
    case methodNotAllowed = "MethodNotAllowed"
    case unregistered = "Unregistered"
    case payloadTooLarge = "PayloadTooLarge"
    case tooManyProviderTokenUpdates = "TooManyProviderTokenUpdates"
    case tooManyRequests = "TooManyRequests"
    case internalServerError = "InternalServerError"
    case serviceUnavailable = "ServiceUnavailable"
    case shutdown = "Shutdown"

    public var status: ServerStatus {
        switch self {
        case .badCollapseId: return .badRequest
        case .badDeviceToken: return .badRequest
        case .badExpirationDate: return .badRequest
        case .badMessageId: return .badRequest
        case .badPriority: return .badRequest
        case .badTopic: return .badRequest
        case .deviceTokenNotForTopic: return .badRequest
        case .duplicateHeaders: return .badRequest
        case .idleTimeout: return .badRequest
        case .missingDeviceToken: return .badRequest
        case .missingTopic: return .badRequest
        case .payloadEmpty: return .badRequest
        case .topicDisallowed: return .badRequest
        case .badCertificate: return .forbidden
        case .badCertificateEnvironment: return .forbidden
        case .expiredProviderToken: return .forbidden
        case .forbidden: return .forbidden
        case .invalidProviderToken: return .forbidden
        case .missingProviderToken: return .forbidden
        case .badPath: return .notFound
        case .methodNotAllowed: return .methodNotAllowed
        case .unregistered: return .gone
        case .payloadTooLarge: return .payloadTooLarge
        case .tooManyProviderTokenUpdates: return .tooManyRequests
        case .tooManyRequests: return .tooManyRequests
        case .internalServerError: return .internalServerError
        case .serviceUnavailable: return .serviceUnavailable
        case .shutdown: return .serviceUnavailable
        }
    }

    public var description: String {
        switch self {
        case .badCollapseId:
            return "The collapse identifier exceeds the maximum allowed size"
        case .badDeviceToken:
            return "The specified device token was bad. Verify that the request contains a valid"
        case .badExpirationDate:
            return "The apns-expiration value is bad"
        case .badMessageId:
            return "The apns-id value is bad"
        case .badPriority:
            return "The apns-priority value is bad"
        case .badTopic:
            return "The apns-topic was invalid"
        case .deviceTokenNotForTopic:
            return "The device token does not match the specified topic"
        case .duplicateHeaders:
            return "One or more headers were repeated"
        case .idleTimeout:
            return "Idle time out"
        case .missingDeviceToken:
            return "The device token is not specified in the request :path. Verify that"
        case .missingTopic:
            return "The apns-topic header of the request was not specified and was required. The"
        case .payloadEmpty:
            return "The message payload was empty"
        case .topicDisallowed:
            return "Pushing to this topic is not allowed"
        case .badCertificate:
            return "The certificate was bad"
        case .badCertificateEnvironment:
            return "The client certificate was for the wrong environment"
        case .expiredProviderToken:
            return "The provider token is stale and a new token should be generated"
        case .forbidden:
            return "The specified action is not allowed"
        case .invalidProviderToken:
            return "The provider token is not valid or the token signature could not"
        case .missingProviderToken:
            return "No provider certificate was used to connect to APNs and"
        case .badPath:
            return "The request contained a bad :path value"
        case .methodNotAllowed:
            return "The specified :method was not POST"
        case .unregistered:
            return "The device token is inactive for the specified topic."
        case .payloadTooLarge:
            return "The message payload was too large."
        case .tooManyProviderTokenUpdates:
            return "The provider token is being updated too often"
        case .tooManyRequests:
            return "Too many requests were made consecutively to the same device token"
        case .internalServerError:
            return "An internal server error occurred"
        case .serviceUnavailable:
            return "The service is unavailable"
        case .shutdown:
            return "The server is shutting down"
        }
    }
}
