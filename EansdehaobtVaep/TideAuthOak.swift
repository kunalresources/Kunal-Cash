import Combine
import Foundation
import SwiftUI

final class TideAuthOak: ObservableObject {
    @Published var duneSigned: Bool

    init() {
        let s = BridgeGateSession.shared
        duneSigned = (s.mistLeaf != nil) && (s.stoneLeaf != nil)
    }

    func refreshReedGate() {
        let s = BridgeGateSession.shared
        duneSigned = (s.mistLeaf != nil) && (s.stoneLeaf != nil)
    }
}
