import Foundation

final class RiverBuryDrift {
    static let shared = RiverBuryDrift()

    private init() {}

    func reedTap(_ code: String) {
        let body = ReedBuryLeafBody(reedCode: code)
        MeadowRelay.shared.runPine(.reedBury(body), sandType: EmptyShell.self) { _ in }
    }
}
