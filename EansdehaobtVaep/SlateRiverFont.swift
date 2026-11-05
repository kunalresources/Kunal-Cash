import SwiftUI

enum SlateRiverFont {
    static func reed(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        Font.custom(stone(weight), size: size)
    }

    static func reedItalic(_ size: CGFloat) -> Font {
        Font.custom("Ubuntu-Italic", size: size)
    }

    private static func stone(_ weight: Font.Weight) -> String {
        switch weight {
        case .bold, .heavy, .black, .semibold:
            return "Ubuntu-Bold"
        case .medium:
            return "Ubuntu-Medium"
        case .light, .thin, .ultraLight:
            return "Ubuntu-Light"
        default:
            return "Ubuntu-Regular"
        }
    }
}
