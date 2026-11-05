import Foundation

final class CedarWrapProvider {
    static let shared = CedarWrapProvider()

    private init() {}

    func frostWrapped<P: Encodable & ReedPayloadSign>(tideData: P) -> FogEnvelope<P> {
        let reedDevice = OliveDeviceTag.shared.reedPebbleLine
        let tideNonce = Self.randomNonce()
        let lakeTime = Int64(Date().timeIntervalSince1970 * 1000)
        let cliffVersion = Self.cliffClientVersion
        let dataSlices = tideData.waveSignSlices()
        let sign = SwiftRiverSeal.thirdMark(
            appSlice: PebbleFlint.calmAppValue,
            deviceSlice: reedDevice,
            channelSlice: PebbleFlint.duneChannelValue,
            nonceSlice: tideNonce,
            versionSlice: PebbleFlint.frostAPIValue,
            dataSlices: dataSlices,
            salt: PebbleFlint.saltSeal
        )
        return FogEnvelope(
            mistLeaf: BridgeGateSession.shared.mistLeaf,
            stoneLeaf: BridgeGateSession.shared.stoneLeaf,
            calmApp: PebbleFlint.calmAppValue,
            reedDevice: reedDevice,
            oakOS: PebbleFlint.oakOSValue,
            duneChannel: PebbleFlint.duneChannelValue,
            mistLanguage: PebbleFlint.mistLanguageValue,
            cliffVersion: cliffVersion,
            lakeTime: lakeTime,
            frostAPI: PebbleFlint.frostAPIValue,
            tideNonce: tideNonce,
            swiftSign: sign,
            tideData: tideData
        )
    }

    func coastQueryStrings<P: Encodable>(envelope: FogEnvelope<P>) -> [String: String] {
        let enc = JSONEncoder()
        guard let data = try? enc.encode(envelope),
              let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else { return [:] }
        var map: [String: String] = [:]
        for (key, value) in obj {
            switch value {
            case let s as String:
                map[key] = s
            case let i as Int:
                map[key] = String(i)
            case let i as Int64:
                map[key] = String(i)
            case let b as Bool:
                map[key] = b ? "true" : "false"
            case let n as NSNumber:
                map[key] = n.stringValue
            case let d as [String: Any]:
                if let json = try? JSONSerialization.data(withJSONObject: d),
                   let str = String(data: json, encoding: .utf8) {
                    map[key] = str
                }
            case is NSNull:
                map[key] = ""
            default:
                if JSONSerialization.isValidJSONObject([value]),
                   let json = try? JSONSerialization.data(withJSONObject: value),
                   let str = String(data: json, encoding: .utf8) {
                    map[key] = str
                }
            }
        }
        return map
    }

    private static var cliffClientVersion: String {
        (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "0"
    }

    private static func randomNonce() -> String {
        let chars = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        return String((0 ..< 16).map { _ in chars.randomElement()! })
    }
}
