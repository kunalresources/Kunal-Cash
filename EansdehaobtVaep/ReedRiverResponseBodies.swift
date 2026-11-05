import Foundation

struct FogResponse<T: Codable>: Codable {
    var swiftCode: Int
    var fogMsg: String?
    var tideData: T?

    enum CodingKeys: String, CodingKey {
        case swiftCode = "resultCode"
        case fogMsg = "resultMsg"
        case tideData = "data"
    }
}

struct MistLoginTide: Codable {
    let mistLeafId: String?
    let stoneLeafValue: String?

    enum CodingKeys: String, CodingKey {
        case mistLeafId = "userId"
        case stoneLeafValue = "token"
    }
}

struct LichenKycVaultShell: Codable {
    let reefMossList: [ReedKycMossRow]?

    enum CodingKeys: String, CodingKey {
        case reefMossList = "kycList"
    }
}

struct ReedKycMossRow: Codable {
    let oakShellId: String?
    let reedSort: Int?
    let mistGate: String?
    let tideType: Int?

    enum CodingKeys: String, CodingKey {
        case oakShellId = "kycId"
        case reedSort = "kycSort"
        case mistGate = "kycStatus"
        case tideType = "kycType"
    }
}

extension Array where Element == ReedKycMossRow {
    
    func driftPendingShellId() -> String? {
        let ordered = sorted { ($0.reedSort ?? Int.max) < ($1.reedSort ?? Int.max) }
        guard let row = ordered.first(where: { ($0.mistGate ?? "").trimmingCharacters(in: .whitespacesAndNewlines) != "1" }) else {
            return nil
        }
        let t = row.oakShellId?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return t.isEmpty ? nil : t
    }
}

struct TideStoneApplyShell: Codable {
    var orderId: String
}

struct SpitalProcedures: Codable {
    var list: [TideStoneApplyShell]
}

struct TideSuphomeShell: Codable {
    var mossStatus: Int?
    var mossType: Int?
    var mossHas: Int?
    var mossCopy: String?
    var mossDust: String?
    var mossOption: String?
    var mossMix: Int?

    enum CodingKeys: String, CodingKey {
        case mossStatus = "userStatus"
        case mossType = "appUserType"
        case mossHas = "hasOrder"
        case mossCopy = "promptCopy"
        case mossDust = "withdrawalOrderId"
        case mossOption = "firstLoanOptionLine"
        case mossMix = "maxApplyAmount"
    }
}

struct ReedAmberCardShell: Codable {
    let reedCardList: [ReedAmberCardItem]?

    enum CodingKeys: String, CodingKey {
        case reedCardList = "bankCardList"
    }
}

struct ReedAmberCardItem: Codable {
    let reedBind: String?
    let reedCode: String?
    let reedBank: String?
    let reedNo: String?
    let reedName: String?
    
    let reedAccountType: String?

    enum CodingKeys: String, CodingKey {
        case reedBind = "bindId"
        case reedCode = "bankCode"
        case reedBank = "bankName"
        case reedNo = "accountNo"
        case reedName = "accountName"
        case reedAccountType = "accountType"
    }
}

struct TideCedarWaveShell: Codable {
    let reedLatest: String?
    let reedType: String?
    let reedHref: String?

    enum CodingKeys: String, CodingKey {
        case reedLatest = "latestVersion"
        case reedType = "updateType"
        case reedHref = "latestVersionUrl"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        reedLatest = try? c.decode(String.self, forKey: .reedLatest)
        reedHref = try? c.decode(String.self, forKey: .reedHref)
        if let s = try? c.decode(String.self, forKey: .reedType) {
            reedType = s
        } else if let i = try? c.decode(Int.self, forKey: .reedType) {
            reedType = String(i)
        } else {
            reedType = nil
        }
    }
}

struct TideFernOrderItem: Codable {
    var mossLine: String?
    var mossStone: String?
    var mossName: String?
    var mossWave: String?
    var mossStart: String?
    var mossLoan: String?
    var mossDue: String?
    var mossRepay: String?
    var mossGate: Int?

    enum CodingKeys: String, CodingKey {
        case mossLine = "orderId"
        case mossStone = "productId"
        case mossName = "productName"
        case mossWave = "loanAmount"
        case mossStart = "applyDate"
        case mossLoan = "loanDate"
        case mossDue = "dueDate"
        case mossRepay = "repayDate"
        case mossGate = "orderStatus"
    }
}

struct TideFernOrderListShell: Codable {
    var mossRows: [TideFernOrderItem]?

    enum CodingKeys: String, CodingKey {
        case mossRows = "orderList"
    }
}


struct CoralDuneDynamic: Codable {
    let rejectH5: String?
}

struct CoralAppConfigShell: Codable {
    let reedPlumGuide: Int?
    let reedLeafContact: Int?
    let reedLeafMax: Int?
    let reedLeafStep: Int?
    let ivyDynamic: CoralDuneDynamic?

    enum CodingKeys: String, CodingKey {
        case reedPlumGuide = "feedbackGuidance"
        case reedLeafContact = "retrieveMobileContact"
        case reedLeafMax = "pushMaxCount"
        case reedLeafStep = "pushPerCount"
        case ivyDynamic = "dynamicParameter"
    }

    var driftLeafContact: Int {
        reedLeafContact ?? 0
    }

    var driftLeafMax: Int {
        let v = reedLeafMax ?? 0
        return v > 0 ? v : 0
    }

    var driftLeafStep: Int {
        let v = reedLeafStep ?? 0
        return v > 0 ? v : 50
    }

    var driftPlumGuide: Int {
        reedPlumGuide ?? 0
    }

    private func rustLakeHrefTrimmed(_ raw: String?) -> String? {
        let t = raw?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return t.isEmpty ? nil : t
    }
}

struct TideUserInfoShell: Codable {
    let reedPhone: String?
    let reedName: String?
    let reedUserStatus: Int?
    let reedAppUserType: Int?
    let reedBankSwitch: String?

    enum CodingKeys: String, CodingKey {
        case reedPhone = "phone"
        case reedName = "name"
        case reedUserStatus = "userStatus"
        case reedAppUserType = "appUserType"
        case reedBankSwitch = "payAccountModifySwitch"
    }
}



struct SurvivalVary: Codable {
    var loanTerm: Int
}

struct FigsColorectal: Codable {
    var loanAmount: String
    var termDetailList: [SurvivalVary]
}

struct AccordMonlrosta: Codable {
    var productId: String
    var amountDetailList: [FigsColorectal]
}


struct TideTermNoticeShell: Codable {
    var productId: String
    var productName: String
    var productTermV3Response: AccordMonlrosta
}

struct MilitaryDrones: Codable {
    let productInfoList: [TideTermNoticeShell]?
}



