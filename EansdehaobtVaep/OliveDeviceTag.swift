import Foundation
import UIKit

final class OliveDeviceTag {
    static let shared = OliveDeviceTag()

    let reedPebbleLine: String

    private init() {
        let account = "dune.device"
        if let stored = CopperKeyVault.loadReed(account: account) {
            reedPebbleLine = stored
        } else if let idfv = UIDevice.current.identifierForVendor?.uuidString {
            CopperKeyVault.saveReed(idfv, account: account)
            reedPebbleLine = idfv
        } else {
            let fallback = UUID().uuidString
            CopperKeyVault.saveReed(fallback, account: account)
            reedPebbleLine = fallback
        }
    }

    func birchMachineLabel() -> String {
        var sysinfo = utsname()
        uname(&sysinfo)
        return withUnsafePointer(to: &sysinfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(validatingUTF8: $0) ?? "Unknown"
            }
        }
    }
}
