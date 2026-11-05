import Combine
import Foundation
import UIKit
import SwiftUI

extension Notification.Name {
    static let coralReefTabPick = Notification.Name("coralReefTabPick")
    static let reedEmiExitToHome = Notification.Name("reedEmiExitToHome")
    static let duneReefRefresh = Notification.Name("duneReefRefresh")
    static let reedOakHistoryEnter = Notification.Name("reedOakHistoryEnter")
    static let reedWaveVersionNeed = Notification.Name("reedWaveVersionNeed")
    static let reedBreezeGone = Notification.Name("reedBreezeGone")
    static let reedWaveVersionGone = Notification.Name("reedWaveVersionGone")
    static let reedOfficialPopupShow = Notification.Name("reedOfficialPopupShow")
    static let reedAdjustReady = Notification.Name("reedAdjustReady")
}

struct DuringAcrossFrom {
    static var diagnosed = false
}

enum ReedWaveGate {
    static var reedState = 0
}

@MainActor
enum ReedWaveMistLift {
    private static var reedWaveOnce = false
    private static var reedWaveBusy = false
    private static var reedWaveForce = false

    static func mossKickOnceIfNeeded() {
        guard !reedWaveOnce else { return }
        reedWaveOnce = true
        ReedWaveGate.reedState = 1
        mossWaveCheck(forceOnce: true)
    }

    static func mossWaveCheck(forceOnce: Bool) {
        if forceOnce, reedWaveForce {
            ReedWaveGate.reedState = 5
            return
        }
        guard !reedWaveBusy else { return }
        reedWaveBusy = true
        ReedWaveGate.reedState = 1
        MeadowRelay.shared.runPine(.cedarWave(EmptyShell()), sandType: TideCedarWaveShell.self) { result in
            DispatchQueue.main.async {
                reedWaveBusy = false
                switch result {
                case let .success(env):
                    guard let shell = env.tideData else {
                        ReedWaveGate.reedState = 2
                        return
                    }
                    mossWaveShowIfNeeded(shell)
                case let .failure(err):
                    if case let .mistBusiness(code, _) = err, code == 2009006 {
                        return
                    }
                    ReedWaveGate.reedState = 2
                }
            }
        }
    }

    private static func mossWaveShowIfNeeded(_ shell: TideCedarWaveShell) {
        let raw = shell.reedType?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let href = shell.reedHref?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !href.isEmpty, let url = URL(string: href), let sc = url.scheme?.lowercased(), sc == "http" || sc == "https" else {
            ReedWaveGate.reedState = 2
            return
        }
        if raw == "2" {
            reedWaveForce = true
            ReedWaveGate.reedState = 5
            CedarCommonDialog.driftShow(
                reedTitle: "upgrade",
                tideBody: "A new version has been found",
                mistAlign: .center,
                sandLeft: nil,
                sandRight: "upgrade",
                leftTap: {},
                rightTap: {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            )
            return
        }
        guard raw == "1" else {
            ReedWaveGate.reedState = 2
            return
        }
        ReedWaveGate.reedState = 3
        CedarCommonDialog.driftShow(
            reedTitle: "upgrade",
            tideBody: "A new version has been found",
            mistAlign: .center,
            sandLeft: "Cancel",
            sandRight: "upgrade",
            leftTap: {
                CedarCommonDialog.driftDismiss()
                ReedWaveGate.reedState = 4
                NotificationCenter.default.post(name: .reedWaveVersionGone, object: nil)
            },
            rightTap: {
                CedarCommonDialog.driftDismiss()
                ReedWaveGate.reedState = 4
                NotificationCenter.default.post(name: .reedWaveVersionGone, object: nil)
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        )
    }
}

final class ReedDriftStripGate: ObservableObject {
    static let shared = ReedDriftStripGate()

    @Published private(set) var mossHideTab = false
    private var mossDepth = 0

    private init() {}

    func mossPush() {
        mossDepth += 1
        mossHideTab = true
    }

    func mossPop() {
        guard mossDepth > 0 else { return }
        mossDepth -= 1
        mossHideTab = mossDepth > 0
    }

    func mossPush(_ hidden: inout Bool) {
        mossPush()
        hidden = mossHideTab
    }

    func mossPop(_ hidden: inout Bool) {
        mossPop()
        hidden = mossHideTab
    }

    func mossApplyProfileNav(_ hidden: inout Bool, subNavShown: Bool, hadSubNav: Bool) {
        if subNavShown, !hadSubNav {
            mossPush(&hidden)
        } else if hadSubNav, !subNavShown {
            mossPop(&hidden)
        }
    }
}
