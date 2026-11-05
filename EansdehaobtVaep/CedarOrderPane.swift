import SwiftUI

private enum ReedPaneList {
    static let filterFromTop: CGFloat = 40
    static let filterToCardGap: CGFloat = 19
    static let cardVerticalStack: CGFloat = 10
    static let scrollBottom: CGFloat = 120
}

private enum ReedPaneCard {
    static let productRow = EdgeInsets(top: 8, leading: 14, bottom: 0, trailing: 14)
    static let afterProduct = 3.0
    static let afterAmount = 10.0
    static let afterStatus = 14.0
    static let dateHorizontal = 21.0
    static let dateSpacerMin: CGFloat = 8
    static let cardBottom = 22.0
    static let moneyHorizontal = EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14)
    static let statusHorizontal = EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14)
}

private struct ReedStoneBridge: Identifiable, Equatable {
    let id = UUID()
    let tideURL: URL
    let widely: Bool
    let shellFogSlice: FogReedShell?
}

struct CedarOrderPane: View {
    @EnvironmentObject private var tideAuth: TideAuthOak
    @Binding var driftStripHidden: Bool
    @State private var reedPick = 20
    @State private var reedRows: [TideFernOrderItem] = []
    @State private var reedBusy = false
    @State private var reedStoneBridge: ReedStoneBridge?
    @State private var reedOakConfigBusy = false

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

