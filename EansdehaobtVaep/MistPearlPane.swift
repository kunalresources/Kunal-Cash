import SwiftUI
import UIKit

struct MistPearlPane: View {
    @Binding var driftStripHidden: Bool
    @EnvironmentObject private var tideAuth: TideAuthOak
    @State private var reedName = ""
    @State private var reedPhone = ""
    @State private var reedWebPick: MossWebPick?
    @State private var mossFogKycPick: MossFogKycPick?
    @State private var reedBankPush = false
    @State private var reedRepayPush = false
    @State private var reedEmiPush = false
    @State private var reedAboutPush = false
    @State private var reedHadSubNav = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                LinearGradient(
                    colors: [Color(red: 87 / 255, green: 12 / 255, blue: 146 / 255), Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)],
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

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        reedHeadPane
                            .padding(.top, 30)

                        reedMenuPane
                            .padding(.top, 10)
                            .padding(.horizontal, 11)
                    }
                    .padding(.bottom, 120)
                }

                NavigationLink(
                    destination: Group {
                        if let pick = reedWebPick {
                            FogWebBridgeView(tideURL: pick.reedURL, reedFogTitle: pick.reedTitle)
                        }
                    },
                    isActive: Binding(
                        get: { reedWebPick != nil },
                        set: { on in if !on { reedWebPick = nil } }
                    )
                ) { EmptyView() }
                .hidden()

                NavigationLink(destination: MossRepayNotePane(), isActive: $reedRepayPush) { EmptyView() }
                    .hidden()
                NavigationLink(destination: ReedAmberCardPane(), isActive: $reedBankPush) { EmptyView() }
                    .hidden()
                NavigationLink(destination: LimeEmiInputPane(), isActive: $reedEmiPush) { EmptyView() }
                    .hidden()
                NavigationLink(destination: ReedStonePane(), isActive: $reedAboutPush) { EmptyView() }
                    .hidden()

            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(NotificationCenter.default.publisher(for: .reedEmiExitToHome)) { _ in
            reedEmiPush = false
        }
        .onAppear {
            reedRefreshPearl()
            ReedDriftStripGate.shared.mossApplyProfileNav(
                &driftStripHidden,
                subNavShown: reedPearlSubNavShown,
                hadSubNav: reedHadSubNav
            )
            reedHadSubNav = reedPearlSubNavShown
        }
        .fullScreenCover(item: $mossFogKycPick, onDismiss: {
            ReedDriftStripGate.shared.mossPop(&driftStripHidden)
        }) { pick in
            PearlWedHazePane(tideURL: pick.url, shellKycId: "")
        }
        .onChange(of: reedRepayPush) { _ in reedPearlAfterNavFlag() }
        .onChange(of: reedWebPick) { _ in reedPearlAfterNavFlag() }
        .onChange(of: mossFogKycPick) { _ in reedPearlAfterNavFlag() }
        .onChange(of: reedBankPush) { _ in reedPearlAfterNavFlag() }
        .onChange(of: reedEmiPush) { _ in reedPearlAfterNavFlag() }
        .onChange(of: reedAboutPush) { _ in reedPearlAfterNavFlag() }
    }

    private var reedPearlSubNavShown: Bool {
        reedWebPick != nil || mossFogKycPick != nil || reedRepayPush || reedBankPush || reedEmiPush || reedAboutPush
    }

    private func reedRefreshPearl() {
        JuniperFogHUD.oakWait("Loading...")
        reedFetchUser {
            JuniperFogHUD.oakDismiss()
        }
    }

    private func reedPearlAfterNavFlag() {
        let now = reedPearlSubNavShown
        ReedDriftStripGate.shared.mossApplyProfileNav(&driftStripHidden, subNavShown: now, hadSubNav: reedHadSubNav)
        if reedHadSubNav && !now {
            reedRefreshPearl()
        }
        reedHadSubNav = now
    }

    private var reedHeadPane: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(reedName)
                    .font(SlateRiverFont.reed(20, .bold))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(reedPhone)
                    .font(SlateRiverFont.reed(16, .regular))
                    .foregroundStyle(Color(red: 244 / 255, green: 247 / 255, blue: 246 / 255))
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 13)
            .padding(.trailing, 13)

            HStack(spacing: 10) {
                Button(action: { reedEmiPush = true }) {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.white.opacity(0.15))
                        .frame(height: 85)
                        .overlay(alignment: .leading) {
                            HStack(spacing: 8) {
                                Image("meCardLeft")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 23)
                                Text("EMI")
                                    .font(SlateRiverFont.reed(16, .medium))
                                    .foregroundStyle(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255))
                            }
                            .padding(.horizontal, 20)
                        }
                }
                .buttonStyle(.plain)

                Button(action: reedTapContactUs) {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.white.opacity(0.15))
                        .frame(height: 85)
                        .overlay(alignment: .leading) {
                            HStack(spacing: 8) {
                                Image("meCardRight")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                Text("Contact us")
                                    .font(SlateRiverFont.reed(16, .medium))
                                    .foregroundStyle(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255))
                            }
                            .padding(.horizontal, 20)
                        }
                }
                .buttonStyle(.plain)
            }
            .frame(height: 85)
            .padding(.top, 24)

            Button(action: { reedBankPush = true }) {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.white.opacity(0.15))
                    .frame(height: 70)
                    .overlay(alignment: .leading) {
                        HStack(spacing: 22) {
                            Image("accountBank")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 22)
                            Text("Bank Account")
                                .font(SlateRiverFont.reed(16, .bold))
                                .foregroundStyle(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255))
                        }
                        .padding(.leading, 25)
                    }
            }
            .buttonStyle(.plain)
            .padding(.top, 10)
        }
        .padding(.horizontal, 11)
    }

    private var reedMenuPane: some View {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
            .fill(Color.white.opacity(0.15))
            .frame(minHeight: 349)
            .overlay {
                VStack(spacing: 0) {
                    reedMenuRow("Repayment Instructions", tap: { reedRepayPush = true })
                    reedLine
                    reedMenuRow("Feedback", tap: reedTapFeedback)
                    reedLine
                    reedMenuRow("About", tap: { reedAboutPush = true })
                    reedLine
                    reedMenuRow("Terms and conditions for loans", tap: reedTapTerms)
                    reedLine
                    reedMenuRow("Privacy policy", tap: reedTapPolicy)
                    reedLine
                    reedMenuRow("Official Website", tap: reedTapOfficialPopup)
                    Spacer(minLength: 0)
                    Button(action: reedTapSignOut) {
                        Text("Sign out")
                            .font(SlateRiverFont.reed(14, .regular))
                            .foregroundStyle(Color(red: 187 / 255, green: 127 / 255, blue: 235 / 255))
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 6)
                }
                .padding(.top, 2)
            }
    }

    private var reedLine: some View {
        Rectangle()
            .fill(Color.white.opacity(0.2))
            .frame(height: 1)
            .padding(.horizontal, 15)
    }

    private func reedMenuRow(_ title: String, tap: @escaping () -> Void) -> some View {
        Button(action: tap) {
            HStack {
                Text(title)
                    .font(SlateRiverFont.reed(15, .medium))
                    .foregroundStyle(Color.white)
                Spacer()
                Image("limeFernGlyph")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 24)
            }
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity)
            .frame(minHeight: 49)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
    }

    private func reedFetchUser(completion: @escaping () -> Void = {}) {
        MeadowRelay.shared.runPine(.stoneUser(ReedStoneUserBody(duneAdid: nil)), sandType: TideUserInfoShell.self) { result in
            DispatchQueue.main.async {
                defer { completion() }
                switch result {
                case let .success(env):
                    let shell = env.tideData
                    let nameRaw = shell?.reedName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                    if nameRaw.isEmpty {
                        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
                            ?? Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
                            ?? "App"
                        reedName = appName
                    } else {
                        reedName = nameRaw
                    }
                    let rawPhone = shell?.reedPhone?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                    let digits = rawPhone.unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }.map(String.init).joined()
                    reedPhone = digits.isEmpty ? "+91 " : "+91 \(digits)"
                case let .failure(err):
                    JuniperFogHUD.oakBad(err.fogReedLine)
                }
            }
        }
    }

    private func reedTapPolicy() {
        if let url = URL(string: "https://www.kunalresources.com/PrivacyPolicy.html") {
            reedWebPick = MossWebPick(reedTitle: "Privacy policy", reedURL: url)
        }
    }

    private func reedTapTerms() {
        if let url = URL(string: "https://www.kunalresources.com/loanContract.html") {
            reedWebPick = MossWebPick(reedTitle: "Terms and conditions for loans", reedURL: url)
        }
    }

    private func reedTapContactUs() {
        if let url = URL(string: "https://www.kunalresources.com/contactUs.html") {
            reedWebPick = MossWebPick(reedTitle: "Contact us", reedURL: url)
        }
    }

    private func reedTapFeedback() {
        if let url = URL(string: "https://page.kunalresources.com/dist/feedBack/index.html") {
            mossFogKycPick = MossFogKycPick(url: url)
        }
    }

    private func reedTapOfficialPopup() {
        let link = "https://www.kunalresources.com"
        NotificationCenter.default.post(name: .reedOfficialPopupShow, object: link)
    }

    private func reedTapSignOut() {
        CedarCommonDialog.driftShow(
            reedTitle: "Sign Out",
            tideBody: "Are you sure you want to log out of your account?",
            mistAlign: .center,
            sandLeft: "Cancel",
            sandRight: "Confirm",
            leftTap: {
                CedarCommonDialog.driftDismiss()
            },
            rightTap: {
                CedarCommonDialog.driftDismiss()
                JuniperFogHUD.oakWait("Loading...")
                MeadowRelay.shared.runPine(.stoneLogout(EmptyShell()), sandType: EmptyShell.self) { result in
                    DispatchQueue.main.async {
                        JuniperFogHUD.oakDismiss()
                        switch result {
                        case .success:
                            BridgeGateSession.shared.clearBreeze()
                            tideAuth.refreshReedGate()
                        case let .failure(err):
                            JuniperFogHUD.oakBad(err.fogReedLine)
                        }
                    }
                }
            }
        )
    }
}

