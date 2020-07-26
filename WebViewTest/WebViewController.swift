//
//  WebViewController.swift
//  WebViewTest
//
//  Created by Jun Harada on 2020/07/19.
//  Copyright © 2020 Jun Harada. All rights reserved.
//

import Foundation

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let path: String = Bundle.main.path(forResource: "quill_practice", ofType: "html") else {return}
        let myURL = URL(fileURLWithPath: path, isDirectory: false)
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
}
