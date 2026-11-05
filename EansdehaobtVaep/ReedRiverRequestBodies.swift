import Foundation

struct FogEnvelope<P: Encodable>: Encodable {
    var mistLeaf: String?
    var stoneLeaf: String?
    var calmApp: String
    var reedDevice: String
    var oakOS: Int
    var duneChannel: String
    var mistLanguage: String
    var cliffVersion: String
    var lakeTime: Int64
    var frostAPI: String
    var tideNonce: String
    var swiftSign: String
    var tideData: P

    enum CodingKeys: String, CodingKey {
        case mistLeaf = "userId"
        case stoneLeaf = "token"
        case calmApp = "appId"
        case reedDevice = "deviceId"
        case oakOS = "os"
        case duneChannel = "channel"
        case mistLanguage = "clientLanguage"
        case cliffVersion = "clientVersion"
        case lakeTime = "clientTime"
        case frostAPI = "version"
        case tideNonce = "nonce"
        case swiftSign = "sign"
        case tideData = "data"
    }
}

struct EmptyShell: Codable, ReedPayloadSign {
    func waveSignSlices() -> [String] { [] }
}

struct ReedStoneUserBody: Codable, ReedPayloadSign {
    let duneAdid: String?

    enum CodingKeys: String, CodingKey {
        case duneAdid = "adid"
    }

    func waveSignSlices() -> [String] { [] }
}

struct ReedSmsPayload: Encodable, ReedPayloadSign {
    let duneMobile: String
    let oakVerify: Int

    enum CodingKeys: String, CodingKey {
        case duneMobile = "mobile"
        case oakVerify = "verifyType"
    }

    func waveSignSlices() -> [String] {
        [duneMobile, String(oakVerify)]
    }
}

struct ReedWaveLogin: Encodable, ReedPayloadSign {
    let duneMobile: String
    let fogCode: String
    let cliffLo: String
    let cliffLa: String
    let mistImei: String
    let tideSerial: String

    enum CodingKeys: String, CodingKey {
        case duneMobile = "mobile"
        case fogCode = "verifyCode"
        case cliffLo = "longitude"
        case cliffLa = "latitude"
        case mistImei = "imei"
        case tideSerial = "serialNo"
    }

    func waveSignSlices() -> [String] {
        [duneMobile, fogCode, cliffLo, cliffLa, mistImei, tideSerial]
    }
}

struct ReedPineTermPayload: Encodable, ReedPayloadSign {
    let cedarProduct: String

    enum CodingKeys: String, CodingKey {
        case cedarProduct = "productId"
    }

    func waveSignSlices() -> [String] {
        [cedarProduct]
    }
}

struct ReedStoneStateBody: Encodable, ReedPayloadSign {
    let cedarProduct: String?

    enum CodingKeys: String, CodingKey {
        case cedarProduct = "productId"
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        if let line = cedarProduct?.trimmingCharacters(in: .whitespacesAndNewlines), !line.isEmpty {
            try c.encode(line, forKey: .cedarProduct)
        }
    }

    func waveSignSlices() -> [String] {
        []
    }
}

struct ReedStoneApplyBody: Encodable, ReedPayloadSign {
    let productIds: String
    let loanAmounts: String
    let loanTerms: String
    let longitude: String
    let latitude: String
    let imei: String
    let serialNo: String

    func waveSignSlices() -> [String] {
        [productIds, loanAmounts, loanTerms, longitude, latitude, imei, serialNo]
    }
}

struct ReedFernContactLeaf: Encodable {
    let contactName: String
    let contactPhone: String
    let contactUpdateTime: String
    let contactstorage: String
    let contactCount: String
    let contactTime: String

    init(contactName: String, contactPhone: String, contactUpdateTime: String) {
        self.contactName = contactName
        self.contactPhone = contactPhone
        self.contactUpdateTime = contactUpdateTime
        self.contactstorage = "0"
        self.contactCount = "-99"
        self.contactTime = ""
    }
}

struct ReedFernContactBody: Encodable, ReedPayloadSign {
    let duneOrder: String
    let duneList: [ReedFernContactLeaf]

    enum CodingKeys: String, CodingKey {
        case duneOrder = "orderId"
        case duneList = "list"
    }

    func waveSignSlices() -> [String] {
        [duneOrder]
    }
}

struct ReedFernReadyBody: Encodable, ReedPayloadSign {
    let duneOrder: String
    let duneLeaf: String?

    enum CodingKeys: String, CodingKey {
        case duneOrder = "orderId"
        case duneLeaf = "allowContact"
    }

    func waveSignSlices() -> [String] {
        [duneOrder]
    }
}

struct ReedFernOrderListBody: Encodable, ReedPayloadSign {
    let mossGate: Int

    enum CodingKeys: String, CodingKey {
        case mossGate = "orderStatus"
    }

    func waveSignSlices() -> [String] {
        []
    }
}

struct ReedBuryLeafBody: Encodable, ReedPayloadSign {
    let reedCode: String
    let reedText: String
    let reedNote1: String
    let reedNote2: String
    let reedNote3: String

    init(
        reedCode: String,
        reedText: String = "NULL",
        reedNote1: String = "NULL",
        reedNote2: String = "NULL",
        reedNote3: String = "NULL"
    ) {
        self.reedCode = reedCode
        self.reedText = reedText
        self.reedNote1 = reedNote1
        self.reedNote2 = reedNote2
        self.reedNote3 = reedNote3
    }

    enum CodingKeys: String, CodingKey {
        case reedCode = "eventCode"
        case reedText = "eventContent"
        case reedNote1 = "remark1"
        case reedNote2 = "remark2"
        case reedNote3 = "remark3"
    }

    func waveSignSlices() -> [String] {
        [reedCode, reedText, reedNote1, reedNote2, reedNote3]
    }
}

struct ReedFernCinerBody: Encodable, ReedPayloadSign {
    let dcUpFlag: String = "1"

    func waveSignSlices() -> [String] {
        []
    }
}
