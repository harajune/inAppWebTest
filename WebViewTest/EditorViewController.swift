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
import PinLayout

class EditorViewController: UIViewController, WKUIDelegate {
    private let webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        return view
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Save", for: .normal)
        return button
    }()
        
    
    override func loadView() {
        view = UIView()

        view.backgroundColor = .white
        
        webView.uiDelegate = self
        saveButton.addTarget(self, action: #selector(self.saveAction(_:)), for: .touchUpInside)

        view.addSubview(webView)
        view.addSubview(saveButton)

    }
    
    @objc func saveAction(_ sender: UIButton!) {
        NSLog("pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let path = Bundle.main.path(forResource: "quill_practice", ofType: "html") else {return}

        let myURL = URL(fileURLWithPath: path, isDirectory: false)
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
    
    override func viewWillLayoutSubviews() {
        webView.pin
            .top(view.pin.safeArea)
            .left(view.pin.safeArea)
            .right(view.pin.safeArea)
            .height(500.0)
        
        saveButton.pin
//            .after(of: webView)
            .height(16.0)
            .width(100.0)
            .center()
    }
    
    
}
