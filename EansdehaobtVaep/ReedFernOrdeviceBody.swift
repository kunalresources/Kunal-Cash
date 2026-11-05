import Foundation

struct ReedFernOrdeviceBody: Encodable, ReedPayloadSign {
    let duneOrder: String
    let duneBody: ReedFernCevimceBody

    enum CodingKeys: String, CodingKey {
        case duneOrder = "orderId"
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: DynamicCodingKey.self)
        try c.encode(duneOrder, forKey: DynamicCodingKey("orderId"))
        try c.encode(duneBody.uuid, forKey: DynamicCodingKey("uuid"))
        try c.encode(duneBody.idfa, forKey: DynamicCodingKey("idfa"))
        try c.encode(duneBody.screenResolution, forKey: DynamicCodingKey("screenResolution"))
        try c.encode(duneBody.screenWidth, forKey: DynamicCodingKey("screenWidth"))
        try c.encode(duneBody.screenHeight, forKey: DynamicCodingKey("screenHeight"))
        try c.encode(duneBody.cpuNum, forKey: DynamicCodingKey("cpuNum"))
        try c.encode(duneBody.ramTotal, forKey: DynamicCodingKey("ramTotal"))
        try c.encode(duneBody.ramCanUse, forKey: DynamicCodingKey("ramCanUse"))
        try c.encode(duneBody.batteryLevel, forKey: DynamicCodingKey("batteryLevel"))
        try c.encode(duneBody.charged, forKey: DynamicCodingKey("charged"))
        try c.encode(duneBody.totalBootTime, forKey: DynamicCodingKey("totalBootTime"))
        try c.encode(duneBody.totalBootTimeWake, forKey: DynamicCodingKey("totalBootTimeWake"))
        try c.encode(duneBody.lastBootTime, forKey: DynamicCodingKey("lastBootTime"))
        try c.encode(duneBody.defaultLanguage, forKey: DynamicCodingKey("defaultLanguage"))
        try c.encode(duneBody.defaultTimeZone, forKey: DynamicCodingKey("defaultTimeZone"))
        try c.encode(duneBody.idfv, forKey: DynamicCodingKey("idfv"))
        try c.encode(duneBody.phoneMark, forKey: DynamicCodingKey("phoneMark"))
        try c.encode(duneBody.phoneType, forKey: DynamicCodingKey("phoneType"))
        try c.encode(duneBody.deviceType, forKey: DynamicCodingKey("deviceType"))
        try c.encode(duneBody.systemVersions, forKey: DynamicCodingKey("systemVersions"))
        try c.encode(duneBody.versionCode, forKey: DynamicCodingKey("versionCode"))
        try c.encode(duneBody.network, forKey: DynamicCodingKey("network"))
        try c.encode(duneBody.ssid, forKey: DynamicCodingKey("ssid"))
        try c.encode(duneBody.bssid, forKey: DynamicCodingKey("bssid"))
        try c.encode(duneBody.wifiName, forKey: DynamicCodingKey("wifiName"))
        try c.encode(duneBody.wifiBssid, forKey: DynamicCodingKey("wifiBssid"))
        try c.encode(duneBody.isvpn, forKey: DynamicCodingKey("isvpn"))
        try c.encode(duneBody.proxied, forKey: DynamicCodingKey("proxied"))
        try c.encode(duneBody.simulated, forKey: DynamicCodingKey("simulated"))
        try c.encode(duneBody.debugged, forKey: DynamicCodingKey("debugged"))
        try c.encode(duneBody.screenBrightness, forKey: DynamicCodingKey("screenBrightness"))
        try c.encode(duneBody.cashTotal, forKey: DynamicCodingKey("cashTotal"))
        try c.encode(duneBody.cashCanUse, forKey: DynamicCodingKey("cashCanUse"))
        try c.encode(duneBody.rooted, forKey: DynamicCodingKey("rooted"))
    }

    func waveSignSlices() -> [String] {
        [duneOrder]
    }
}

private struct DynamicCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int? = nil
    init(_ v: String) { stringValue = v }
    init?(stringValue: String) { self.stringValue = stringValue }
    init?(intValue: Int) { return nil }
}