private struct MossWebPick: Equatable {
    let reedTitle: String
    let reedURL: URL
}

private struct MossFogKycPick: Identifiable, Equatable {
    let id = UUID()
    let url: URL
}

private struct ReedOakH5Pick: Identifiable {
    let id = UUID()
    let tideURL: URL
}

private struct ReedAmberCardPane: View {
    @State private var reedCards: [ReedAmberCardItem] = []
    @State private var reedCanEdit = false
    @State private var reedOakH5Pick: ReedOakH5Pick?

    private var mistPearlLineName: String {
        let sea = reedPearlFirst?.reedName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return sea.isEmpty ? "-" : sea
    }

    private var mistPearlLineBank: String {
        let code = reedPearlFirst?.reedCode?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return code.isEmpty ? "-" : code
    }

    private var mistPearlLinePan: String {
        reedMaskNo(reedPearlFirst?.reedNo)
    }

    private var reedPearlFirst: ReedAmberCardItem? {
        reedCards.first
    }

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [Color(red: 87 / 255, green: 12 / 255, blue: 146 / 255), Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)],
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

            VStack(spacing: 0) {
                FogPearlStrip(cliffTitle: "Bank Account")

                VStack(spacing: 0) {
                    Button(action: {
                        if reedCanEdit {
                            reedOpenOakH5()
                        }
                    }) {
                        reedPearlLayerFace(
                            mistName: mistPearlLineName,
                            mistBank: mistPearlLineBank,
                            mistMasked: mistPearlLinePan
                        )
                    }
                    .buttonStyle(.plain)

                    Text("You can click the bank card logo to update your information. However, once your loan order is under review, bank account information cannot be changed.")
                        .font(SlateRiverFont.reed(14, .regular))
                        .foregroundStyle(Color.white)
                        .lineSpacing(5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 26)
                }
                .padding(.horizontal, 23)
                .padding(.top, 24)

                Spacer(minLength: 0)
            }

        }
        .navigationBarHidden(true)
        .fullScreenCover(item: $reedOakH5Pick, onDismiss: {
            ReedDriftStripGate.shared.mossPop()
            reedLoad()
        }) { p in
            PearlWedHazePane(tideURL: p.tideURL, shellKycId: "")
        }
        .onAppear(perform: reedLoad)
    }

    private func reedOpenOakH5() {
        if let url = URL(string: "https://page.kunalresources.com/dist/changeCard/index.html") {
            ReedDriftStripGate.shared.mossPush()
            reedOakH5Pick = ReedOakH5Pick(tideURL: url)
        }
    }

    @ViewBuilder
    private func reedPearlLayerFace(mistName: String, mistBank: String, mistMasked: String) -> some View {
        let mistInk = Color(red: 85 / 255, green: 12 / 255, blue: 142 / 255)

        ZStack(alignment: .topLeading) {
            Image("mossReedVeil")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .allowsHitTesting(false)

            if reedCanEdit {
                VStack {
                    HStack {
                        Spacer(minLength: 0)
                        Image("reedPineGlyph")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                    .padding(.top, 40)
                    .padding(.trailing, 50)
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .allowsHitTesting(false)
            }

            VStack(alignment: .leading, spacing: 0) {
                Text(mistName)
                    .font(SlateRiverFont.reed(14, .medium))
                    .foregroundStyle(mistInk)
                    .padding(.top, 96)

                Text(mistBank)
                    .font(SlateRiverFont.reed(10, .medium))
                    .foregroundStyle(mistInk)
                    .padding(.top, 6)

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 88)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .allowsHitTesting(false)

            VStack {
                Spacer(minLength: 0)
                HStack {
                    Spacer(minLength: 0)
                    Text(mistMasked)
                        .font(SlateRiverFont.reed(20, .bold))
                        .foregroundStyle(mistInk)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 105)
            }
            .allowsHitTesting(false)
        }
        .aspectRatio(359 / 448, contentMode: .fit)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }

    private func reedLoad() {
        JuniperFogHUD.oakWait("Loading...")
        let reefGroup = DispatchGroup()

        reefGroup.enter()
        MeadowRelay.shared.runPine(.amberCard(EmptyShell()), sandType: ReedAmberCardShell.self) { result in
            DispatchQueue.main.async {
                defer { reefGroup.leave() }
                if case let .success(env) = result {
                    reedCards = env.tideData?.reedCardList ?? []
                }
            }
        }

        reefGroup.enter()
        MeadowRelay.shared.runPine(.stoneUser(ReedStoneUserBody(duneAdid: nil)), sandType: TideUserInfoShell.self) { result in
            DispatchQueue.main.async {
                defer { reefGroup.leave() }
                switch result {
                case let .success(env):
                    let raw = env.tideData?.reedBankSwitch?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
                    reedCanEdit = raw == "on"
                case let .failure(err):
                    JuniperFogHUD.oakBad(err.fogReedLine)
                }
            }
        }

        reefGroup.notify(queue: .main) {
            JuniperFogHUD.oakDismiss()
        }
    }

    private func reedMaskNo(_ raw: String?) -> String {
        let sea = raw?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if sea.isEmpty { return "-" }
        let digits = sea.unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }.map(String.init).joined()
        if digits.isEmpty { return sea }
        return digits
    }
}

