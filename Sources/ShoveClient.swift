import Foundation

public class ShoveClient {
    public typealias Result<T> = () throws -> T

    var baseURL: URL
    let session: URLSession
    let tokenGenerator: JSONWebTokenGenerator
    var authorization: (token: String, timestamp: Date)?

    public init(tokenGenerator: JSONWebTokenGenerator, options: ShoveClientOptions = ShoveClientOptions()) {
        self.baseURL = options.baseURL
        self.session = URLSession(configuration: options.sessionConfiguration)
        self.tokenGenerator = tokenGenerator
    }

    func makeAuthorizationToken() -> String {
        if let (token, timestamp) = authorization, timestamp.timeIntervalSinceNow >= -3600 {
            return token
        } else {
            let timestamp = Date()
            let token = tokenGenerator.jsonWebToken(timestamp: timestamp)
            authorization = (token, timestamp)
            return token
        }
    }

    func configure(request: inout URLRequest, for notification: PushNotification) {
        request.httpBody = notification.payload
        request.httpMethod = "POST"

        if let topic = notification.topic {
            request.setValue(topic, forHTTPHeaderField: "apns-topic")
        }

        if let priority = notification.priority {
            request.setValue(String(priority.rawValue), forHTTPHeaderField: "apns-priority")
        }

        if let id = notification.id {
            request.setValue(id.uuidString, forHTTPHeaderField: "apns-id")
        }

        if let expirationDate = notification.expirationDate {
            request.setValue(String(Int(expirationDate.timeIntervalSince1970)), forHTTPHeaderField: "apns-expiration")
        }
    }

    @discardableResult
    public func send(notification: PushNotification, to deviceToken: String, shouldBeginRequest: Bool = true, completionHandler: @escaping (Result<PushResponse>) -> Void = { _ in }) -> URLSessionTask {
        var request = URLRequest(url: baseURL.appendingPathComponent(deviceToken))
        request.setValue("Bearer \(makeAuthorizationToken())", forHTTPHeaderField: "Authorization")
        configure(request: &request, for: notification)

        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                #if os(Linux)
                    let apnsIdString = httpResponse.allHeaderFields["apns-id"]!
                #else
                    let apnsIdString = httpResponse.allHeaderFields["apns-id"] as! String
                #endif

                let apnsId = UUID(uuidString: apnsIdString)!
                let status = ServerStatus(rawValue: httpResponse.statusCode)!

                let error: ServerError?
                let timestamp: Date?
                if let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] {
                    error = ServerError(rawValue: json["reason"] as! String)
                    timestamp = Date(timeIntervalSince1970: (json["timestamp"] as! NSNumber).doubleValue)
                } else {
                    error = nil
                    timestamp = nil
                }

                let response = PushResponse(id: apnsId, status: status, error: error, timestamp: timestamp)
                completionHandler { response }
            } else if let error = error {
                completionHandler { throw error }
            }
        }

        if shouldBeginRequest {
            task.resume()
        }

        return task
    }
}
