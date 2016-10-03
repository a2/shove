public enum PushNotificationPriority {
    case normal, high

    var rawValue: Int {
        switch self {
        case .normal:
            return 5
        case .high:
            return 10
        }
    }
}
