import CLibreSSL
import Foundation

public class SigningKey {
    private let opaqueKey: OpaquePointer

    public init?(url: URL, passphrase: String? = nil) {
        let bio = url.withUnsafeFileSystemRepresentation { fsr in BIO_new_file(fsr, "r") }
        guard bio != nil else {
            return nil
        }

        let read: (UnsafeMutableRawPointer?) -> OpaquePointer? = { u in PEM_read_bio_ECPrivateKey(bio!, nil, nil, u) }

        let pointer: OpaquePointer?
        if var utf8 = passphrase?.utf8CString {
            pointer = utf8.withUnsafeMutableBufferPointer { mptr in read(mptr.baseAddress) }
        } else {
            pointer = read(nil)
        }

        BIO_free(bio!)

        if let pointer = pointer {
            self.opaqueKey = pointer
        } else {
            return nil
        }
    }

    deinit {
        EC_KEY_free(opaqueKey)
    }

    public func sign(digest: Data) -> Data {
        let sig = digest.withUnsafeBytes { ptr in ECDSA_do_sign(ptr, Int32(digest.count), opaqueKey) }
        defer { ECDSA_SIG_free(sig) }

        var der = Data(count: Int(ECDSA_size(opaqueKey)))
        _ = der.withUnsafeMutableBytes { (mptr: UnsafeMutablePointer<UInt8>) -> Int32 in
            var copy = Optional.some(mptr)
            return i2d_ECDSA_SIG(sig, &copy)
        }

        return der
    }

    public func verify(digest: Data, signature: Data) -> Bool {
        var signature = signature
        let sig = signature.withUnsafeBytes { (ptr: UnsafePointer<UInt8>) -> UnsafeMutablePointer<ECDSA_SIG> in
            var copy = Optional.some(ptr)
            return d2i_ECDSA_SIG(nil, &copy, signature.count)
        }

        defer { ECDSA_SIG_free(sig) }

        let result = digest.withUnsafeBytes { ptr in
            return ECDSA_do_verify(ptr, Int32(digest.count), sig, opaqueKey)
        }

        return result == 1
    }
}
