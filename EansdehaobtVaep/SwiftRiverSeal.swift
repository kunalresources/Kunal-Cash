import CryptoKit
import Foundation

enum SwiftRiverSeal {
    
    static func thirdMark(
        appSlice: String,
        deviceSlice: String,
        channelSlice: String,
        nonceSlice: String,
        versionSlice: String,
        dataSlices: [String],
        salt: String
    ) -> String {
        var bucket: [String] = [appSlice, deviceSlice, channelSlice, nonceSlice, versionSlice]
        bucket.append(contentsOf: dataSlices)
        let sorted = bucket.sorted(by: >)
        let joined = sorted.joined(separator: ";")
        let stringA = joined + salt
        return stringA.md5UpperHex()
    }
}

private extension String {
    func md5UpperHex() -> String {
        let digest = Insecure.MD5.hash(data: Data(utf8))
        return digest.map { String(format: "%02X", $0) }.joined()
    }
}
