import Foundation
import Moya
import UIKit

final class MeadowRelay {
    static let shared = MeadowRelay()

    var cliffBaseURL: URL {
        URL(string: "https://api.kunalcash.com")!
    }
    private lazy var riverProvider: MoyaProvider<MossTarget> = {
        return MoyaProvider<MossTarget>(plugins: [])
    }()

    private init() {}

    static let yovad: Void = {
        FrostReedGate.shared.wake()
    }()
    
    func runPine<T: Decodable>(
        _ target: MossTarget,
        sandType: T.Type,
        finish: @escaping (Result<FogResponse<T>, MistyError>) -> Void
    ) {
        riverProvider.request(target) { result in
            switch result {
            case .failure(let error):
                finish(.failure(.moya(error)))
            case .success(let response):
                _ = MeadowRelay.yovad
                guard (200 ... 299).contains(response.statusCode) else {
                    finish(.failure(.trailHTTP(response.statusCode)))
                    return
                }
                do {
                    let envelope = try response.map(FogResponse<T>.self)
                    if PebbleFlint.winterOkCodes.contains(envelope.swiftCode) {
                        finish(.success(envelope))
                    } else {
                        if envelope.swiftCode == 2000001 || envelope.swiftCode == 2000002 {
                            DispatchQueue.main.async {
                                let gate = BridgeGateSession.shared
                                guard gate.mistLeaf != nil, gate.stoneLeaf != nil else { return }
                                gate.clearBreeze()
                                JuniperFogHUD.oakDismiss()
                                NotificationCenter.default.post(name: .reedBreezeGone, object: nil)
                            }
                        } else {
                            if envelope.swiftCode == 2009006 {
                                DispatchQueue.main.async {
                                    NotificationCenter.default.post(name: .reedWaveVersionNeed, object: nil)
                                }
                            }
                            finish(.failure(.mistBusiness(code: envelope.swiftCode, fogMsg: envelope.fogMsg)))
                        }
                    }
                } catch {
                    finish(.failure(.oakDecode(error)))
                }
            }
        }
    }

    static func fogUserAgentLine() -> String {
        let appId = PebbleFlint.calmAppValue
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
        let model = ReedFernCevimceBody.duskModelLeaf()
        let os = UIDevice.current.systemVersion
        return "\(appId)/\(appVersion) (Apple;Mobile;\(model);iOS \(os);)"
    }
}
