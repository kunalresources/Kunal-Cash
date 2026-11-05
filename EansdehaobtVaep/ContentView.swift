import SwiftUI

struct ContentView: View {
    @StateObject private var tideAuth = TideAuthOak()

    var body: some View {
        Group {
            if tideAuth.duneSigned {
                GrapeLimeTabShell()
            } else {
                MintCreekView()
            }
        }
        .environmentObject(tideAuth)
        .onReceive(NotificationCenter.default.publisher(for: .reedWaveVersionNeed)) { _ in
            ReedWaveMistLift.mossWaveCheck(forceOnce: false)
        }
        .onReceive(NotificationCenter.default.publisher(for: .reedBreezeGone)) { _ in
            JuniperFogHUD.oakDismiss()
            tideAuth.refreshReedGate()
        }
        .modifier(IncreasinTembModifier(coverContent: {
            MykhailoView()
        }))
    }
}

#Preview {
    ZStack {
        ContentView()
        QuartzFogPane()
        AmberReefDialogPane()
    }
    .environmentObject(RavenMistBucket.shared)
    .environmentObject(AmberReefDialogHost.shared)
}
