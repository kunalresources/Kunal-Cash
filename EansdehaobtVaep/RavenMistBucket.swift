import Combine
import SwiftUI

@MainActor
final class RavenMistBucket: ObservableObject {
    static let shared = RavenMistBucket()

    enum FrostBladeShape: Equatable {
        case idle
        case veilWait(text: String?, blockBelow: Bool)
        case veilBar(text: String?, ratio: CGFloat, blockBelow: Bool)
        case chipGood(text: String?, seconds: TimeInterval)
        case chipBad(text: String?, seconds: TimeInterval)
        case chipBanner(top: String?, detail: String?, seconds: TimeInterval)
    }

    @Published private(set) var blade: FrostBladeShape = .idle

    private var tickSalt = UUID()
    private var waveTask: Task<Void, Never>?
    private var mistKeepUntil: Date?

    private init() {}

    private func stopWave() {
        waveTask?.cancel()
        waveTask = nil
    }

    private func startWave(seconds: TimeInterval) {
        stopWave()
        tickSalt = UUID()
        let stone = tickSalt
        waveTask = Task {
            let ns = UInt64(max(0.05, seconds) * 1_000_000_000)
            try? await Task.sleep(nanoseconds: ns)
            guard !Task.isCancelled else { return }
            await MainActor.run {
                guard self.tickSalt == stone else { return }
                withAnimation(.easeOut(duration: 0.18)) {
                    self.blade = .idle
                }
            }
        }
    }

    func pumpVeilWait(reedLine: String?, ivyBlock: Bool) {
        stopWave()
        mistKeepUntil = nil
        withAnimation(.easeOut(duration: 0.18)) {
            blade = .veilWait(text: reedLine, blockBelow: ivyBlock)
        }
    }

    func pumpVeilBar(reedLine: String?, tideRatio: CGFloat, ivyBlock: Bool) {
        stopWave()
        mistKeepUntil = nil
        withAnimation(.easeOut(duration: 0.18)) {
            blade = .veilBar(text: reedLine, ratio: tideRatio, blockBelow: ivyBlock)
        }
    }

    func pumpChipGood(reedLine: String?, seconds: TimeInterval) {
        stopWave()
        mistKeepUntil = Date().addingTimeInterval(max(0.6, min(seconds, 1.2)))
        withAnimation(.easeOut(duration: 0.18)) {
            blade = .chipGood(text: reedLine, seconds: seconds)
        }
        startWave(seconds: seconds)
    }

    func pumpChipBad(reedLine: String?, seconds: TimeInterval) {
        stopWave()
        mistKeepUntil = Date().addingTimeInterval(max(1.2, min(seconds, 1.8)))
        withAnimation(.easeOut(duration: 0.18)) {
            blade = .chipBad(text: reedLine, seconds: seconds)
        }
        startWave(seconds: seconds)
    }

    func pumpChipBanner(cliffTitle: String?, reedBody: String?, seconds: TimeInterval) {
        stopWave()
        mistKeepUntil = Date().addingTimeInterval(max(0.8, min(seconds, 1.4)))
        withAnimation(.easeOut(duration: 0.18)) {
            blade = .chipBanner(top: cliffTitle, detail: reedBody, seconds: seconds)
        }
        startWave(seconds: seconds)
    }

    func pumpDismiss(animated: Bool) {
        if animated,
           let until = mistKeepUntil,
           Date() < until,
           reedIsChipBlade(blade) {
            return
        }
        stopWave()
        mistKeepUntil = nil
        if animated {
            withAnimation(.easeOut(duration: 0.2)) {
                blade = .idle
            }
        } else {
            var tx = Transaction()
            tx.disablesAnimations = true
            withTransaction(tx) {
                blade = .idle
            }
        }
    }

    private func reedIsChipBlade(_ blade: FrostBladeShape) -> Bool {
        switch blade {
        case .chipGood, .chipBad, .chipBanner:
            return true
        default:
            return false
        }
    }
}
