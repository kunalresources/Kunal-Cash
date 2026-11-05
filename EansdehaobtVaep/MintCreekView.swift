import Combine
import SwiftUI

private enum MintField: Hashable {
    case river
    case lake
}

private enum MintPineSlice {
    static let oakLogoSide: CGFloat = 215
}

private enum MintCreekPalette {
    static let grapeTop = Color(red: 87 / 255, green: 12 / 255, blue: 146 / 255)
    static let grapeBottom = Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)
    static let limeCard = Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255)
    static let mistLabel = Color(red: 187 / 255, green: 127 / 255, blue: 235 / 255)
    static let inkPrimary = Color(red: 16 / 255, green: 16 / 255, blue: 16 / 255)
    static let fieldFill = Color.white.opacity(38 / 255)
    static let otpInk = Color(red: 75 / 255, green: 9 / 255, blue: 126 / 255)
    static let plumStroke = Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255)
}

private struct ReefWebPick: Identifiable {
    let id = UUID()
    let url: URL
    let reedFogTitle: String
}

struct MintCreekView: View {
    @EnvironmentObject private var tideAuth: TideAuthOak
    private let mintWideCap: CGFloat = 560
    @State private var appleField = ""
    @State private var stoneField = ""
    @State private var redStone = true
    @FocusState private var mintFocus: MintField?
    @State private var reedOtpTicks = 0
    @State private var duneOtpSent = false
    @State private var reefWebPick: ReefWebPick?
    @State private var reedSendBusy = false
    @State private var reedSignBusy = false
    @State private var reedCoralBusy = false

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [MintCreekPalette.grapeTop, MintCreekPalette.grapeBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            Image("l2_bg")
                .resizable()
                .aspectRatio(375 / 341, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(edges: .top)
                .allowsHitTesting(false)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    headerMint
                        .padding(.top, 12)

                    VStack(alignment: .leading, spacing: 0) {
                        mobileCardMint
                            .padding(.top, 28)

                        otpCardMint
                            .padding(.top, 10)

                        agreementMint
                            .padding(.top, 36)
                    }
                    .padding(.horizontal, 22)

                    signInMint
                        .padding(.horizontal, 22)
                        .padding(.top, 24)
                        .padding(.bottom, 28)
                }
                .frame(maxWidth: mintWideCap)
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .onChange(of: appleField, perform: { newVal in
            let v = TidePhoneReed.digitsOnly(newVal, maxLen: 11)
            if v != newVal { appleField = v }
        })
        .onChange(of: stoneField, perform: { newVal in
            let v = TidePhoneReed.digitsOnly(newVal, maxLen: 6)
            if v != newVal { stoneField = v }
        })
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if reedOtpTicks > 0 {
                reedOtpTicks -= 1
            }
        }
        .fullScreenCover(item: $reefWebPick) { pick in
            FogWebBridgeView(tideURL: pick.url, reedFogTitle: pick.reedFogTitle)
        }
    }

    private var otpButtonTitle: String {
        if reedOtpTicks > 0 {
            return "\(reedOtpTicks)s"
        }
        return duneOtpSent ? "Reacquire" : "Get OTP"
    }

    private func oakBrowseLine(_ href: String, reedFogTitle: String) {
        let t = href.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !t.isEmpty, let u = URL(string: t), let s = u.scheme?.lowercased(), s == "http" || s == "https" else {
            JuniperFogHUD.oakBad("The link is currently unavailable")
            return
        }
        reefWebPick = ReefWebPick(url: u, reedFogTitle: reedFogTitle)
    }

    private func creekOpenLink(oakPolicy: Bool) {
        let raw = oakPolicy ? "https://www.kunalresources.com/PrivacyPolicy.html" : "https://www.kunalresources.com/ServiceAgreement.html"
        oakBrowseLine(raw, reedFogTitle: oakPolicy ? "Privacy Policy" : "Service Agreement")
    }

    private func mintSendOTP() {
        mintFocus = nil
        let m = appleField.trimmingCharacters(in: .whitespacesAndNewlines)
        if m.isEmpty {
            JuniperFogHUD.oakBad("Please enter mobile number")
            return
        }
        if !TidePhoneReed.birchValid(m) {
            JuniperFogHUD.oakBad("Please make sure to enter a valid phone number.")
            return
        }
        reedSendBusy = true
        JuniperFogHUD.oakWait("Sending...")
        let payload = ReedSmsPayload(duneMobile: m, oakVerify: 1)
        MeadowRelay.shared.runPine(.amberMud(payload), sandType: EmptyShell.self) { result in
            DispatchQueue.main.async {
                JuniperFogHUD.oakDismiss()
                reedSendBusy = false
                switch result {
                case .success:
                    JuniperFogHUD.oakGood("The OTP has been sent successfully.", lakeDelay: 1.2)
                    duneOtpSent = true
                    reedOtpTicks = 60
                case let .failure(err):
                    JuniperFogHUD.oakBad(err.fogReedLine)
                }
            }
        }
    }

    private func mintSignIn() {
        mintFocus = nil
        let m = appleField.trimmingCharacters(in: .whitespacesAndNewlines)
        if m.isEmpty {
            JuniperFogHUD.oakBad("Please enter mobile number")
            return
        }
        if !TidePhoneReed.birchValid(m) {
            JuniperFogHUD.oakBad("Please make sure to enter a valid phone number.")
            return
        }
        let code = stoneField.trimmingCharacters(in: .whitespacesAndNewlines)
        if code.isEmpty {
            JuniperFogHUD.oakBad("Enter OTP")
            return
        }
        if code.count != 6 {
            JuniperFogHUD.oakBad("Please make sure to enter the correct OTP.")
            return
        }
        if !redStone {
            JuniperFogHUD.oakBad("Please read and agree to the Privacy Policy and Service Agreement.")
            return
        }
        reedSignBusy = true
        JuniperFogHUD.oakWait("Loading...")
        let device = OliveDeviceTag.shared.reedPebbleLine
        let body = ReedWaveLogin(
            duneMobile: m,
            fogCode: code,
            cliffLo: "-360",
            cliffLa: "-360",
            mistImei: "",
            tideSerial: device
        )
        MeadowRelay.shared.runPine(.birchGate(body), sandType: MistLoginTide.self) { result in
            DispatchQueue.main.async {
                JuniperFogHUD.oakDismiss()
                reedSignBusy = false
                switch result {
                case let .success(env):
                    guard let d = env.tideData, let u = d.mistLeafId, let t = d.stoneLeafValue, !u.isEmpty, !t.isEmpty else {
                        JuniperFogHUD.oakBad("Invalid account response")
                        return
                    }
                    UserDefaults.standard.set(m, forKey: "reed.potential")
                    UserDefaults.standard.synchronize()
                    BridgeGateSession.shared.saveBreeze(mistLeaf: u, stoneLeaf: t, moonStamp: Date().timeIntervalSince1970)
                    tideAuth.refreshReedGate()
                case let .failure(err):
                    JuniperFogHUD.oakBad(err.fogReedLine)
                }
            }
        }
    }

    private var mintOakAppLine: String {
        let sea = (Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !sea.isEmpty { return sea }
        return (Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    private var headerMint: some View {
        VStack(spacing: 8) {
            Image("orangeRiver")
                .resizable()
                .scaledToFit()
                .frame(width: MintPineSlice.oakLogoSide, height: MintPineSlice.oakLogoSide)
                .frame(maxWidth: .infinity)

            Text(mintOakAppLine)
                .font(SlateRiverFont.reed(12, .heavy))
                .foregroundStyle(MintCreekPalette.limeCard)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(MintCreekPalette.plumStroke, lineWidth: 1)
                )
        }
    }

    private var mobileCardMint: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(MintCreekPalette.fieldFill)

            VStack(alignment: .leading, spacing: 1) {
                Text("Mobile Number")
                    .font(SlateRiverFont.reed(16))
                    .foregroundStyle(MintCreekPalette.mistLabel)
                    .frame(height: 24, alignment: .topLeading)
                    .lineLimit(1)

                HStack(alignment: .center, spacing: 12) {
                    Text("+91")
                        .font(SlateRiverFont.reed(14, .medium))
                        .foregroundStyle(MintCreekPalette.limeCard)
                        .multilineTextAlignment(.center)
                        .frame(width: 28, alignment: .center)

                    ZStack(alignment: .leading) {
                        if appleField.isEmpty {
                            Text("Please enter mobile number")
                                .font(SlateRiverFont.reed(14))
                                .foregroundStyle(Color.white)
                                .lineLimit(1)
                        }
                        TextField("", text: $appleField)
                            .font(SlateRiverFont.reed(14))
                            .foregroundStyle(Color.white)
                            .keyboardType(.numberPad)
                            .focused($mintFocus, equals: .river)
                    }
                    .frame(maxWidth: .infinity, minHeight: 22, alignment: .leading)
                }
                .padding(.top, 5)

                Spacer(minLength: 0)
            }
            .padding(.top, 13)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 10)
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
    }

    private var otpCardMint: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(MintCreekPalette.fieldFill)

            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("OTP")
                        .font(SlateRiverFont.reed(16))
                        .foregroundStyle(MintCreekPalette.mistLabel)

                    ZStack(alignment: .leading) {
                        if stoneField.isEmpty {
                            Text("Enter OTP")
                                .font(SlateRiverFont.reed(14))
                                .foregroundStyle(Color.white)
                        }
                        TextField("", text: $stoneField)
                            .font(SlateRiverFont.reed(14))
                            .foregroundStyle(Color.white)
                            .keyboardType(.numberPad)
                            .focused($mintFocus, equals: .lake)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Button(action: { mintSendOTP() }) {
                    Text(otpButtonTitle)
                        .font(SlateRiverFont.reed(13, .medium))
                        .foregroundStyle(MintCreekPalette.otpInk)
                        .frame(width: 76, height: 34)
                        .background(MintCreekPalette.limeCard.opacity((reedOtpTicks > 0 || reedSendBusy) ? 0.45 : 1))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .buttonStyle(.plain)
                .disabled(reedOtpTicks > 0 || reedSendBusy)
            }
            .padding(.leading, 15)
            .padding(.trailing, 14)
            .padding(.top, 15)
            .padding(.bottom, 12)
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
    }

    private var mintAgreementAttributed: AttributedString {
        let raw = "Please read and accept [Privacy Policy](x-policy://p) and [Service Agreement](x-agreement://a)."
        guard var a = try? AttributedString(markdown: raw) else {
            return AttributedString(raw)
        }
        let lime = MintCreekPalette.limeCard
        var linkRanges: [Range<AttributedString.Index>] = []
        for r in a.runs {
            if r.link != nil {
                linkRanges.append(r.range)
            }
        }
        for rg in linkRanges {
            a[rg].underlineStyle = Text.LineStyle(pattern: .solid, color: lime)
            a[rg].foregroundColor = lime
        }
        return a
    }

    private var agreementMint: some View {
        HStack(alignment: .top, spacing: 12) {
            Button(action: { redStone.toggle() }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(redStone ? MintCreekPalette.limeCard : MintCreekPalette.mistLabel)
                        .frame(width: 27, height: 27)
                    if redStone {
                        Image(systemName: "checkmark")
                            .font(SlateRiverFont.reed(12, .bold))
                            .foregroundStyle(MintCreekPalette.inkPrimary)
                    }
                }
            }
            .buttonStyle(.plain)
            .accessibilityLabel(redStone ? "Accepted" : "Not accepted")
            .accessibilityAddTraits(.isButton)

            Text(mintAgreementAttributed)
                .font(SlateRiverFont.reed(14, .medium))
                .foregroundStyle(MintCreekPalette.limeCard)
                .tint(MintCreekPalette.limeCard)
                .multilineTextAlignment(.leading)
                .environment(\.openURL, OpenURLAction { url in
                    switch url.scheme?.lowercased() {
                    case "x-policy":
                        creekOpenLink(oakPolicy: true)
                        return .handled
                    case "x-agreement":
                        creekOpenLink(oakPolicy: false)
                        return .handled
                    default:
                        return .systemAction
                    }
                })
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var signInMint: some View {
        Button(action: { mintSignIn() }) {
            ZStack {
                RoundedRectangle(cornerRadius: 35, style: .continuous)
                    .fill(MintCreekPalette.limeCard.opacity(reedSignBusy ? 0.55 : 1))
                    .frame(height: 70)

                Text("Sign in to start")
                    .font(SlateRiverFont.reed(16, .medium))
                    .foregroundStyle(MintCreekPalette.inkPrimary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .overlay(alignment: .trailing) {
                Image("riverChevron")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23, height: 24)
                    .padding(.trailing, 33)
            }
        }
        .buttonStyle(.plain)
        .disabled(reedSignBusy)
    }
}
