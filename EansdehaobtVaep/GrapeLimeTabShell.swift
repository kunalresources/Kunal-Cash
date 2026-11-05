import Combine
import SwiftUI
import UIKit

struct GrapeLimeTabShell: View {
    @State private var reefSlot = 0
    
    @State private var pearlFace = UUID()
    
    @State private var driftStripHidden = false
    @ObservedObject private var stripGate = ReedDriftStripGate.shared
    @State private var reedOfficialPopup = false
    @State private var reedOfficialLink = ""
    @State private var reedStoneTipBusy = false

    private let reedBarH: CGFloat = 70
    private let reedPadFromBottom: CGFloat = 28

    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [MossPineTwig.grapeA, MossPineTwig.grapeB],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            ZStack {
                DuneHomePlaceView(
                    driftStripHidden: $driftStripHidden,
                    reedStoneTipBusy: $reedStoneTipBusy
                )
                .reedTabHold(reefSlot == 0)
                MistPearlPane(driftStripHidden: $driftStripHidden)
                    .id(pearlFace)
                    .reedTabHold(reefSlot == 1)
                CedarOrderPane(driftStripHidden: $driftStripHidden)
                    .reedTabHold(reefSlot == 2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if !stripGate.mossHideTab {
                VStack(spacing: 0) {
                    MossPineStrip(reefSlot: $reefSlot)
                    Color.clear
                        .frame(height: reedPadFromBottom)
                        .allowsHitTesting(false)
                }
                .frame(maxWidth: .infinity)
                .background(MossPineTwig.brickMoss)
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            ReedWaveMistLift.mossKickOnceIfNeeded()
            driftStripHidden = stripGate.mossHideTab
        }
        .onChange(of: stripGate.mossHideTab) { hide in
            driftStripHidden = hide
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            reedRestoreDriftStripIfPinned()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            reedRestoreDriftStripIfPinned()
        }
        .onChange(of: reefSlot) { v in
            if v == 1 {
                pearlFace = UUID()
            }
            if v == 0 {
                NotificationCenter.default.post(name: .duneReefRefresh, object: nil)
            }
            if v == 2 {
                NotificationCenter.default.post(name: .reedOakHistoryEnter, object: nil)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .coralReefTabPick)) { note in
            if let i = note.object as? Int, (0 ..< 3).contains(i) {
                reefSlot = i
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .reedOfficialPopupShow)) { note in
            reedOfficialLink = (note.object as? String) ?? ""
            reedOfficialPopup = true
        }
        .overlay {
            ZStack {
                if reedOfficialPopup {
                    ReedOfficialPopup(
                        reedLink: reedOfficialLink,
                        closeTap: { reedOfficialPopup = false }
                    )
                    .transition(.opacity)
                    .zIndex(999)
                }
            }
        }
    }

    private func reedRestoreDriftStripIfPinned() {
        guard stripGate.mossHideTab else { return }
        driftStripHidden = true
    }

}

private extension View {
    
    @ViewBuilder
    func reedTabHold(_ active: Bool) -> some View {
        opacity(active ? 1 : 0)
            .allowsHitTesting(active)
            .accessibilityHidden(!active)
    }
}

private enum MossPineTwig {
    static let grapeA = Color(red: 87 / 255, green: 12 / 255, blue: 146 / 255)
    static let grapeB = Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)
    static let limeBar = Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255)
    
    static let brickMoss = Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)
}

private struct MossPineStrip: View {
    @Binding var reefSlot: Int
    private let reedBarH: CGFloat = 70

