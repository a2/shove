import CLibreSSL
import Foundation

public struct JSONWebTokenGenerator {
    public let key: SigningKey
    public let keyID: String
    public let teamID: String

    public init(key: SigningKey, keyID: String, teamID: String) {
        self.key = key
        self.keyID = keyID
        self.teamID = teamID
    }

    public func jsonWebToken(timestamp: Date = Date()) -> String {
        let header: [String: Any] = ["alg": "ES256", "kid": keyID]
        let headerData = try! JSONSerialization.data(withJSONObject: header)

        let payload: [String: Any] = ["iss": teamID, "iat": Int(timestamp.timeIntervalSince1970)]
        let payloadData = try! JSONSerialization.data(withJSONObject: payload)

        let message = headerData.base64URLEncodedString() + "." + payloadData.base64URLEncodedString()
        let digest = sha256(message: message.data(using: .utf8)!)
        let signature = key.sign(digest: digest)
        return message + "." + signature.base64URLEncodedString()
    }
}

extension Data {
    func base64URLEncodedString(options: Base64EncodingOptions = []) -> String {
        var string = base64EncodedString(options: options)
        string.withMutableCharacters { characters in
            var i = characters.startIndex
            while i < characters.endIndex {
                switch characters[i] {
                case "=":
                    characters.replaceSubrange(i ... i, with: [])
                case "+":
                    characters.replaceSubrange(i ... i, with: ["-"])
                    characters.formIndex(after: &i)
                case "/":
                    characters.replaceSubrange(i ... i, with: ["_"])
                    characters.formIndex(after: &i)
                default:
                    characters.formIndex(after: &i)
                }
            }
        }

        return string
    }
}

func sha256(message: Data) -> Data {
    var ctx = SHA256_CTX()
    SHA256_Init(&ctx)

    message.enumerateBytes { buffer, _, _ in
        SHA256_Update(&ctx, buffer.baseAddress, buffer.count)
    }

    var digest = Data(count: Int(SHA256_DIGEST_LENGTH))
    _ = digest.withUnsafeMutableBytes { mptr in
        SHA256_Final(mptr, &ctx)
    }
    
    return digest
}
