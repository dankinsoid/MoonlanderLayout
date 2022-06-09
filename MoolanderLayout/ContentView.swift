//
//  ContentView.swift
//  MoolanderLayout
//
//  Created by Данил Войдилов on 24.08.2021.
//

import SwiftUI
import Cocoa
import WebKit

struct ContentView: View {
    let layer: Int
    
    var body: some View {
        Image(nsImage: NSImage(contentsOf: Bundle.main.url(forResource: "layer\(layer)", withExtension: "png")!)!)
            .resizable()
            .frame(width: 900, height: 400, alignment: .center)
						.cornerRadius(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(layer: 1)
    }
}

struct WebView: NSViewControllerRepresentable {
    
    let url: URL
    
    func makeNSViewController(context: Context) -> WebViewController {
        WebViewController()
    }
    
    func updateNSViewController(_ nsViewController: WebViewController, context: Context) {
        nsViewController.load(url: url)
    }
}

class WebViewController: NSViewController, WKUIDelegate {
    var webView: WKWebView!
    
    override func loadView() {
//        let script = """
//                var observer = new MutationObserver(function(mutations) {
//                mutations.forEach(function(mutation) {
//                console.log('mutation.type = ' + mutation.type);
//                if (document.classList.contains('moonlander')) {
//                var content = document.getElementsByClassName("moonlander")[0].innerHTML;
//                document.getElementsByTagName('body')[0].innerHTML = content;
//                }
//                });
//                });
//                """
//        let userScript = WKUserScript(source: script, injectionTime: .atDocumentStart, forMainFrameOnly: true)
//
//        let contentController = WKUserContentController()
//        contentController.addUserScript(userScript)
//
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        webView = WKWebView(frame: CGRect(), configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    func load(url: URL) {
        _ = view
        webView.load(URLRequest(url: url))
    }
}
