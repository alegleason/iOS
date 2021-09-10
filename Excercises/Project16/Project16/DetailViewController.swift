//
//  DetailViewController.swift
//  Project16
//
//  Created by Alejandro Gleason on 10/09/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var wikiUrl: URL?
    
    override func loadView() {
        webView = WKWebView()
        // Delegate the navigation to the webView
        webView.navigationDelegate = self
        // Assign current view to web view
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load the associated website
        guard let url = wikiUrl else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