    var body: some View {
        HStack {
            Spacer(minLength: 0)
            ZStack {
                RoundedRectangle(cornerRadius: 35, style: .continuous)
                    .fill(MossPineTwig.limeBar)
                    .allowsHitTesting(false)

                HStack(spacing: 0) {
                    ForEach(0..<3, id: \.self) { i in
                        Group {
                            if reefSlot == i {
                                RoundedRectangle(cornerRadius: 31, style: .continuous)
                                    .fill(MossPineTwig.grapeA)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 4)
                            } else {
                                Color.clear
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .animation(.spring(response: 0.38, dampingFraction: 0.78), value: reefSlot)
                .allowsHitTesting(false)

                HStack(spacing: 0) {
                    ForEach(0..<3, id: \.self) { i in
                        reedTabCell(i: i)
                    }
                }
            }
            .frame(maxWidth: 320)
            .frame(height: reedBarH)
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .frame(height: reedBarH)
   
    }

    @ViewBuilder
    private func reedTabCell(i: Int) -> some View {
        let on = reefSlot == i
        Button(action: {
            let stayOnTab = (reefSlot == i)
            withAnimation(.spring(response: 0.38, dampingFraction: 0.78)) {
                reefSlot = i
            }
            
            if i == 2, stayOnTab {
                NotificationCenter.default.post(name: .reedOakHistoryEnter, object: nil)
            }
        }) {
            Group {
                if on {
                    HStack(spacing: 6) {
                        Image(reedIconName(i: i, bright: true))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text(reedTabTitle(i))
                            .font(SlateRiverFont.reed(15, .medium))
                            .foregroundStyle(MossPineTwig.limeBar)
                    }
                } else {
                    Image(reedIconName(i: i, bright: false))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityLabel(Text(reedTabTitle(i)))
    }

    private func reedTabTitle(_ i: Int) -> String {
        switch i {
        case 0: return "loan"
        case 1: return "me"
        case 2: return "order"
        default: return ""
        }
    }

    private func reedIconName(i: Int, bright: Bool) -> String {
        switch i {
        case 0: return bright ? "sandPineGlow" : "sandPineReef"
        case 1: return bright ? "sandPearlGlow" : "sandPearlReef"
        case 2: return bright ? "sandCedarGlow" : "sandCedarReef"
        default: return "sandPineReef"
        }
    }
}

private struct MistCedarPane: View {
    var body: some View {
        ScrollView {
            Text("order")
                .font(SlateRiverFont.reed(22, .semibold))
                .foregroundStyle(.white.opacity(0.9))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
                .padding(.bottom, 120)
        }
    }
}

private struct ReedOfficialPopup: View {
    let reedLink: String
    let closeTap: () -> Void

    var body: some View {
        ZStack {
            Color(red: 33 / 255, green: 7 / 255, blue: 54 / 255)
                .opacity(CGFloat(0xCC) / 255)
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture(perform: closeTap)

            VStack(spacing: 0) {
                Text("Should you encounter any issues with the app, you can also submit applications and make repayments via the official website. We suggest saving the official website address — click to copy.")
                    .font(SlateRiverFont.reed(14, .regular))
                    .foregroundStyle(Color.white)
                    .lineSpacing(6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 31)
                    .padding(.top, 22)

                HStack(spacing: 10) {
                    Image("yoo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(.top, 2)
                    Text(reedLink.isEmpty ? "-" : reedLink)
                        .font(SlateRiverFont.reed(15, .medium))
                        .foregroundStyle(Color.white)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.horizontal, 18)
                .padding(.vertical, 14)
                .frame(minHeight: 57)
                .background(Color(red: 71 / 255, green: 9 / 255, blue: 120 / 255))
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .padding(.horizontal, 31)
                .padding(.top, 20)

                Rectangle()
                    .fill(Color.white.opacity(0.1))
                    .frame(height: 1)
                    .padding(.top, 24)

                Button(action: {
                    guard !reedLink.isEmpty else { return }
                    UIPasteboard.general.string = reedLink
                    JuniperFogHUD.oakGood("The link has been copied to the clipboard successfully.")
                    closeTap()
                }) {
                    Text("copy")
                        .font(SlateRiverFont.reed(16, .medium))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .buttonStyle(.plain)
                .frame(height: 61)
            }
            .frame(width: 344, height: 261)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color(red: 108 / 255, green: 48 / 255, blue: 155 / 255))
            )
        }
        .allowsHitTesting(true)
    }
}

