//
//  WebViewController.swift
//  Project4
//
//  Created by Alejandro Gleason on 03/03/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["gleason-portafolio.herokuapp.com", "fragrantica.es", "apple.com", "twitter.com"]
    var selectedWebsite: String = ""

    override func loadView() {
        webView = WKWebView()
        // Delegate the navigation to the webView
        webView.navigationDelegate = self
        // Assign current view to web view
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Instead of using a system icon, we are using a custom title
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        // .flexibleSpace cannot be tapped, just creates an space
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // Button to reload the wepage
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        // Button to navigate back and forth on the wepage
        let goBack = UIBarButtonItem(image: UIImage(named: "back")!.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: webView, action: #selector(webView.goBack))
        let goForth = UIBarButtonItem(image: UIImage(named: "forward")!.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: webView, action: #selector(webView.goBack))
        // Creates a new UI Progress View instance
        progressView = UIProgressView(progressViewStyle: .default)
        // Fit its content fully
        progressView.sizeToFit()
        // Wrap up the UIBarButtonItem so it can go into our toolbar
        let progressButton = UIBarButtonItem(customView: progressView)
        // Assign them to our toolbar (they are in the bottom)
        toolbarItems = [progressButton, spacer, goBack, goForth, refresh]
        // Show the toolbar
        navigationController?.isToolbarHidden = false
        // Add ourselves as observers for the webView
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        // Load passed site
        let url = URL(string: "https://" + selectedWebsite)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc
    func openTapped() {
        // .actionSheet allows prompting more information
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        // Though cancel is a defult option, we will overwrite it
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        // Remember this is used only on iPad and tells iOS where it should make the action sheet be anchored
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    // The UIAlertAction tells which is the object that was selected by the user
    func openPage(action: UIAlertAction) {
        // Safe unwrapping
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle)  else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    // Changing the title of our app to match the page
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    // We must implement the method observeValue
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // All we care about is that the keyPath paramter is set to estimatedProgress
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    // This method decides whether we allow or cancel navegation
    // @escaping is similar to Angular's await, which can be used later on
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // Here we are being given the closure decisionHandler to use, WE MUST USE IT!
        let url = navigationAction.request.url
        var found = false
        // unwrapping the optional value of the retrieved url, by host we mean website domain, as apple.com
        if let host = url?.host {
            for website in websites {
                // If it is safe to visit, since it is on allowed sites
                if host.contains(website) {
                    // Call the closure using allow
                    decisionHandler(.allow)
                    found = true
                    return
                }
            }
        }
        if !found {
            decisionHandler(.cancel)
            let ac = UIAlertController(title: "Forbidden website", message: "Entered website is not allowed", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            present(ac, animated: true)
        }
        
    }

}
