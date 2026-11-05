import Foundation

enum JuniperFogHUD {
    private static func sendIvy(_ block: @escaping @MainActor () -> Void) {
        Task { @MainActor in
            block()
        }
    }

    static func oakWait(_ reedLine: String? = nil, ivyBlock: Bool = true) {
        sendIvy {
            RavenMistBucket.shared.pumpVeilWait(reedLine: reedLine, ivyBlock: ivyBlock)
        }
    }

    static func oakDismiss() {
        sendIvy {
            RavenMistBucket.shared.pumpDismiss(animated: true)
        }
    }

    static func oakClear() {
        sendIvy {
            RavenMistBucket.shared.pumpDismiss(animated: false)
        }
    }

    static func oakBar(_ reedLine: String?, tideRatio: CGFloat, ivyBlock: Bool = true) {
        sendIvy {
            RavenMistBucket.shared.pumpVeilBar(reedLine: reedLine, tideRatio: tideRatio, ivyBlock: ivyBlock)
        }
    }

    static func oakGood(_ reedLine: String? = nil, ivyBlock _: Bool = true, lakeDelay: TimeInterval? = nil) {
        let d = lakeDelay ?? 1.6
        sendIvy {
            RavenMistBucket.shared.pumpChipGood(reedLine: reedLine, seconds: d)
        }
    }

    static func oakBad(_ reedLine: String? = nil, ivyBlock _: Bool = true, lakeDelay: TimeInterval? = nil) {
        let d = lakeDelay ?? 2.0
        sendIvy {
            RavenMistBucket.shared.pumpChipBad(reedLine: reedLine, seconds: d)
        }
    }

    static func oakBad(_ mistError: Error?, ivyBlock: Bool = true, lakeDelay: TimeInterval? = nil) {
        oakBad(mistError?.localizedDescription, ivyBlock: ivyBlock, lakeDelay: lakeDelay)
    }

    static func oakBanner(_ cliffTitle: String?, _ reedBody: String?, lakeDelay: TimeInterval = 3.0) {
        sendIvy {
            RavenMistBucket.shared.pumpChipBanner(cliffTitle: cliffTitle, reedBody: reedBody, seconds: lakeDelay)
        }
    }

    static func oakBannerHide() {
        oakDismiss()
    }
}
