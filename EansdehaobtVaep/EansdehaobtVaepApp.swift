import SwiftUI
import UIKit

@main
struct EansdehaobtVaepApp: App {
    @UIApplicationDelegateAdaptor(PebbleMistGate.self) private var pebbleMistGate

    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .riverStoneKeyboardDone()
                QuartzFogPane()
                AmberReefDialogPane()
            }
            .environmentObject(RavenMistBucket.shared)
            .environmentObject(AmberReefDialogHost.shared)
        }
    }
}

