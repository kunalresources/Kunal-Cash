import AppTrackingTransparency
import AdjustSdk
import Foundation
import Network

final class FrostReedGate {
    static let shared = FrostReedGate()

    private let queue = DispatchQueue(label: "frost.reed.thread")
    private var didHandle = false

    func wake() {
        guard ATTrackingManager.trackingAuthorizationStatus == .notDetermined else {
            reedMarkAttStatus(ATTrackingManager.trackingAuthorizationStatus)
            reedInitAdjustIfNeeded()
            return
        }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .seconds(1)) {
            ATTrackingManager.requestTrackingAuthorization { status in
                self.reedMarkAttStatus(status)
                self.reedInitAdjustIfNeeded()
            }
        }
        
    }
    
    private static var reedAdjustInited = false
    private let reedAdjustLock = NSLock()

    private func reedInitAdjustIfNeeded() {
        reedAdjustLock.lock()
        defer { reedAdjustLock.unlock() }
        guard !Self.reedAdjustInited else { return }
        let reedConfig = ADJConfig(appToken: "mpzh1ewhjjsw", environment: ADJEnvironmentProduction, suppressLogLevel: true)
        Adjust.initSdk(reedConfig)
        Self.reedAdjustInited = true
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .reedAdjustReady, object: nil)
        }
    }

    func reedAdjustReady() -> Bool {
        reedAdjustLock.lock()
        defer { reedAdjustLock.unlock() }
        return Self.reedAdjustInited
    }

    func reedFetchAdjustAdid(done: @escaping (String?) -> Void) {
        Adjust.adid { line in
            done(line)
        }
    }

    private func reedMarkAttStatus(_ status: ATTrackingManager.AuthorizationStatus) {
        switch status {
        case .authorized:
            RiverBuryDrift.shared.reedTap("17")
        case .denied, .restricted:
            RiverBuryDrift.shared.reedTap("18")
        case .notDetermined:
            break
        @unknown default:
            RiverBuryDrift.shared.reedTap("18")
        }
    }
}
