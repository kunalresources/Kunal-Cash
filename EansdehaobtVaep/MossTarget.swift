import Alamofire
import Foundation
import Moya

enum MossTarget {
    case quietLake(EmptyShell)
    case cedarWave(EmptyShell)
    case stoneUser(ReedStoneUserBody)
    case amberCard(EmptyShell)
    case stoneLogout(EmptyShell)
    case stoneClose(EmptyShell)
    case riverVault(EmptyShell)
    case amberMud(ReedSmsPayload)
    case birchGate(ReedWaveLogin)
    case jadeBay(ReedFernCinerBody)
    case fernQuartz(ReedFernCevimceBody)
    case fernStone(ReedFernOrdeviceBody)
    case fernMist(ReedFernContactBody)
    case fernWave(ReedFernReadyBody)
    case fernOrder(ReedFernOrderListBody)
    case stoneApply(ReedStoneApplyBody)
    case reedBury(ReedBuryLeafBody)
    case dernisin(EmptyShell)
}

extension MossTarget: TargetType {
    var baseURL: URL {
        MeadowRelay.shared.cliffBaseURL
    }

    var path: String {
        switch self {
        case .quietLake:
            return "/app/v3/app/config"
        case .cedarWave:
            return "/app/v3/app/versionV2"
        case .stoneUser:
            return "/app/v3/user/info"
        case .amberCard:
            return "/app/v3/bankcard/list"
        case .stoneLogout:
            return "/app/v3/auth/logout"
        case .stoneClose:
            return "/app/v3/auth/close"
        case .riverVault:
            return "/app/v3/kyc/status"
        case .amberMud:
            return "/app/v3/sms/sendVerifySms"
        case .birchGate:
            return "/app/v3/auth/registerOrLogin"
        case .jadeBay:
            return "/app/v3/user/suphome"
        case .fernQuartz:
            return "/app/v3/mobile/registerDevice"
        case .fernStone:
            return "/app/v3/mobile/device"
        case .fernMist:
            return "/app/v3/mobile/contact"
        case .fernWave:
            return "/app/v3/order/ready"
        case .fernOrder:
            return "/app/v3/order/list"
        case .stoneApply:
            return "/app/v3/order/userSubmitDcUpgrade"
        case .reedBury:
            return "/app/v3/bury/record"
        case .dernisin:
            return "/app/v3/product/dcRecommend"
        }
    }

    var method: Moya.Method { .post }

    var task: Task {
        switch self {
        case .quietLake(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .cedarWave(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .stoneUser(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .amberCard(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .stoneLogout(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .stoneClose(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .riverVault(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .amberMud(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .birchGate(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .jadeBay(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .fernQuartz(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .fernStone(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .fernMist(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .fernWave(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .fernOrder(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .stoneApply(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .reedBury(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        case .dernisin(let fog):
            let body = CedarWrapProvider.shared.frostWrapped(tideData: fog)
            return .requestJSONEncodable(body)
        }
    }

    var headers: [String: String]? {
        ["User-Agent": MeadowRelay.fogUserAgentLine()]
    }

    var validationType: ValidationType { .successCodes }

    var sampleData: Data { Data() }
}
