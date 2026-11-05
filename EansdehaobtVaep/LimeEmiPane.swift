import SwiftUI

struct CoralEmiCargo: Hashable {
    var mossWave: Double
    var mossYear: Int
    var mossRate: Double
}

private struct CoralFogKycPick: Identifiable {
    let id = UUID()
    let url: URL
    let shellKycId: String
}

private enum LimeEmiFogMath {
    static func calculateEMI(mossWave: Double, mossRate: Double, mossYear: Int) -> (monthlyPayment: Double, totalRepayment: Double, totalInterest: Double) {
        let monthlyInterestRate = mossRate / 12 / 100
        let numberOfPayments = mossYear * 12
        guard numberOfPayments > 0, mossWave > 0, monthlyInterestRate > 0 else {
            return (0, 0, 0)
        }
        let numerator = mossWave * monthlyInterestRate * pow(1 + monthlyInterestRate, Double(numberOfPayments))
        let denominator = pow(1 + monthlyInterestRate, Double(numberOfPayments)) - 1
        let monthlyPayment = numerator / denominator
        let totalRepayment = monthlyPayment * 12 * Double(mossYear)
        let totalInterest = totalRepayment - mossWave
        return (monthlyPayment, totalRepayment, totalInterest)
    }

    static func reedFormatTwo(_ v: Double) -> String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.locale = Locale(identifier: "en_IN")
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 2
        return f.string(from: NSNumber(value: v)) ?? String(format: "%.2f", v)
    }
}

private struct CoralReefChevron: View {
    var body: some View {
        Path { p in
            p.move(to: CGPoint(x: 9, y: 6))
            p.addLine(to: CGPoint(x: 15, y: 12))
            p.addLine(to: CGPoint(x: 9, y: 18))
        }
        .stroke(Color(red: 16 / 255, green: 16 / 255, blue: 16 / 255), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
        .frame(width: 24, height: 24)
    }
}

private struct FogEmiStrip: View {
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

private enum ReedEmiFocus: Hashable {
    case mossA, mossB, mossC
}

struct LimeEmiInputPane: View {
    @State private var reedLoan = "50000"
    @State private var reedDuration = "5"
    @State private var reedInterest = "3"
    @State private var reedPushResult = false
    @State private var reedCargo: CoralEmiCargo?
    @FocusState private var reedEmiFocus: ReedEmiFocus?

