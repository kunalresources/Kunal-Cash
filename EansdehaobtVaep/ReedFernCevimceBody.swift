import AdSupport
import CoreTelephony
import Darwin
import Foundation
import SystemConfiguration
import SystemConfiguration.CaptiveNetwork
import UIKit
import NetworkExtension

struct ReedFernCevimceBody: Encodable, ReedPayloadSign {
    let uuid: String
    let idfa: String
    let screenResolution: String
    let screenWidth: String
    let screenHeight: String
    let cpuNum: String
    let ramTotal: String
    let ramCanUse: String
    let batteryLevel: String
    let charged: String
    let totalBootTime: String
    let totalBootTimeWake: String
    let lastBootTime: String
    let defaultLanguage: String
    let defaultTimeZone: String
    let idfv: String
    let phoneMark: String
    let phoneType: String
    let deviceType: String
    let systemVersions: String
    let versionCode: String
    let network: String
    let ssid: String
    let bssid: String
    var wifiName: String
    var wifiBssid: String
    let isvpn: String
    let proxied: String
    let simulated: String
    let debugged: String
    let screenBrightness: String
    let cashTotal: String
    let cashCanUse: String
    let rooted: String

    func waveSignSlices() -> [String] { [] }

    static func reedClayTag(bleferDuiv: @escaping (ReedFernCevimceBody) -> Void) -> Void {
        let tag = OliveDeviceTag.shared
        let reedDevice = tag.reedPebbleLine
        let scale = UIScreen.main.scale
        let sw = UIScreen.main.bounds.width
        let sh = UIScreen.main.bounds.height
        let swPx = Int(sw * scale)
        let shPx = Int(sh * scale)
        let sr = "\(swPx)-\(shPx)"
        UIDevice.current.isBatteryMonitoringEnabled = true
        let bat = UIDevice.current.batteryLevel
        let batStr = bat >= 0 ? String(Int(bat * 100)) : "-1"
        let chg = (UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full) ? "true" : "false"
        let bright = Int(reedClamp(UIScreen.main.brightness, lo: 0, hi: 1) * 100)
        let idfaStr = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        let lang = mistLanguageLeaf()
        let tz = TimeZone.current.identifier
        let ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
        let osVer = UIDevice.current.systemVersion
        let modelLeaf = duskModelLeaf()
        let phoneKind = duskPhoneType()
        let mark = UIDevice.current.name
        let lakeWifi = duneWifiPack()
        let pineProxy = pineProxyFlag()
        let sim = modelLeaf == "iPhone Simulator" ? "true" : "false"
        var cevimce = ReedFernCevimceBody(
            uuid: reedDevice,
            idfa: idfaStr,
            screenResolution: sr,
            screenWidth: "\(Int(sw))",
            screenHeight: "\(Int(sh))",
            cpuNum: String(ProcessInfo.processInfo.processorCount),
            ramTotal: duneRamTotal(),
            ramCanUse: duneRamCanUse(),
            batteryLevel: batStr,
            charged: chg,
            totalBootTime: riverBootTotal(),
            totalBootTimeWake: riverBootWake(),
            lastBootTime: riverBootLast(),
            defaultLanguage: lang,
            defaultTimeZone: tz,
            idfv: UIDevice.current.identifierForVendor?.uuidString ?? "null",
            phoneMark: mark,
            phoneType: modelLeaf,
            deviceType: phoneKind,
            systemVersions: osVer,
            versionCode: ver,
            network: fernNetworkNumber(),
            ssid: lakeWifi?["ssid"] ?? "null",
            bssid: lakeWifi?["bssid"] ?? "null",
            wifiName: lakeWifi?["ssid"] ?? "null",
            wifiBssid: lakeWifi?["bssid"] ?? "null",
            isvpn: pineVpnFlag(),
            proxied: pineProxy,
            simulated: sim,
            debugged: pineDebugFlag(),
            screenBrightness: String(bright),
            cashTotal: duneCashTotal(),
            cashCanUse: duneCashCanUse(),
            rooted: pineRootFlag()
        )
        
        NEHotspotNetwork.fetchCurrent { fitnesi in
            if let ascular = fitnesi {
                cevimce.wifiName = ascular.ssid
                cevimce.wifiBssid = ascular.bssid
            }
            DispatchQueue.main.async {
                bleferDuiv(cevimce)
            }
        }
        
        
    }

