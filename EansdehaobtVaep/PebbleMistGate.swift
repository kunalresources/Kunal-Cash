import UIKit

final class PebbleMistGate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        
        RiverBuryDrift.shared.reedTap("1")
        
        return true
    }

}