                VStack(spacing: 0) {
                    reedFilterBlock
                        .padding(.top, ReedPaneList.filterFromTop)
                        .frame(maxWidth: 350)
                        .frame(maxWidth: .infinity)

                    ScrollView(showsIndicators: false) {
                        if reedRows.isEmpty {
                            reedEmptyBlock
                                .padding(.top, 34)
                                .padding(.bottom, ReedPaneList.scrollBottom)
                        } else {
                            LazyVStack(spacing: ReedPaneList.cardVerticalStack) {
                                ForEach(reedRows.indices, id: \.self) { i in
                                    Button {
                                        reedTapStoneRow(reedRows[i])
                                    } label: {
                                        reedCard(row: reedRows[i])
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .frame(maxWidth: 350)
                            .frame(maxWidth: .infinity)
                            .padding(.top, ReedPaneList.filterToCardGap)
                            .padding(.bottom, ReedPaneList.scrollBottom)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(item: $reedStoneBridge, onDismiss: {
            ReedDriftStripGate.shared.mossPop(&driftStripHidden)
            reedFetchList()
        }) { p in
            PearlWedHazePane(tideURL: p.tideURL, shellKycId: "", shellProductId: nil, widely: p.widely, shellFogSlice: p.shellFogSlice)
        }
        .onAppear {
            reedTryOpenPendingDetailIfNeeded()
            reedApplyPendingOrderFilter()
        }
        .onChange(of: reedPick) { _ in
            reedFetchList()
        }
        .onReceive(NotificationCenter.default.publisher(for: .reedOakHistoryEnter)) { _ in
            reedTryOpenPendingDetailIfNeeded()
            reedFetchList()
        }
        .onReceive(NotificationCenter.default.publisher(for: .coralReefTabPick)) { note in
            guard let i = note.object as? Int, i == 2 else { return }
            reedTryOpenPendingDetailIfNeeded()
            reedApplyPendingOrderFilter()
        }
    }

    private var reedEmptyBlock: some View {
        VStack(spacing: 18) {
            Image("reedNoOrderGlyph")
                .resizable()
                .scaledToFit()
                .frame(width: 168, height: 168)
            Text("No Order")
                .font(SlateRiverFont.reed(15, .medium))
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 360, alignment: .top)
    }

    private var reedFilterBlock: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                reedFilterButton("Pending Repayment", value: 20)
                reedFilterButton("Processing", value: 30)
            }
            .padding(.top, 7)
            HStack(spacing: 16) {
                reedFilterButton("Submit Application", value: 10)
                reedFilterButton("Completed", value: 40)
            }
            .padding(.top, 4)
            .padding(.bottom, 7)
        }
        .padding(.horizontal, 9)
        .background(Color(red: 112 / 255, green: 51 / 255, blue: 158 / 255))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private func reedFilterButton(_ title: String, value: Int) -> some View {
        let on = value == reedPick
        return Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                reedPick = value
            }
        }) {
            Text(title)
                .font(SlateRiverFont.reed(on ? 16 : 14, on ? .medium : .regular))
                .foregroundStyle(on ? Color(red: 16 / 255, green: 16 / 255, blue: 16 / 255) : Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: 51)
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(on ? Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255) : Color.clear)
                )
        }
        .buttonStyle(.plain)
    }

    private func reedCard(row: TideFernOrderItem) -> some View {
        let dateLine = reedSingleDateLine(row)
        return VStack(alignment: .leading, spacing: 0) {
            HStack {
                Spacer(minLength: 0)
                Text(reedNameLine(row.mossName))
                    .font(SlateRiverFont.reed(14, .regular))
                    .foregroundStyle(Color(red: 187 / 255, green: 127 / 255, blue: 235 / 255))
                    .lineLimit(1)
            }
            .padding(ReedPaneCard.productRow)

            Text(reedMoneyLine(row.mossWave))
                .font(SlateRiverFont.reed(45, .bold))
                .foregroundStyle(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255))
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(ReedPaneCard.moneyHorizontal)
                .padding(.top, ReedPaneCard.afterProduct)

            Text(reedStatusLine(row.mossGate))
                .font(SlateRiverFont.reed(15, .medium))
                .foregroundStyle(.white)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(ReedPaneCard.statusHorizontal)
                .padding(.top, ReedPaneCard.afterAmount)

            HStack(spacing: 0) {
                Text(dateLine.0)
                    .font(SlateRiverFont.reed(14, .regular))
                    .foregroundStyle(Color(red: 187 / 255, green: 127 / 255, blue: 235 / 255))
                Spacer(minLength: ReedPaneCard.dateSpacerMin)
                Text(dateLine.1)
                    .font(SlateRiverFont.reed(14, .regular))
                    .foregroundStyle(.white)
                    .lineLimit(1)
            }
            .padding(.horizontal, ReedPaneCard.dateHorizontal)
            .padding(.top, ReedPaneCard.afterStatus)
            .padding(.bottom, ReedPaneCard.cardBottom)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(red: 147 / 255, green: 61 / 255, blue: 180 / 255))
        )
    }

    private func reedTapStoneRow(_ row: TideFernOrderItem) {
        
        if row.mossGate == 31 {
            JuniperFogHUD.oakWait("Loading...")
            MeadowRelay.shared.runPine(.quietLake(EmptyShell()), sandType: CoralAppConfigShell.self) { res in
                DispatchQueue.main.async {
                    JuniperFogHUD.oakDismiss()
                    switch res {
                    case .success(let data):
                        guard let leadis = data.tideData?.ivyDynamic?.rejectH5, !leadis.isEmpty, let url = URL(string: leadis) else {
                            reedOpenStoneDetail(row, baseHref: "https://page.kunalresources.com/dist/order/index.html")
                            return
                        }
                        ReedDriftStripGate.shared.mossPush(&driftStripHidden)
                        reedStoneBridge = ReedStoneBridge(tideURL: url, widely: true, shellFogSlice: nil)
                    case .failure(_):
                        break
                    }
                }
            }
        } else {
            reedOpenStoneDetail(row, baseHref: "https://page.kunalresources.com/dist/order/index.html")
        }
    }

    private func reedOpenStoneDetail(_ row: TideFernOrderItem, baseHref: String) {
        guard let fog = reedBuildFogShell(row) else {
            JuniperFogHUD.oakBad("The link is currently unavailable")
            return
        }
        ReedDriftStripGate.shared.mossPush(&driftStripHidden)
        reedStoneBridge = ReedStoneBridge(tideURL: URL(string: baseHref)!, widely: false, shellFogSlice: fog)
    }

    private func reedTryOpenPendingDetailIfNeeded() {
        
    }

    private func reedCoralBaseURL(_ baseHref: String) -> URL? {
        let t = baseHref.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !t.isEmpty, let u = URL(string: t), let s = u.scheme?.lowercased(), s == "http" || s == "https" else { return nil }
        return u
    }

    private func reedBuildFogShell(_ row: TideFernOrderItem) -> FogReedShell? {
        let fogA = row.mossLine?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let fogB = row.mossStone?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let driftC: String? = row.mossGate == 32 ? "1" : nil
        if !fogA.isEmpty {
            return FogReedShell(driftLineA: fogA, driftLineB: fogB.isEmpty ? nil : fogB, driftLineC: driftC)
        }
        if !fogB.isEmpty {
            return FogReedShell(driftLineA: "1", driftLineB: fogB, driftLineC: driftC)
        }
        return nil
    }

    private func reedFetchList() {
        guard !reedBusy else { return }
        reedBusy = true
        JuniperFogHUD.oakWait("Loading...")
        MeadowRelay.shared.runPine(.fernOrder(ReedFernOrderListBody(mossGate: reedPick)), sandType: TideFernOrderListShell.self) { result in
            DispatchQueue.main.async {
                JuniperFogHUD.oakDismiss()
                reedBusy = false
                switch result {
                case let .success(env):
                    reedRows = env.tideData?.mossRows ?? []
                case let .failure(err):
                    reedRows = []
                    JuniperFogHUD.oakBad(err.fogReedLine)
                }
            }
        }
    }

    private func reedConsumeStoneFilterIfNeeded() -> Int? {
        guard UserDefaults.standard.object(forKey: "reef.oakOrderFilter") != nil else { return nil }
        let raw = UserDefaults.standard.integer(forKey: "reef.oakOrderFilter")
        UserDefaults.standard.removeObject(forKey: "reef.oakOrderFilter")
        let allow = [10, 20, 30, 40]
        return allow.contains(raw) ? raw : nil
    }

    private func reedApplyPendingOrderFilter() {
        guard let from = reedConsumeStoneFilterIfNeeded() else { return }
        if reedPick != from {
            reedPick = from
        } else {
            reedFetchList()
        }
    }

    private func reedNameLine(_ line: String?) -> String {
        let t = line ?? ""
        return t.isEmpty ? "-" : t
    }

    private func reedMoneyLine(_ raw: String?) -> String {
        let s = raw ?? ""
        let d = s.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "₹", with: "")
        let n = d.unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) || $0 == "." }.map(String.init).joined()
        guard !n.isEmpty, let value = Decimal(string: n) else {
            return s.isEmpty ? "₹0" : s
        }
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.locale = Locale(identifier: "en_IN")
        f.maximumFractionDigits = 0
        f.minimumFractionDigits = 0
        guard let out = f.string(from: value as NSDecimalNumber) else {
            return "₹0"
        }
        return "₹\(out)"
    }

    private func reedStatusLine(_ code: Int?) -> String {
        switch code ?? -1 {
        case 10: return "Unfinished Application"
        case 30: return "Under review"
        case 31: return "Reject"
        case 32: return "To be withdrawn shortly"
        case 36: return "Modify bank account"
        case 50: return "Loan processing"
        case 60: return "Pending Repayment"
        case 61: return "Overdue"
        case 70: return "Pay off"
        case 99: return "Cancel"
        default: return "-"
        }
    }

    private func reedSingleDateLine(_ row: TideFernOrderItem) -> (String, String) {
        let code = row.mossGate ?? -1
        if code == 70 {
            return ("Repayment date", reedDateLine(row.mossRepay))
        }
        if [60, 61, 70].contains(code) {
            return ("Payment date", reedDateLine(row.mossLoan))
        }
        return ("Date of application", reedDateLine(row.mossStart))
    }

    private func reedDateLine(_ line: String?) -> String {
        let t = line?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return t.isEmpty ? "-" : t
    }
}