    private let grapeTop = Color(red: 87 / 255, green: 12 / 255, blue: 146 / 255)
    private let grapeBottom = Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)
    private let limeBtn = Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255)

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(colors: [grapeTop, grapeBottom], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            Image("l2_bg")
                .resizable()
                .aspectRatio(375 / 341, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(edges: .top)
                .allowsHitTesting(false)

            VStack(spacing: 0) {
                FogEmiStrip(cliffTitle: "EMI")
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        reedLoanBlock
                        reedInterestBlock
                        reedDurationBlock

                        Button(action: reedTapSubmit) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 24, style: .continuous)
                                    .fill(limeBtn)
                                    .frame(height: 70)
                                Text("Submit")
                                    .font(SlateRiverFont.reed(18, .bold))
                                    .foregroundStyle(Color(red: 16 / 255, green: 16 / 255, blue: 16 / 255))
                                HStack {
                                    Spacer(minLength: 0)
                                    CoralReefChevron()
                                        .padding(.trailing, 20)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 12)
                    }
                    .padding(.horizontal, 11)
                    .padding(.top, 30)
                    .padding(.bottom, 40)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            NavigationLink(
                destination: Group {
                    if let c = reedCargo {
                        LimeEmiResultPane(cargo: c)
                    }
                },
                isActive: $reedPushResult,
                label: { EmptyView() }
            )
            .hidden()
        }
        .navigationBarHidden(true)
        .onChange(of: reedEmiFocus) { newFocus in
            reedStoneLeaveSnap(newFocus)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    reedEmiFocus = nil
                }
                .font(SlateRiverFont.reed(17, .semibold))
            }
        }
    }

    private func reedStoneLeaveSnap(_ newFocus: ReedEmiFocus?) {
        if newFocus != .mossA, reedLoan.filter(\.isNumber).isEmpty {
            reedLoan = "50000"
        }
        if newFocus != .mossB, reedInterest.filter(\.isNumber).isEmpty {
            reedInterest = "3"
        }
        if newFocus != .mossC, reedDuration.filter(\.isNumber).isEmpty {
            reedDuration = "5"
        }
    }

    private var reedLoanBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("loan amount/₹")
                    .font(SlateRiverFont.reed(18, .bold))
                    .foregroundStyle(Color.white)
                Spacer()
                Text("1~1,00,00,000")
                    .font(SlateRiverFont.reedItalic(14))
                    .tracking(0.42)
                    .foregroundStyle(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255))
            }
            HStack(spacing: 10) {
                TextField("", text: $reedLoan)
                    .focused($reedEmiFocus, equals: .mossA)
                    .keyboardType(.numberPad)
                    .font(SlateRiverFont.reed(reedLoanFontSize(reedLoan), .bold))
                    .foregroundStyle(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.35)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .onChange(of: reedLoan) { new in
                        let t = reedApplyLoanClamp(new)
                        if t != reedLoan { reedLoan = t }
                    }
                reedPadButton(isPlus: false) { reedStepLoan(-1000) }
                reedPadButton(isPlus: true) { reedStepLoan(1000) }
            }
        }
    }

    private var reedInterestBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Interest rate/%")
                    .font(SlateRiverFont.reed(18, .bold))
                    .foregroundStyle(Color.white)
                Spacer()
                Text("1~22")
                    .font(SlateRiverFont.reedItalic(14))
                    .tracking(0.42)
                    .foregroundStyle(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255))
            }
            HStack(spacing: 10) {
                TextField("", text: $reedInterest)
                    .focused($reedEmiFocus, equals: .mossB)
                    .keyboardType(.numberPad)
                    .font(SlateRiverFont.reed(45, .bold))
                    .foregroundStyle(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .onChange(of: reedInterest) { new in
                        let t = reedApplyIntClamp(new, minV: 1, maxV: 22)
                        if t != reedInterest { reedInterest = t }
                    }
                reedPadButton(isPlus: false) { reedStepInt(binding: $reedInterest, delta: -1, minV: 1, maxV: 22) }
                reedPadButton(isPlus: true) { reedStepInt(binding: $reedInterest, delta: 1, minV: 1, maxV: 22) }
            }
        }
    }

    private var reedDurationBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Duration/Year")
                    .font(SlateRiverFont.reed(18, .bold))
                    .foregroundStyle(Color.white)
                Spacer()
                Text("1～25")
                    .font(SlateRiverFont.reedItalic(14))
                    .tracking(0.42)
                    .foregroundStyle(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255))
            }
            HStack(spacing: 10) {
                TextField("", text: $reedDuration)
                    .focused($reedEmiFocus, equals: .mossC)
                    .keyboardType(.numberPad)
                    .font(SlateRiverFont.reed(45, .bold))
                    .foregroundStyle(Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .onChange(of: reedDuration) { new in
                        let t = reedApplyIntClamp(new, minV: 1, maxV: 25)
                        if t != reedDuration { reedDuration = t }
                    }
                reedPadButton(isPlus: false) { reedStepInt(binding: $reedDuration, delta: -1, minV: 1, maxV: 25) }
                reedPadButton(isPlus: true) { reedStepInt(binding: $reedDuration, delta: 1, minV: 1, maxV: 25) }
            }
        }
    }

    private func reedLoanFontSize(_ raw: String) -> CGFloat {
        let n = raw.filter(\.isNumber).count
        if n >= 8 { return 22 }
        if n >= 7 { return 26 }
        if n >= 6 { return 30 }
        if n >= 5 { return 36 }
        return 45
    }

    private func reedApplyLoanClamp(_ raw: String) -> String {
        let d = raw.filter(\.isNumber)
        if d.isEmpty { return "" }
        let capped = d.count > 8 ? String(d.prefix(8)) : d
        guard let v = Int(capped) else { return "10000000" }
        let c = min(max(v, 1), 10_000_000)
        return "\(c)"
    }

    private func reedApplyIntClamp(_ raw: String, minV: Int, maxV: Int) -> String {
        let d = raw.filter(\.isNumber)
        if d.isEmpty { return "" }
        guard let v = Int(d) else { return "\(maxV)" }
        let c = min(max(v, minV), maxV)
        return "\(c)"
    }

    private func reedPadButton(isPlus: Bool, tap: @escaping () -> Void) -> some View {
        Button(action: tap) {
            Image(isPlus ? "pineEmiPlusGlyph" : "pineEmiMinusGlyph")
                .resizable()
                .scaledToFit()
                .frame(width: 79, height: 79)
        }
        .buttonStyle(.plain)
    }

    private func reedStepLoan(_ delta: Int) {
        let raw = Int(reedLoan.filter(\.isNumber)) ?? 1
        let n = min(max(raw + delta, 1), 10_000_000)
        reedLoan = "\(n)"
    }

    private func reedStepInt(binding: Binding<String>, delta: Int, minV: Int, maxV: Int) {
        let raw = Int(binding.wrappedValue.filter(\.isNumber)) ?? minV
        let n = min(max(raw + delta, minV), maxV)
        binding.wrappedValue = "\(n)"
    }

    private func reedTapSubmit() {
        reedEmiFocus = nil
        reedStoneLeaveSnap(nil)
        let loanS = reedLoan.filter(\.isNumber)
        let durS = reedDuration.filter(\.isNumber)
        let intS = reedInterest.filter(\.isNumber)
        guard let la = Double(loanS), la >= 1, la <= 10_000_000,
              let d = Int(durS), d >= 1, d <= 25,
              let ir = Double(intS), ir >= 1, ir <= 22
        else {
            JuniperFogHUD.oakBad("Please check that the input is within the allowed range.")
            return
        }
        reedCargo = CoralEmiCargo(mossWave: la, mossYear: d, mossRate: ir)
        reedPushResult = true
    }
}

