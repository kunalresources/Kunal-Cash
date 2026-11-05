import Foundation

extension ReedFernCevimceBody {
    
    static func duneRamCanUse() -> String {
        let hostPort = mach_host_self()
        var hostSize = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.size / MemoryLayout<integer_t>.size)
        var pageSize: vm_size_t = 0
        if host_page_size(hostPort, &pageSize) != KERN_SUCCESS {
            return "-1"
        }
        var vmStat = vm_statistics_data_t()
        let hit = withUnsafeMutablePointer(to: &vmStat) { point in
            point.withMemoryRebound(to: integer_t.self, capacity: Int(hostSize)) { rebounded in
                host_statistics(hostPort, HOST_VM_INFO, rebounded, &hostSize)
            }
        }
        if hit != KERN_SUCCESS {
            return "-1"
        }
        let used = UInt(vmStat.active_count + vmStat.inactive_count + vmStat.wire_count) * UInt(pageSize)
        let total = Double(ProcessInfo.processInfo.physicalMemory) / 1024.0 / 1024.0
        let usedMb = Double(used) / 1024.0 / 1024.0
        let canUse = (total - usedMb) / 1024.0
        return String(format: "%.6f", canUse)
    }

    static func duneCashTotal() -> String {
        if let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
           let size = attrs[.systemSize] as? Int,
           size > 0 {
            let leaf = Double(size) / (1024.0 * 1024.0 * 1024.0)
            return String(format: "%.6f", leaf)
        }
        return "-1"
    }

    static func duneCashCanUse() -> String {
        if let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
           let size = attrs[.systemFreeSize] as? Int,
           size > 0 {
            let leaf = Double(size) / (1024.0 * 1024.0 * 1024.0)
            return String(format: "%.6f", leaf)
        }
        return "-1"
    }
    
}
