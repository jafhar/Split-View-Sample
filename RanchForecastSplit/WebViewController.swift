//
//  WebViewController.swift
//  RanchForecastSplit
//
//  Created by jafharsharief.b on 05/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa
import WebKit

class WebViewController: NSViewController {
    
    var webView: WKWebView {
        return view as! WKWebView
    }

    override func loadView() {
        let webView = WKWebView()
        view = webView
        view.frame.size = NSMakeSize(200.0, 100.0)
    }
    
    //MARK : load the web page with url
    func load(url: NSURL) {
        let request = NSURLRequest(url:url as URL)
        webView.load(request as URLRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
}
