import SwiftUI

struct QuartzFogPane: View {
    @EnvironmentObject private var hub: RavenMistBucket

    var body: some View {
        ZStack {
            switch hub.blade {
            case .idle:
                EmptyView()
            case let .veilWait(text, blockBelow):
                ZStack {
                    veilBackdrop(blockBelow: blockBelow)
                    mistCardShell {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.primary))
                        if let t = text, !t.isEmpty {
                            Text(t)
                                .font(SlateRiverFont.reed(15, .medium))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.primary)
                        }
                    }
                }
            case let .veilBar(text, ratio, blockBelow):
                ZStack {
                    veilBackdrop(blockBelow: blockBelow)
                    mistCardShell {
                        tideRing(ratio: ratio)
                        if let t = text, !t.isEmpty {
                            Text(t)
                                .font(SlateRiverFont.reed(15, .medium))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.primary)
                        }
                    }
                }
            case let .chipGood(text, _):
                ZStack {
                    chipBackdrop()
                    mistCardShell {
                        Text("\u{2713}")
                            .font(SlateRiverFont.reed(28, .bold))
                            .foregroundColor(Color.green)
                        if let t = text, !t.isEmpty {
                            Text(t)
                                .font(SlateRiverFont.reed(15, .medium))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.primary)
                        }
                    }
                }
            case let .chipBad(text, _):
                ZStack {
                    chipBackdrop()
                    mistCardShell {
                        Text("\u{2717}")
                            .font(SlateRiverFont.reed(26, .bold))
                            .foregroundColor(Color.red.opacity(0.9))
                        if let t = text, !t.isEmpty {
                            Text(t)
                                .font(SlateRiverFont.reed(15, .medium))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.primary)
                        }
                    }
                }
            case let .chipBanner(top, detail, _):
                ZStack {
                    chipBackdrop()
                    mistCardShell {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.primary))
                        if let t = top, !t.isEmpty {
                            Text(t)
                                .font(SlateRiverFont.reed(16, .semibold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.primary)
                        }
                        if let d = detail, !d.isEmpty {
                            Text(d)
                                .font(SlateRiverFont.reed(13, .regular))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.secondary)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .allowsHitTesting(hub.blade != .idle)
        .animation(.easeInOut(duration: 0.2), value: hub.blade)
    }

    @ViewBuilder
    private func veilBackdrop(blockBelow _: Bool) -> some View {
        Color.black.opacity(0.38)
            .ignoresSafeArea()
            .contentShape(Rectangle())
            .allowsHitTesting(true)
            .onTapGesture {}
    }

    @ViewBuilder
    private func chipBackdrop() -> some View {
        Color.clear
            .ignoresSafeArea()
            .contentShape(Rectangle())
            .allowsHitTesting(true)
            .onTapGesture {}
    }

    private func mistCardShell<Inner: View>(@ViewBuilder inner: () -> Inner) -> some View {
        VStack(spacing: 12) {
            inner()
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 20)
        .frame(minWidth: 132)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Material.ultraThinMaterial)
        )
        .shadow(color: Color.black.opacity(0.18), radius: 18, y: 8)
    }

    private func tideRing(ratio: CGFloat) -> some View {
        let v = max(0, min(1, ratio))
        return ZStack {
            Circle()
                .stroke(Color.primary.opacity(0.18), lineWidth: 4)
                .frame(width: 40, height: 40)
            Circle()
                .trim(from: 0, to: CGFloat(v))
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .frame(width: 40, height: 40)
                .rotationEffect(.degrees(-90))
        }
    }
}
