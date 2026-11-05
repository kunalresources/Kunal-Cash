import Foundation

enum TidePhoneReed {
    static func birchValid(_ raw: String) -> Bool {
        raw.range(of: "^([6-9]\\d{9}|0[6-9]\\d{9})$", options: .regularExpression) != nil
    }

    static func digitsOnly(_ raw: String, maxLen: Int) -> String {
        let f = raw.filter { $0.isNumber }
        return String(f.prefix(maxLen))
    }
}
