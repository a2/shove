import Foundation

public struct PushNotification {
    public var payload: Data
    public var priority: PushNotificationPriority?
    public var id: UUID?
    public var expirationDate: Date?
    public var topic: String?

    public init(payload: Data, priority: PushNotificationPriority? = nil, id: UUID? = nil, expirationDate: Date? = nil, topic: String? = nil) {
        self.payload = payload
        self.priority = priority
        self.id = id
        self.expirationDate = expirationDate
        self.topic = topic
    }
}