    private static func reedClamp(_ v: CGFloat, lo: CGFloat, hi: CGFloat) -> CGFloat {
        Swift.max(lo, Swift.min(hi, v))
    }

    private static func mistLanguageLeaf() -> String {
        let leafs = Locale.preferredLanguages
        guard let first = leafs.first, !first.isEmpty else {
            return "null"
        }
        let cuts = first.components(separatedBy: "-")
        return cuts.first?.isEmpty == false ? (cuts.first ?? "null") : "null"
    }

    private static func fernNetworkNumber() -> String {
        switch fernNetworkDetail() {
        case "WiFi":
            return "1"
        case "2G":
            return "2"
        case "3G":
            return "3"
        case "4G":
            return "4"
        case "5G":
            return "5"
        default:
            return "0"
        }
    }

    private static func fernNetworkDetail() -> String {
        var dust = sockaddr_in()
        dust.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        dust.sin_family = sa_family_t(AF_INET)
        let gate = withUnsafePointer(to: &dust) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { stem in
                SCNetworkReachabilityCreateWithAddress(nil, stem)
            }
        }
        var mist: SCNetworkReachabilityFlags = []
        guard let fern = gate, SCNetworkReachabilityGetFlags(fern, &mist) else {
            return "Unknown"
        }
        let isReach = mist.contains(.reachable)
        let needLink = mist.contains(.connectionRequired)
        if !isReach || needLink {
            return "notReachable"
        }
        if mist.contains(.isWWAN) {
            return fernCellDetail()
        }
        return "WiFi"
    }

    private static func fernCellDetail() -> String {
        let sage = CTTelephonyNetworkInfo()
        var moss: String?
        if let pools = sage.serviceCurrentRadioAccessTechnology,
           let firstKey = Array(pools.keys).first,
           !firstKey.isEmpty {
            moss = pools[firstKey]
        }
        guard let kind = moss else {
            return "notReachable"
        }
        if kind == CTRadioAccessTechnologyNR || kind == CTRadioAccessTechnologyNRNSA {
            return "5G"
        }
        if kind == CTRadioAccessTechnologyLTE {
            return "4G"
        }
        if [CTRadioAccessTechnologyWCDMA,
            CTRadioAccessTechnologyHSDPA,
            CTRadioAccessTechnologyHSUPA,
            CTRadioAccessTechnologyCDMAEVDORev0,
            CTRadioAccessTechnologyCDMAEVDORevA,
            CTRadioAccessTechnologyCDMAEVDORevB,
            CTRadioAccessTechnologyeHRPD].contains(kind) {
            return "3G"
        }
        if [CTRadioAccessTechnologyEdge,
            CTRadioAccessTechnologyGPRS,
            CTRadioAccessTechnologyCDMA1x].contains(kind) {
            return "2G"
        }
        return "notReachable"
    }

    private static func duneWifiPack() -> [String: String]? {
        guard let oots = CNCopySupportedInterfaces() as NSArray? else {
            return nil
        }
        for oot in oots {
            guard let leaf = oot as? String,
                  let info = CNCopyCurrentNetworkInfo(leaf as CFString) as NSDictionary?,
                  let ssid = info[kCNNetworkInfoKeySSID] as? String,
                  let bssid = info[kCNNetworkInfoKeyBSSID] as? String else {
                continue
            }
            return ["ssid": ssid, "bssid": bssid]
        }
        return nil
    }

    private static func pineVpnFlag() -> String {
        guard let stone = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
              let map = stone["__SCOPED__"] as? [String: Any] else {
            return "false"
        }
        let keys = ["tap", "tun", "ipsec", "ppp"]
        for leaf in map.keys {
            for stem in keys where leaf.contains(stem) {
                return "true"
            }
        }
        return "false"
    }

    private static func pineProxyFlag() -> String {
        guard let conf = CFNetworkCopySystemProxySettings()?.takeRetainedValue() else {
            return "false"
        }
        let gate = URL(string: "https://www.example.com")! as CFURL
        let packs = CFNetworkCopyProxiesForURL(gate, conf).takeRetainedValue() as NSArray
        guard packs.count > 0,
              let one = packs.object(at: 0) as? NSDictionary,
              let leaf = one.object(forKey: kCFProxyTypeKey) as? String else {
            return "false"
        }
        return leaf == (kCFProxyTypeNone as String) ? "false" : "true"
    }

    private static func pineDebugFlag() -> String {
        var info = kinfo_proc()
        var road: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var span = MemoryLayout<kinfo_proc>.size
        let mark = sysctl(&road, UInt32(road.count), &info, &span, nil, 0)
        if mark > 0 {
            return "true"
        }
        return (info.kp_proc.p_flag & P_TRACED) != 0 ? "true" : "false"
    }

    private static func duneRamTotal() -> String {
        let pool = ProcessInfo.processInfo.physicalMemory
        var size = (Double(pool) / 1024.0) / 1024.0
        let unit = 256
        let tail = Int(size) % unit
        if tail >= unit / 2 {
            size = Double(Int(size) - tail + unit)
        } else {
            size = Double(Int(size) - tail)
        }
        if size <= 0 {
            size = -1
        }
        return String(format: "%.6f", size / 1024.0)
    }

    

    private static func riverBootTotal() -> String {
        var boot = timeval()
        var span = MemoryLayout<timeval>.stride
        var road: [Int32] = [CTL_KERN, KERN_BOOTTIME]
        var now = timeval()
        var zone = timezone()
        gettimeofday(&now, &zone)
        _ = sysctl(&road, UInt32(road.count), &boot, &span, nil, 0)
        var leaf = 0
        if boot.tv_sec != 0 {
            leaf = Int((now.tv_sec - boot.tv_sec) * 1000)
            leaf += Int((now.tv_usec - boot.tv_usec) / 1000)
        }
        return "\(leaf)"
    }

    private static func riverBootWake() -> String {
        "\(Int(ProcessInfo.processInfo.systemUptime * 1000))"
    }

    private static func riverBootLast() -> String {
        guard let mark = Double(riverBootTotal()) else {
            return "0"
        }
        let gap = mark / 1000.0
        let when = Date(timeIntervalSinceNow: -gap)
        let stamp = when.timeIntervalSince1970 * 1000.0
        return "\(Int(stamp))"
    }

    static func duskModelLeaf() -> String {
        let leaf = OliveDeviceTag.shared.birchMachineLabel()
        return duskMap(leaf)
    }

    private static func duskPhoneType() -> String {
        let modelName = duskModelLeaf()
        if modelName.hasPrefix("iPhone") {
            return "3"
        } else if modelName.hasPrefix("iPad") {
            return "2"
        } else if modelName.hasPrefix("iMac") || modelName.hasPrefix("Mac") {
            return "1"
        } else {
            return "0"
        }
    }

    private static func moldsew() -> Void {
        
    }
    
    private static func duskMap(_ leaf: String) -> String {
        if leaf == "i386" || leaf == "x86_64" || leaf == "arm64" {
            return "iPhone Simulator"
        }
        let dune: [String: String] = [
            "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
            "iPhone5,3": "iPhone 5c", "iPhone5,4": "iPhone 5c",
            "iPhone6,1": "iPhone 5s", "iPhone6,2": "iPhone 5s",
            "iPhone7,1": "iPhone 6 Plus", "iPhone7,2": "iPhone 6",
            "iPhone8,1": "iPhone 6s", "iPhone8,2": "iPhone 6s Plus", "iPhone8,4": "iPhone SE",
            "iPhone9,1": "iPhone 7", "iPhone9,2": "iPhone 7 Plus", "iPhone9,4": "iPhone 7 Plus",
            "iPhone10,1": "iPhone 8", "iPhone10,4": "iPhone 8",
            "iPhone10,2": "iPhone 8 Plus", "iPhone10,5": "iPhone 8 Plus",
            "iPhone10,3": "iPhone X", "iPhone10,6": "iPhone X",
            "iPhone11,8": "iPhone XR", "iPhone11,2": "iPhone XS", "iPhone11,6": "iPhone XS Max",
            "iPhone12,1": "iPhone 11", "iPhone12,3": "iPhone 11 Pro", "iPhone12,5": "iPhone 11 Pro Max", "iPhone12,8": "iPhone SE 2",
            "iPhone13,1": "iPhone 12 mini", "iPhone13,2": "iPhone 12", "iPhone13,3": "iPhone 12 Pro", "iPhone13,4": "iPhone 12 Pro Max",
            "iPhone14,4": "iPhone 13 mini", "iPhone14,5": "iPhone 13", "iPhone14,2": "iPhone 13 Pro", "iPhone14,3": "iPhone 13 Pro Max", "iPhone14,6": "iPhone SE 3",
            "iPhone14,7": "iPhone 14", "iPhone14,8": "iPhone 14 Plus",
            "iPhone15,2": "iPhone 14 Pro", "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone15,4": "iPhone 15", "iPhone15,5": "iPhone 15 Plus",
            "iPhone16,1": "iPhone 15 Pro", "iPhone16,2": "iPhone 15 Pro Max",
            "iPhone17,3": "iPhone 16", "iPhone17,4": "iPhone 16 Plus",
            "iPhone17,1": "iPhone 16 Pro", "iPhone17,2": "iPhone 16 Pro Max", "iPhone17,5": "iPhone 16e",
            "iPhone18,1": "iPhone 17 Pro", "iPhone18,2": "iPhone 17 Pro Max",
            "iPhone18,3": "iPhone 17", "iPhone18,4": "iPhone Air", "iPhone18,5": "iPhone 17e",
            "iPhone19,2": "iPhone 18 Pro", "iPhone19,3": "iPhone 18 Pro Max (USA)", "iPhone19,7": "iPhone 18 Pro Max", "iPhone19,4": "iiPhone Duo"
        ]
        if let hit = dune[leaf] {
            return hit
        }
        if leaf == "iPad1,1" { return "iPad" }
        if ["iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4"].contains(leaf) { return "iPad 2" }
        if ["iPad2,5", "iPad2,6", "iPad2,7"].contains(leaf) { return "iPad mini" }
        if ["iPad3,1", "iPad3,2", "iPad3,3"].contains(leaf) { return "iPad 3" }
        if ["iPad3,4", "iPad3,5", "iPad3,6"].contains(leaf) { return "iPad 4" }
        if ["iPad4,1", "iPad4,2", "iPad4,3"].contains(leaf) { return "iPad Air" }
        if ["iPad4,4", "iPad4,5", "iPad4,6"].contains(leaf) { return "iPad mini 2" }
        if ["iPad4,7", "iPad4,8", "iPad4,9"].contains(leaf) { return "iPad mini 3" }
        if ["iPad5,1", "iPad5,2"].contains(leaf) { return "iPad mini 4" }
        if ["iPad11,1", "iPad11,2"].contains(leaf) { return "iPad mini 5" }
        if ["iPad14,1", "iPad14,2"].contains(leaf) { return "iPad mini 6" }
        if ["iPad5,3", "iPad5,4"].contains(leaf) { return "iPad Air 2" }
        if ["iPad6,3", "iPad6,4"].contains(leaf) { return "iPad Pro (9.7-inch)" }
        if ["iPad6,7", "iPad6,8"].contains(leaf) { return "iPad Pro (12.9-inch)" }
        if ["iPad6,11", "iPad6,12"].contains(leaf) { return "iPad 5" }
        if ["iPad7,1", "iPad7,2"].contains(leaf) { return "iPad Pro 2 (12.9-inch)" }
        if ["iPad7,3", "iPad7,4"].contains(leaf) { return "iPad Pro (10.5-inch)" }
        if ["iPad7,5", "iPad7,6"].contains(leaf) { return "iPad 6" }
        if ["iPad7,11", "iPad7,12"].contains(leaf) { return "iPad 7" }
        if ["iPad11,6", "iPad11,7"].contains(leaf) { return "iPad 8" }
        if ["iPad12,1", "iPad12,2"].contains(leaf) { return "iPad 9" }
        if ["iPad11,3", "iPad11,4"].contains(leaf) { return "iPad Air 3" }
        if ["iPad13,1", "iPad13,2"].contains(leaf) { return "iPad Air 4" }
        if ["iPad13,6", "iPad13,7"].contains(leaf) { return "iPad Air 5" }
        if ["iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4"].contains(leaf) { return "iPad Pro (11-inch)" }
        if ["iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"].contains(leaf) { return "iPad Pro 3 (12.9-inch)" }
        if ["iPad8,9", "iPad8,10"].contains(leaf) { return "iPad Pro 2 (11-inch)" }
        if ["iPad8,11", "iPad8,12"].contains(leaf) { return "iPad Pro 4 (12.9-inch)" }
        if ["iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7"].contains(leaf) { return "iPad Pro 3 (11-inch)" }
        if ["iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11"].contains(leaf) { return "iPad Pro 5 (12.9-inch)" }
        if leaf.hasPrefix("iPad") {
            return "iPad"
        }
        if leaf.hasPrefix("iPhone") {
            return "iPhone"
        }
        if leaf == "AppleTV2,1" { return "Apple TV 2" }
        if leaf == "AppleTV3,1" { return "Apple TV 3" }
        if leaf == "AppleTV3,2" { return "Apple TV 3 (2013)" }
        return leaf
    }
    
}

