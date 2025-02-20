//
//  WebViewController.swift
//  Runner
//
//  Created by Harsh on 20/02/25.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView = WKWebView(frame: .zero)
    var urlString : String!
    
    init(
        urlString: String
    ) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
    }
    
    
    private func configureWebView(){
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: self.view.frame, configuration: webConfiguration)
        webView.navigationDelegate = self
        
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // Match parent's size
        self.view.clipsToBounds = true
        
        self.view.addSubview(webView)
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
    }
}
