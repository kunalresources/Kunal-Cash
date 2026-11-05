import UIKit
import WebKit

enum MossReedWebKit {
    
    static func reedPrepareH5Scroll(_ webView: WKWebView) {
        let scroll = webView.scrollView
        scroll.contentInsetAdjustmentBehavior = .never
        if #available(iOS 13.0, *) {
            scroll.automaticallyAdjustsScrollIndicatorInsets = false
        }
        reedClampScrollInsets(webView)
    }

    static func reedClampScrollInsets(_ webView: WKWebView) {
        let scroll = webView.scrollView
        scroll.contentInset = .zero
        scroll.scrollIndicatorInsets = .zero
        if #available(iOS 11.0, *) {
            scroll.verticalScrollIndicatorInsets = .zero
            scroll.horizontalScrollIndicatorInsets = .zero
        }
    }
}

final class MossReedKeyClamp {
    private var reedTokens: [NSObjectProtocol] = []
    private weak var mossWebView: WKWebView?

    func reedAttach(webView: WKWebView) {
        reedDetach()
        mossWebView = webView
        MossReedWebKit.reedPrepareH5Scroll(webView)
        let center = NotificationCenter.default
        let names: [Notification.Name] = [
            UIResponder.keyboardWillShowNotification,
            UIResponder.keyboardDidShowNotification,
            UIResponder.keyboardWillHideNotification,
            UIResponder.keyboardDidHideNotification,
            UIResponder.keyboardWillChangeFrameNotification
        ]
        for name in names {
            let token = center.addObserver(forName: name, object: nil, queue: .main) { [weak self] _ in
                guard let w = self?.mossWebView else { return }
                MossReedWebKit.reedClampScrollInsets(w)
            }
            reedTokens.append(token)
        }
    }

    func reedDetach() {
        reedTokens.forEach { NotificationCenter.default.removeObserver($0) }
        reedTokens.removeAll()
        mossWebView = nil
    }
}