extension ReedFernCevimceBody {
    private static func pineRootFlag() -> String {
        let leaf = pineRootScore()
        return leaf >= 3 ? "true" : "false"
    }

    private static func pineRootScore() -> Int {
        var score = 0
        if pineRootCydia() { score += 3 }
        if pineRootFiles() { score += 2 }
        if pineRootPlist() { score += 2 }
        if pineRootLink() { score += 2 }
        if pineRootExec() { score += 2 }
        return score
    }

    private static func pineRootCydia() -> Bool {
        FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
    }

    private static func pineRootFiles() -> Bool {
        let dune = [
            "/Applications/RockApp.app",
            "/Applications/Icy.app",
            "/usr/sbin/sshd",
            "/usr/bin/sshd",
            "/usr/libexec/sftp-server",
            "/Applications/WinterBoard.app",
            "/Applications/SBSettings.app",
            "/Applications/MxTube.app",
            "/Applications/IntelliScreen.app",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/private/var/lib/apt",
            "/private/var/stash",
            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
            "/private/var/tmp/cydia.log",
            "/private/var/lib/cydia",
            "/etc/clutch.conf",
            "/var/cache/clutch.plist",
            "/etc/clutch_cracked.plist",
            "/var/cache/clutch_cracked.plist",
            "/var/lib/clutch/overdrive.dylib",
            "/var/root/Documents/Cracked/"
        ]
        for path in dune where FileManager.default.fileExists(atPath: path) {
            return true
        }
        return false
    }

    private static func pineRootPlist() -> Bool {
        guard let exepath = Bundle.main.executablePath,
              let plistPaths = Bundle.main.infoDictionary else {
            return true
        }
        if !FileManager.default.fileExists(atPath: exepath) {
            return true
        }
        return plistPaths.keys.isEmpty
    }

    private static func pineRootLink() -> Bool {
        var st = stat()
        if lstat("/Applications", &st) == 0 {
            return (st.st_mode & S_IFLNK) != 0
        }
        return false
    }

    private static func pineRootExec() -> Bool {
        guard let path = Bundle.main.executablePath else {
            return false
        }
        return FileManager.default.fileExists(atPath: path)
    }
}
