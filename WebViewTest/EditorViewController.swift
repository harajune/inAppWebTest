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

class EditorViewController: UIViewController, WKNavigationDelegate {
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
        
        webView.navigationDelegate = self
        webView.addInputAccessoryView(toolbar: getToolBar(height: 44))
        saveButton.addTarget(self, action: #selector(self.saveAction(_:)), for: .touchUpInside)

        view.addSubview(webView)
        view.addSubview(saveButton)

    }
    
    func getToolBar(height: Int) -> UIToolbar? {
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 50, width: 320, height: height)
        toolBar.barStyle = .black
        toolBar.tintColor = .white
        toolBar.barTintColor = UIColor.blue

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(onToolbarDoneClick(sender:)) )
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil )

        toolBar.setItems([flexibleSpaceItem, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        toolBar.sizeToFit()
        return toolBar
    }
    @objc func onToolbarDoneClick(sender: UIBarButtonItem) {
        webView.resignFirstResponder()
    }
    
    @objc func saveAction(_ sender: UIButton!) {
        let script = "JSON.stringify(window.memoro.editor.getContents());"
        webView.evaluateJavaScript(script) { (object, error) -> Void in
            if let jsonString = object as? NSMutableString {
                NSLog(jsonString as String)
            }
        }
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
