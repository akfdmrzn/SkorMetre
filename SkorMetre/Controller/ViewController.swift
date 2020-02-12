//
//  ViewController.swift
//  SkorMetre
//
//  Created by Akif Demirezen on 25.12.2019.
//  Copyright © 2019 Akif Demirezen. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController {

    @IBOutlet weak var btnLeftMenu: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    var wkWebview = WKWebView()
    var leftMenuView : LeftMenuView?
    var alphaView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.btnLeftMenu.addTarget(self, action: #selector(showLeftMenu), for: .touchDown)
        self.wkWebview.frame = self.viewContainer.bounds
        self.viewContainer.addSubview(self.wkWebview)
        modalPresentationStyle = .fullScreen
        self.wkWebview.navigationDelegate = self
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle  = .light
        }
        self.wkWebview.load(URLRequest.init(url: URL.init(string:"https://skormetre.com/")!))
    }
}
extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
extension ViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
}
extension ViewController : LeftMenuSelectionDelegate{
    func removeLeftMenuView(vcType: Int) {
        
    }
    
    @objc func showLeftMenu(){
       self.alphaView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: (((UIApplication.getTopViewController()?.view.frame.size.width)!)), height: ((UIApplication.getTopViewController()?.view.frame.size.height)!)))
       self.alphaView?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
       self.leftMenuView = LeftMenuView.init(frame: CGRect.init(x: (((UIApplication.getTopViewController()?.view.frame.size.width)!)) * -1, y: 0, width: (((UIApplication.getTopViewController()?.view.frame.size.width)!)), height: ((UIApplication.getTopViewController()?.view.frame.size.height)!)))
        self.leftMenuView?.btnDismiss.addTarget(self, action: #selector(dissMissLeftMenuVoid), for: .touchDown)
        self.leftMenuView?.btnDismissView.addTarget(self, action: #selector(dissMissLeftMenuVoid), for: .touchDown)
        self.leftMenuView?.delegate = self
        UIApplication.getTopViewController()?.view.addSubview(self.alphaView!)
        UIApplication.getTopViewController()?.view.addSubview(self.leftMenuView!)
        UIView.animate(withDuration: 0.7, animations: {
            self.leftMenuView!.frame.origin.x = 0
         
        }) { (finished) in
        }
    }
    
    @IBAction func btnPressedLogin(_ sender: Any) {
        
    }
    @objc func dissMissLeftMenu(ended: @escaping () -> Void){
        if (self.leftMenuView != nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                self.alphaView?.removeFromSuperview()
            }
            UIView.animate(withDuration: 0.7, animations: {
                self.leftMenuView!.frame.origin.x = (((UIApplication.getTopViewController()?.view.frame.size.width)!)) * -1
                
            }) { (finished) in
                self.leftMenuView?.removeFromSuperview()
                ended()
            }
        }
    }
    
    @objc func dissMissLeftMenuVoid(){
        if (self.leftMenuView != nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                self.alphaView?.removeFromSuperview()
            }
            UIView.animate(withDuration: 0.7, animations: {
                self.leftMenuView!.frame.origin.x = (((UIApplication.getTopViewController()?.view.frame.size.width)!)) * -1
                
            }) { (finished) in
                self.leftMenuView?.removeFromSuperview()
            }
        }
    }

}
