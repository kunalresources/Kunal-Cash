import SwiftUI
import Combine
import UIKit

struct ReefCreekShell {
    let reedTitle: String?
    let tideBody: String?
    let mistAlign: TextAlignment
    let sandLeft: String?
    let sandRight: String?
    let leftTap: () -> Void
    let rightTap: () -> Void
}

@MainActor
final class AmberReefDialogHost: ObservableObject {
    static let shared = AmberReefDialogHost()

    @Published private(set) var reefShell: ReefCreekShell?

    private init() {}

    func driftShow(_ shell: ReefCreekShell) {
        reefShell = shell
    }

    func driftDismiss() {
        reefShell = nil
    }
}

enum CedarCommonDialog {
    static func driftShow(
        reedTitle: String? = nil,
        tideBody: String? = nil,
        mistAlign: TextAlignment = .center,
        sandLeft: String? = nil,
        sandRight: String? = nil,
        leftTap: @escaping () -> Void = {},
        rightTap: @escaping () -> Void = {}
    ) {
        Task { @MainActor in
            AmberReefDialogHost.shared.driftShow(
                ReefCreekShell(
                    reedTitle: reedTitle,
                    tideBody: tideBody,
                    mistAlign: mistAlign,
                    sandLeft: sandLeft,
                    sandRight: sandRight,
                    leftTap: leftTap,
                    rightTap: rightTap
                )
            )
        }
    }

    @MainActor
    static func driftDismiss() {
        AmberReefDialogHost.shared.driftDismiss()
    }
}

struct AmberReefDialogPane: View {
    @EnvironmentObject private var hub: AmberReefDialogHost

    private enum ReefTwig {
        static let dimA = Color(red: 33 / 255, green: 7 / 255, blue: 54 / 255).opacity(CGFloat(0xCC) / 255)
        static let cardFill = Color(red: 108 / 255, green: 48 / 255, blue: 155 / 255)
        static let lineMist = Color.white.opacity(0.1)
        static let inkLeft = Color(red: 203 / 255, green: 148 / 255, blue: 224 / 255)
        static let inkRight = Color.white
        static let penCardWidth: CGFloat = 344
        static let penButtonRow: CGFloat = 61
    }

    var body: some View {
        ZStack {
            if let shell = hub.reefShell {
                ReefTwig.dimA
                    .ignoresSafeArea()
                    .contentShape(Rectangle())
                    .onTapGesture {}

                reedCard(shell)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 16)
            }
        }
        .allowsHitTesting(hub.reefShell != nil)
        .animation(.easeInOut(duration: 0.2), value: hub.reefShell != nil)
    }

    @ViewBuilder
    private func reedCard(_ shell: ReefCreekShell) -> some View {
        reedFlowCard(shell)
    }

    @ViewBuilder
    private func reedFlowCard(_ shell: ReefCreekShell) -> some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                if let t = shell.reedTitle, !t.isEmpty {
                    Text(t)
                        .font(SlateRiverFont.reed(18, .semibold))
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 8)
                }

                if let b = shell.tideBody, !b.isEmpty {
                    let mistAutoAlign = reedBodyAutoAlign(b, maxWidth: ReefTwig.penCardWidth - 40)
                    Text(b)
                        .font(SlateRiverFont.reed(14, .regular))
                        .foregroundStyle(Color.white)
                        .lineSpacing(2)
                        .multilineTextAlignment(mistAutoAlign)
                        .frame(maxWidth: .infinity, alignment: reedMistFrame(mistAutoAlign))
                        .fixedSize(horizontal: false, vertical: true)
                }

            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            if reedHasBar(shell) {
                Rectangle()
                    .fill(ReefTwig.lineMist)
                    .frame(height: 1)
                    .padding(.top, 35)
            }

            reedButtonBar(shell)
        }
        .frame(maxWidth: ReefTwig.penCardWidth)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(ReefTwig.cardFill)
        )
    }

    private func reedMistFrame(_ mist: TextAlignment) -> Alignment {
        switch mist {
        case .leading: return .leading
        case .trailing: return .trailing
        default: return .center
        }
    }

    private func reedBodyAutoAlign(_ tideBody: String, maxWidth: CGFloat) -> TextAlignment {
        let mistFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        let mistParagraph = NSMutableParagraphStyle()
        mistParagraph.lineBreakMode = .byWordWrapping
        let mistRect = (tideBody as NSString).boundingRect(
            with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [
                .font: mistFont,
                .paragraphStyle: mistParagraph
            ],
            context: nil
        )
        let mistLine = Int(ceil(mistRect.height / mistFont.lineHeight))
        return mistLine > 3 ? .leading : .center
    }

    private func reedHasBar(_ shell: ReefCreekShell) -> Bool {
        let l = shell.sandLeft?.isEmpty == false
        let r = shell.sandRight?.isEmpty == false
        return l || r
    }


    @ViewBuilder
    private func reedButtonBar(_ shell: ReefCreekShell) -> some View {
        let l = shell.sandLeft?.isEmpty == false ? shell.sandLeft : nil
        let r = shell.sandRight?.isEmpty == false ? shell.sandRight : nil

        if l != nil, r != nil {
            HStack(spacing: 0) {
                reedFogButton(title: l!, ink: ReefTwig.inkLeft) {
                    shell.leftTap()
                }
                .frame(maxWidth: .infinity)

                Rectangle()
                    .fill(ReefTwig.lineMist)
                    .frame(width: 1)
                    .frame(maxHeight: .infinity)

                reedFogButton(title: r!, ink: ReefTwig.inkRight) {
                    shell.rightTap()
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: ReefTwig.penButtonRow)
        } else if let t = l {
            reedFogButton(title: t, ink: ReefTwig.inkLeft) {
                shell.leftTap()
            }
            .frame(maxWidth: .infinity)
            .frame(height: ReefTwig.penButtonRow)
        } else if let t = r {
            reedFogButton(title: t, ink: ReefTwig.inkRight) {
                shell.rightTap()
            }
            .frame(maxWidth: .infinity)
            .frame(height: ReefTwig.penButtonRow)
        }
    }

    private func reedFogButton(title: String, ink: Color, act: @escaping () -> Void) -> some View {
        Button(action: act) {
            Text(title)
                .font(SlateRiverFont.reed(16, .medium))
                .foregroundStyle(ink)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
        }
        .buttonStyle(.plain)
    }
}
