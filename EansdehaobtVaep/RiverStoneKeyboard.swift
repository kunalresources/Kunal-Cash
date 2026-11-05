import SwiftUI
import UIKit

extension View {
    
    func riverStoneKeyboardDone() -> some View {
        toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    RiverStoneKeyboardBridge.dismiss()
                }
            }
        }
    }
}

private enum RiverStoneKeyboardBridge {
    static func dismiss() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
