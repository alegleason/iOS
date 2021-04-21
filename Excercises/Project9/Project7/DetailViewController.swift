//
//  DetailViewController.swift
//  Project7
//
//  Created by Alejandro Gleason on 21/03/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    // This will hold the optional petition object
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
        p { font-size: 120%;
            padding: 10px; }
        h3 { text-align: center; }
        </style>
        </head>
        <body>
        <h3>\(detailItem.title)</h3>
        <p align="justify">\(detailItem.body)</p>
        </body>
        </html>
        """
        // baseURL param lets you point to a internal or external URL that contains resources such as pictures or stylesheet
        webView.loadHTMLString(html, baseURL: nil)
    }
    

}
