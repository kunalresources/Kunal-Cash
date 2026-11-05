import SwiftUI
import Combine

enum MykhailoType {
    case MykhailoNone
    case MykhailoMore
    case MykhailoGo
    case MykhailoOtherGo
}

class IncreasinTembState: ObservableObject {
    
    static let shared = IncreasinTembState()
    
    @Published var showOverlay = false
    
    var fedorovRmer: ((MykhailoType) -> Void)? = nil
    
}

struct IncreasinTembModifier<CoverContent: View>: ViewModifier {
    
    @ObservedObject var tembState = IncreasinTembState.shared
    
    let coverContent: () -> CoverContent
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if tembState.showOverlay {
                coverContent()
                    .transition(.opacity)
            }
        }
    }
}

struct MykhailoView: View {
    
    @ObservedObject var tembState = IncreasinTembState.shared
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.75)
                .ignoresSafeArea()
            VStack(alignment: .center , spacing: 18) {
                Text("We are reviewing your profile to provide more suitable products. Priority matching in progress, estimated time: 10 seconds...")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                    .font(SlateRiverFont.reed(14, .regular))
                Text("Matching in progress")
                    .foregroundStyle(Color.white)
                    .font(SlateRiverFont.reed(14, .bold))
                Image(.time)
            }
        }
        .task {
            loadData()
            await runCountdown()
        }
    }
    
    func runCountdown() async {
        for _ in stride(from: 10, through: 1, by: -1) {
            if Task.isCancelled { return }

            await MainActor.run {
                
            }

            do {
                try await Task.sleep(nanoseconds: 1_000_000_000)
            } catch {
                return
            }
        }
        await MainActor.run {
            tembState.showOverlay = false
            tembState.fedorovRmer?(.MykhailoNone)
        }
    }
    
    func loadData() {
        MeadowRelay.shared.runPine(.dernisin(EmptyShell()), sandType: MilitaryDrones.self) { result in
            DispatchQueue.main.async {
                
                guard tembState.showOverlay == true else { return }

                tembState.showOverlay = false
                switch result {
                case let .success(army):
                    if let array = army.tideData?.productInfoList {
                        if array.count == 0 {
                            tembState.fedorovRmer?(.MykhailoNone)
                        } else {
                            tembState.fedorovRmer?(.MykhailoMore)
                        }
                    } else {
                        tembState.fedorovRmer?(.MykhailoNone)
                    }
                case let .failure(err):
                    switch err {
                    case .mistBusiness(let code, _):
                        if code == 4102007 {
                            tembState.fedorovRmer?(.MykhailoGo)
                        } else {
                            tembState.fedorovRmer?(.MykhailoOtherGo)
                        }
                    default:
                        tembState.fedorovRmer?(.MykhailoNone)
                    }
                }
            }
        }
    }
}


