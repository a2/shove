import Foundation

public struct PushResponse {
    public var id: UUID
    public var status: ServerStatus
    public var error: ServerError?
    public var timestamp: Date?

    public init(id: UUID, status: ServerStatus, error: ServerError?, timestamp: Date?) {
        self.id = id
        self.status = status
        self.error = error
        self.timestamp = timestamp
    }
}
