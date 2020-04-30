//
//  WebViewController.swift
//  Wan
//
//  Created by Yang on 2020/4/23.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var webUrl: String?
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "浏览"
        
        initWebView()
        initUI()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let view = object as? WKWebView, view == self.webView && keyPath == "estimatedProgress" else { return }
        guard let changed = change, let progress = changed[.newKey] as? Double else { return }
        
        self.progressBar.setProgress(Float(progress), animated: true)
    }
    
    private func initWebView() {
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: [.new, .old], context: nil)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    private func initUI() {
        guard let url = webUrl, let uri = URL(string: url) else { return }
        webView.load(URLRequest(url: uri))
    }
}

//MARK: - NavigationDelegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.progressBar.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.progressBar.isHidden = true
        self.progressBar.setProgress(0, animated: false)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        decisionHandler(.allow)
    }
}

//MARK: - UIDelegate
extension WebViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "提示信息", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel) { action in
            completionHandler()
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "提示信息", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { action in
            completionHandler(false)
        }
        let okAction = UIAlertAction(title: "确定", style: .cancel) { action in
            completionHandler(true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let frame = navigationAction.targetFrame, !frame.isMainFrame {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
}

extension WebViewController: UINavigationBarDelegate {
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if self.webView.canGoBack {
            self.webView.goBack()
            
            return false
        }
        return true
    }
}
