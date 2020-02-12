//
//  BackBaseViewController.swift
//  SkorMetre
//
//  Created by Akif Demirezen on 15.01.2020.
//  Copyright © 2020 Akif Demirezen. All rights reserved.
//

import UIKit
import WebKit


class BackBaseViewController: UIViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    var wkWebview = WKWebView()
    var popupWebView: WKWebView?
    var urlLink : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.wkWebview.frame = self.viewContainer.bounds
        self.wkWebview.frame.size.width = self.view.frame.size.width - 5.0
        self.wkWebview.scrollView.showsVerticalScrollIndicator = false
        self.viewContainer.addSubview(self.wkWebview)
        modalPresentationStyle = .fullScreen
        self.wkWebview.navigationDelegate = self
        self.wkWebview.uiDelegate = self
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle  = .light
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.wkWebview.load(URLRequest.init(url: URL.init(string: self.urlLink)!))
    }
}
extension BackBaseViewController : WKNavigationDelegate,WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        popupWebView = WKWebView(frame: self.viewContainer.frame, configuration: configuration)
        popupWebView!.navigationDelegate = self
        popupWebView!.uiDelegate = self
        view.addSubview(popupWebView!)
        return popupWebView!
    }
    func webViewDidClose(_ webView: WKWebView) {
        webView.removeFromSuperview()
        popupWebView = nil
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideIndicator(tag : "link")
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showIndicator(tag : "link")
    }
}
