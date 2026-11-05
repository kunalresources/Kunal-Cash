import SwiftUI

struct FernCoralPane: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [FernCoralTwig.grapeTop, FernCoralTwig.grapeBottom],
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

            VStack(spacing: 0) {
                ZStack(alignment: .center) {
                    HStack {
                        Button(action: { dismiss() }) {
                            Image("amberQuartz")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Back")
                        Spacer()
                    }
                    Text("Credit Score")
                        .font(SlateRiverFont.reed(18, .medium))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 52)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 10)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        Image("ivyOakPanel")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)

                        Text(Self.reedBodyCopy)
                            .font(SlateRiverFont.reed(16, .regular))
                            .foregroundStyle(Color.white)
                            .lineSpacing(4)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(Self.reedNoteCopy)
                            .font(SlateRiverFont.reed(16, .regular))
                            .foregroundStyle(FernCoralTwig.limeCard)
                            .lineSpacing(4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }

                Button(action: { dismiss() }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .fill(FernCoralTwig.limeCard)
                            .frame(height: 70)
                        Text("OK")
                            .font(SlateRiverFont.reed(18, .bold))
                            .foregroundStyle(Color(red: 16 / 255, green: 16 / 255, blue: 16 / 255))
                        HStack {
                            Spacer(minLength: 0)
                            FernCoralChevronGlyph()
                                .padding(.trailing, 21)
                        }
                    }
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.bottom, 28)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .navigationBarHidden(true)
    }

    private static let reedBodyCopy = "Our credit scoring system uses a personalized approach to provide unique credit assessments through careful analysis of your financial situation. We combine key indicators such as payment records, credit card usage patterns, outstanding debt status, length of credit history, and the frequency of new credit applications. Using state-of-the-art algorithms, our scoring model accurately measures your credit risk and offers intelligent decision support for lending institutions and financial organizations. Whether you are applying for a loan, a credit card, or other financial products, our credit scoring provides comprehensive, personalized evaluations to assist you in making prudent financial planning decisions."

    private static let reedNoteCopy = "*This score is calculated by this app and may not match other credit scores."
}

private struct FernCoralChevronGlyph: View {
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

private enum FernCoralTwig {
    static let grapeTop = Color(red: 87 / 255, green: 12 / 255, blue: 146 / 255)
    static let grapeBottom = Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)
    static let limeCard = Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255)
}