private struct ReedStonePane: View {
    @EnvironmentObject private var tideAuth: TideAuthOak
    @Environment(\.dismiss) private var driftPop

    private let reedBody = "Kunal Cash helps you handle everyday expenses with fast approvals, flexible loan options, and simple repayment plans. From household bills to unexpected costs, support is always within reach."
    private let reedDeleteBody = "You cannot cancel your account while a loan order is under review or being processed, or while a loan order remains unsettled. Once confirmed, the cancellation is irreversible and your account cannot be restored. Please proceed with caution."

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [Color(red: 87 / 255, green: 12 / 255, blue: 146 / 255), Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)],
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

            VStack(spacing: 0) {
                FogPearlStrip(cliffTitle: "About")
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            Button(action: reedTapDelete) {
                                Text("Delete Account")
                                    .font(SlateRiverFont.reed(14, .regular))
                                    .foregroundStyle(Color(red: 238 / 255, green: 139 / 255, blue: 235 / 255))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .stroke(Color(red: 238 / 255, green: 139 / 255, blue: 235 / 255), lineWidth: 1)
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)

                        Image("orangeRiver")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 228, height: 228)
                            .padding(.top, 18)

                        Text(reedAppDisplayName)
                            .font(SlateRiverFont.reed(18, .bold))
                            .kerning(-0.54)
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 18)

                        Text(reedAppVersionLine)
                            .font(SlateRiverFont.reed(12, .heavy))
                            .foregroundStyle(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255), lineWidth: 1)
                            )
                            .padding(.top, 10)

                        Text(reedBody)
                            .font(SlateRiverFont.reed(16, .regular))
                            .foregroundStyle(Color.white)
                            .lineSpacing(9)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding(.horizontal, 20)
                            .padding(.top, 34)
                            .padding(.bottom, 40)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarHidden(true)
    }

    private var reedAppVersionLine: String {
        let raw = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let t = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        if t.isEmpty { return "v-" }
        return "v\(t)"
    }

    private var reedAppDisplayName: String {
        let info = Bundle.main.infoDictionary
        let display = (info?["CFBundleDisplayName"] as? String ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if !display.isEmpty { return display }
        let name = (info?["CFBundleName"] as? String ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if !name.isEmpty { return name }
        return "-"
    }

    private func reedTapDelete() {
        CedarCommonDialog.driftShow(
            reedTitle: "Delete Account",
            tideBody: reedDeleteBody,
            mistAlign: .leading,
            sandLeft: "Cancel",
            sandRight: "Confirm",
            leftTap: {
                CedarCommonDialog.driftDismiss()
            },
            rightTap: {
                CedarCommonDialog.driftDismiss()
                reedRunDelete()
            }
        )
    }

    private func reedRunDelete() {
        JuniperFogHUD.oakWait("Loading...")
        MeadowRelay.shared.runPine(.stoneClose(EmptyShell()), sandType: EmptyShell.self) { result in
            DispatchQueue.main.async {
                JuniperFogHUD.oakDismiss()
                switch result {
                case .success:
                    BridgeGateSession.shared.clearBreeze()
                    CedarCommonDialog.driftShow(
                        reedTitle: "Success!",
                        tideBody: "Your account has been successfully cancelled.",
                        mistAlign: .center,
                        sandRight: "Confirm",
                        rightTap: {
                            CedarCommonDialog.driftDismiss()
                            tideAuth.refreshReedGate()
                            driftPop()
                        }
                    )
                case .failure:
                    CedarCommonDialog.driftShow(
                        reedTitle: "Failed!",
                        tideBody: "Account cancellation failed — please review your order.",
                        mistAlign: .center,
                        sandRight: "Confirm",
                        rightTap: {
                            CedarCommonDialog.driftDismiss()
                        }
                    )
                }
            }
        }
    }
}

private struct FogPearlStrip: View {
    let cliffTitle: String
    @Environment(\.dismiss) private var driftPop

    var body: some View {
        ZStack(alignment: .center) {
            HStack {
                Button(action: { driftPop() }) {
                    Image("amberQuartz")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Back")
                Spacer()
            }
            Text(cliffTitle)
                .font(SlateRiverFont.reed(18, .medium))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 52)
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 6)
    }
}

private struct MossOfficialPane: View {
    @State private var reedLink = ""

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [Color(red: 87 / 255, green: 12 / 255, blue: 146 / 255), Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)],
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

            VStack(spacing: 0) {
                FogPearlStrip(cliffTitle: "Official Website")
                VStack(alignment: .leading, spacing: 14) {
                    Text("Should you run into any issues with the app, you can also submit applications and make repayments via the official website. We recommend saving the official website address; click to copy.")
                        .font(SlateRiverFont.reed(14, .regular))
                        .foregroundStyle(Color.white.opacity(0.9))
                        .fixedSize(horizontal: false, vertical: true)
                    Button(action: {
                        guard !reedLink.isEmpty else { return }
                        UIPasteboard.general.string = reedLink
                        JuniperFogHUD.oakGood("The link has been copied to the clipboard successfully.")
                    }) {
                        Text(reedLink.isEmpty ? "-" : reedLink)
                            .font(SlateRiverFont.reed(14, .medium))
                            .foregroundStyle(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                            .background(Color.white.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    Spacer(minLength: 0)
                }
                .padding(20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarHidden(true)
        .onAppear(perform: reedLoad)
    }

    private func reedLoad() {
        reedLink = "https://www.kunalresources.com"
    }
}

private struct MossRepayNotePane: View {
    @State private var reedEmail = ""
    @State private var reedLink = ""

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [Color(red: 87 / 255, green: 12 / 255, blue: 146 / 255), Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)],
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

            VStack(spacing: 0) {
                FogPearlStrip(cliffTitle: "Repayment Instructions")
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        Text("For your financial security, please read the repayment instructions carefully before you proceed with repayment.")
                            .font(SlateRiverFont.reed(32, .regular))
                            .tracking(-0.96)
                            .foregroundStyle(.white)
                            .lineSpacing(2)

                        reedCopyCard(
                            value: reedLink,
                            fill: Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255),
                            ok: "The link has been copied to the clipboard successfully.",
                            reefIcon: .globe,
                            reefIconTop: 18
                        )
                        reedCopyCard(
                            value: reedEmail,
                            fill: Color(red: 106 / 255, green: 184 / 255, blue: 255 / 255),
                            ok: "The email address has been copied to your clipboard.",
                            reefIcon: .mail,
                            reefIconTop: 21
                        )

                        Text(reedBody)
                            .font(SlateRiverFont.reed(14, .regular))
                            .foregroundStyle(.white)
                            .lineSpacing(6)
                    }
                    .padding(.horizontal, 11)
                    .padding(.top, 18)
                    .padding(.bottom, 40)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarHidden(true)
        .onAppear(perform: reedLoad)
    }

    private var reedBody: String {
        let site = reedLink.isEmpty ? "-" : reedLink
        return "To make a repayment, we kindly ask you to first use the app to get the repayment link. If you cannot access the app, you may also log in to our official website to repay: \(site). Please note that if the repayment link used differs from the one shown on the app or official website, the repayment will be considered unsuccessful.\nIf someone asks you to split the total repayment amount into multiple payments or sends you a repayment link that does not match the one displayed on the app or official website, please contact customer service for help. Once we have verified the situation, we will waive the service fee for you.\nIf you encounter any suspicious situations during repayment, please contact customer service by email first. We will assist you promptly to resolve any issues."
    }

    private enum ReedCopyIcon {
        case globe
        case mail
    }

    private func reedCopyCard(value: String, fill: Color, ok: String, reefIcon: ReedCopyIcon, reefIconTop: CGFloat) -> some View {
        Button(action: {
            guard !value.isEmpty else { return }
            UIPasteboard.general.string = value
            JuniperFogHUD.oakGood(ok)
        }) {
            VStack(alignment: .leading, spacing: 0) {
                (reefIcon == .mail ? AnyView(reedMailGlyph) : AnyView(reedGlobeGlyph))
                    .frame(width: 24, height: 24, alignment: .leading)
                    .padding(.top, reefIconTop)
                    .padding(.leading, 19)

                HStack(spacing: 10) {
                    Text(value.isEmpty ? "-" : value)
                        .font(SlateRiverFont.reed(15, .bold))
                        .tracking(-0.45)
                        .foregroundStyle(Color(red: 16 / 255, green: 16 / 255, blue: 16 / 255))
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("copy")
                        .font(SlateRiverFont.reed(12, .bold))
                        .foregroundStyle(Color(red: 16 / 255, green: 16 / 255, blue: 16 / 255))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(Color(red: 16 / 255, green: 16 / 255, blue: 16 / 255), lineWidth: 1.5)
                        )
                }
                .padding(.top, 9)
                .padding(.horizontal, 21)
            }
            .frame(minHeight: 90, alignment: .top)
            .frame(maxWidth: .infinity)
            .background(fill)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private var reedGlobeGlyph: some View {
        Image("sw2")
            .resizable()
            .renderingMode(.original)
            .scaledToFit()
            .frame(width: 24, height: 24)
    }

    private var reedMailGlyph: some View {
        Image("nj2")
            .resizable()
            .renderingMode(.original)
            .scaledToFit()
            .frame(width: 24, height: 24)
    }

    private func reedLoad() {
        reedEmail = "customercare@kunalresources.com"
        reedLink = "https://www.kunalresources.com"
    }
}
