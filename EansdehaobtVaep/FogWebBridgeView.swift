import SwiftUI
import UIKit
import WebKit

struct FogWebBridgeView: View {
    let tideURL: URL
    let reedFogTitle: String
    @Environment(\.dismiss) private var dismiss

    @State private var reedTide: Double = 0
    @State private var mossShowBar = true

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [DunePaperStone.grapeTop, DunePaperStone.grapeBottom],
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
                    Text(reedFogTitle)
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

                if mossShowBar {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.white.opacity(0.2))
                            .frame(height: 3)
                        Rectangle()
                            .fill(DunePaperStone.limeCard)
                            .frame(maxWidth: .infinity, maxHeight: 3, alignment: .leading)
                            .scaleEffect(x: min(max(reedTide, 0), 1), y: 1, anchor: .leading)
                    }
                    .frame(height: 3)
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(edges: .horizontal)
                }

                GlenWebRepresentable(
                    tideURL: tideURL,
                    reedTide: $reedTide,
                    mossShowBar: $mossShowBar
                )
                .background(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(edges: [.bottom, .horizontal])
                .ignoresSafeArea(.keyboard)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
    }
}

private enum DunePaperStone {
    static let grapeTop = Color(red: 87 / 255, green: 12 / 255, blue: 146 / 255)
    static let grapeBottom = Color(red: 68 / 255, green: 8 / 255, blue: 116 / 255)
    static let limeCard = Color(red: 243 / 255, green: 255 / 255, blue: 108 / 255)
}

private struct GlenWebRepresentable: UIViewRepresentable {
    let tideURL: URL
    @Binding var reedTide: Double
    @Binding var mossShowBar: Bool

    func makeCoordinator() -> GlenWebCull {
        GlenWebCull(reedTide: $reedTide, mossShowBar: $mossShowBar)
    }

    func makeUIView(context: Context) -> WKWebView {
        let w = WKWebView(frame: .zero)
        w.isOpaque = true
        w.backgroundColor = .white
        w.scrollView.backgroundColor = .white
        w.scrollView.isOpaque = true
        MossReedWebKit.reedPrepareH5Scroll(w)
        if #available(iOS 15.0, *) {
            w.underPageBackgroundColor = .white
        }
        context.coordinator.bind(webView: w)
        w.load(URLRequest(url: tideURL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData))
        return w
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        context.coordinator.reedTide = $reedTide
        context.coordinator.mossShowBar = $mossShowBar
    }

    static func dismantleUIView(_ uiView: WKWebView, coordinator: GlenWebCull) {
        coordinator.unbind()
    }
}

private final class GlenWebCull: NSObject, WKNavigationDelegate {
    var reedTide: Binding<Double>
    var mossShowBar: Binding<Bool>
    private weak var webView: WKWebView?
    private let mossKeyClamp = MossReedKeyClamp()

    init(reedTide: Binding<Double>, mossShowBar: Binding<Bool>) {
        self.reedTide = reedTide
        self.mossShowBar = mossShowBar
        super.init()
    }

    func bind(webView: WKWebView) {
        unbind()
        self.webView = webView
        webView.navigationDelegate = self
        mossKeyClamp.reedAttach(webView: webView)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: [.new], context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: [.new], context: nil)
    }

    func unbind() {
        mossKeyClamp.reedDetach()
        guard let w = webView else { return }
        webView = nil
        w.navigationDelegate = nil
        w.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        w.removeObserver(self, forKeyPath: #keyPath(WKWebView.isLoading))
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let o = object as? WKWebView, o === webView else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        let w = o
        DispatchQueue.main.async {
            self.reedTide.wrappedValue = w.estimatedProgress
            let bar = w.isLoading || (w.estimatedProgress > 0 && w.estimatedProgress < 0.995)
            self.mossShowBar.wrappedValue = bar
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.reedTide.wrappedValue = 1
            self.mossShowBar.wrappedValue = false
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            self.mossShowBar.wrappedValue = false
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            self.mossShowBar.wrappedValue = false
        }
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
        UIApplication.shared.open(url, options: [:]) { ok in
            if !ok {
                DispatchQueue.main.async {
                    JuniperFogHUD.oakBad("Please make sure the app is installed first.")
                }
            }
        }
    }
}
