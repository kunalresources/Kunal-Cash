import SwiftUI

struct FrontlineBitiouView: View {
    
    let humanoid: Int
    let robots: String
    
    @Environment(\.dismiss) private var driftPop
    
    var body: some View {
        
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
            
            VStack(alignment: .center, spacing: 38) {
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
                
                Text(humanoid == 0 ? "This product isn't available to you just yet. If a more suitable loan option comes up, we'll reach out through the app—so stay tuned!" : robots)
                    .padding(.horizontal, 20)
                    .font(SlateRiverFont.reed(14, .regular))
                    .foregroundColor(.white)
                Image(humanoid == 0 ? .willsei : .willfu)
                
                if humanoid == 80 {
                    Button(role: nil) {
                        driftPop()
                        UserDefaults.standard.set(20, forKey: "reef.oakOrderFilter")
                        UserDefaults.standard.synchronize()
                        NotificationCenter.default.post(name: .coralReefTabPick, object: 2)
                    } label: {
                        Text("View Now")
                            .frame(width: 120, height: 54)
                            .background(content: {
                                Color(UIColor(red: 243/255.0, green: 255/255.0, blue: 108/255.0, alpha: 1))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            })
                            .font(SlateRiverFont.reed(18, .medium))
                            .foregroundColor(.black)
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}