struct LimeEmiResultPane: View {
    let cargo: CoralEmiCargo
    @Environment(\.dismiss) private var driftPop

    @State private var reedMossStatus: Int?
    @State private var reedLoaded = false
    @State private var reedMossKycPick: CoralFogKycPick?
    @State private var reedKycGate = false

    private let grapeTop = Color(red: 87 / 255, green: 12 / 255, blue: 146 / 255)
    private let grapeBottom = Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)
    private let limeBtn = Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255)
    private let cardFill = Color(red: 77 / 255, green: 10 / 255, blue: 130 / 255)

    private var reedOutcome: (monthlyPayment: Double, totalRepayment: Double, totalInterest: Double) {
        LimeEmiFogMath.calculateEMI(
            mossWave: cargo.mossWave,
            mossRate: cargo.mossRate,
            mossYear: cargo.mossYear
        )
    }

    private var reedShowApply: Bool {
        guard let u = reedMossStatus else { return false }
        return u == 10 || u == 20
    }

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(colors: [grapeTop, grapeBottom], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            Image("l2_bg")
                .resizable()
                .aspectRatio(375 / 341, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(edges: .top)
                .allowsHitTesting(false)

            VStack(spacing: 0) {
                FogEmiStrip(cliffTitle: "Loan details")
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        Text("total payment(₹)")
                            .font(SlateRiverFont.reed(32, .heavy))
                            .tracking(-0.96)
                            .foregroundStyle(Color.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 19)

                        ZStack {
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .fill(Color.white.opacity(0.15))
                            Text(LimeEmiFogMath.reedFormatTwo(reedOutcome.totalRepayment))
                                .font(SlateRiverFont.reed(45, .bold))
                                .foregroundStyle(limeBtn)
                                .multilineTextAlignment(.center)
                                .lineLimit(1)
                                .minimumScaleFactor(0.35)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 16)
                        }
                        .frame(height: 80)
                        .frame(maxWidth: .infinity)

                        Color.clear.frame(height: 10)

                        
                        HStack(spacing: 12) {
                            reedMossTerraTile(
                                cliffLine: "monthly emi(₹)",
                                reefValue: LimeEmiFogMath.reedFormatTwo(reedOutcome.monthlyPayment)
                            )
                            reedMossTerraTile(
                                cliffLine: "total interest(₹)",
                                reefValue: LimeEmiFogMath.reedFormatTwo(reedOutcome.totalInterest)
                            )
                        }
                        .padding(.leading, 11)
                        .padding(.trailing, 10)
                        .frame(maxWidth: .infinity)

                        Color.clear.frame(height: 19)

                        VStack(spacing: 10) {
                            reedSummaryRow(left: "loan amount", right: "₹\(LimeEmiFogMath.reedFormatTwo(cargo.mossWave))")
                            reedSummaryRow(left: "Interest rate", right: "\(LimeEmiFogMath.reedFormatTwo(cargo.mossRate))%")
                            reedSummaryRow(left: "Duration", right: "\(cargo.mossYear)Year")
                        }

                        if reedShowApply {
                            
                            Button(action: reedTapApplyNow) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                                        .fill(limeBtn)
                                        .frame(height: 70)
                                    Text("Apply Now")
                                        .font(SlateRiverFont.reed(18, .bold))
                                        .foregroundStyle(Color(red: 16 / 255, green: 16 / 255, blue: 16 / 255))
                                    HStack {
                                        Spacer(minLength: 0)
                                        CoralReefChevron()
                                            .padding(.trailing, 20)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.plain)
                            .padding(.top, 8)
                        }
                    }
                    .padding(.horizontal, 11)
                    .padding(.bottom, 40)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .navigationBarHidden(true)
        .fullScreenCover(item: $reedMossKycPick, onDismiss: {
            ReedDriftStripGate.shared.mossPop()
            reedLoaded = false
            reedLoadUser()
        }) { pick in
            PearlWedHazePane(tideURL: pick.url, shellKycId: pick.shellKycId)
        }
        .onAppear(perform: reedLoadUser)
    }

    private func reedMossTerraTile(cliffLine: String, reefValue: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.white.opacity(0.15))
            VStack(alignment: .center, spacing: 7) {
                Text(cliffLine)
                    .font(SlateRiverFont.reed(11, .regular))
                    .tracking(0.22)
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                Text(reefValue)
                    .font(SlateRiverFont.reed(24, .bold))
                    .foregroundStyle(limeBtn)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 8)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 80)
    }

    private func reedSummaryRow(left: String, right: String) -> some View {
        HStack {
            Text(left)
                .font(SlateRiverFont.reed(14, .regular))
                .foregroundStyle(Color(red: 187 / 255, green: 127 / 255, blue: 235 / 255))
            Spacer()
            Text(right)
                .font(SlateRiverFont.reed(15, .medium))
                .foregroundStyle(Color.white)
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 65)
        .frame(maxWidth: .infinity)
        .background(cardFill)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }

    private func reedLoadUser() {
        guard !reedLoaded else { return }
        JuniperFogHUD.oakWait("Loading...")
        MeadowRelay.shared.runPine(.stoneUser(ReedStoneUserBody(duneAdid: nil)), sandType: TideUserInfoShell.self) { result in
            DispatchQueue.main.async {
                JuniperFogHUD.oakDismiss()
                reedLoaded = true
                switch result {
                case let .success(env):
                    reedMossStatus = env.tideData?.reedUserStatus
                case let .failure(err):
                    JuniperFogHUD.oakBad(err.fogReedLine)
                }
            }
        }
    }

    private func reedTapApplyNow() {
        guard let u = reedMossStatus else { return }
        if u == 10 {
            reedStartKycFromEmi()
        } else if u == 20 {
            NotificationCenter.default.post(name: .coralReefTabPick, object: 0)
            NotificationCenter.default.post(name: .reedEmiExitToHome, object: nil)
        }
    }

    private func reedStartKycFromEmi() {
        guard !reedKycGate else { return }
        reedKycGate = true
        JuniperFogHUD.oakWait("Loading...")
        MeadowRelay.shared.runPine(.riverVault(EmptyShell()), sandType: LichenKycVaultShell.self) { res in
            DispatchQueue.main.async {
                switch res {
                case let .success(env):
                    let rows = env.tideData?.reefMossList ?? []
                    reedKycGate = false
                    guard let kid = rows.driftPendingShellId() else {
                        JuniperFogHUD.oakDismiss()
                        return
                    }
                    ReedDriftStripGate.shared.mossPush()
                    reedMossKycPick = CoralFogKycPick(url: URL(string: "https://page.kunalresources.com/dist/kyc/index.html")!, shellKycId: kid)
                case let .failure(err):
                    JuniperFogHUD.oakDismiss()
                    reedKycGate = false
                    JuniperFogHUD.oakBad(err.fogReedLine)
                }
            }
        }
    }
}
