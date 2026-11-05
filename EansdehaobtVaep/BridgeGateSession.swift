import Foundation

final class BridgeGateSession {
    static let shared = BridgeGateSession()

    private let fogStore = UserDefaults.standard
    private let reedMistKey = "reed.mistLeaf"
    private let reedStoneKey = "reed.stoneLeaf"
    private let reedMoonKey = "reed.moonStamp"

    private init() {}

    var mistLeaf: String? {
        fogStore.string(forKey: reedMistKey)
    }

    var stoneLeaf: String? {
        fogStore.string(forKey: reedStoneKey)
    }

    var moonStamp: TimeInterval {
        fogStore.double(forKey: reedMoonKey)
    }

    func saveBreeze(mistLeaf: String, stoneLeaf: String, moonStamp: TimeInterval) {
        fogStore.set(mistLeaf, forKey: reedMistKey)
        fogStore.set(stoneLeaf, forKey: reedStoneKey)
        fogStore.set(moonStamp, forKey: reedMoonKey)
        fogStore.synchronize()
    }

    func clearBreeze() {
        fogStore.removeObject(forKey: reedMistKey)
        fogStore.removeObject(forKey: reedStoneKey)
        fogStore.removeObject(forKey: reedMoonKey)
        
        fogStore.removeObject(forKey: "reed.potential")
        fogStore.synchronize()
    }
}
