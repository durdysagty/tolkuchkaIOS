//
//  SVGViewController.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 17.05.2023.
//

import UIKit
import WebKit
import SwiftUI

struct SVGView: UIViewRepresentable {
    let url: String
    
    init(url: String) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
//        let frame: CGRect = CGRect(x: 100,y: 100 , width: 30, height:30)
        let webConfiguration = WKWebViewConfiguration()
        let  webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        let webView: WKWebView = WKWebView(frame: CGRect(x: 100,y: 100 , width: 30, height:30))
//        webView.frame.size.height = 30
//        webView.scrollView.contentSize.height = 30
//        print(webView.frame)
        let request = URLRequest(url: URL(string: url)!)
        webView.load(request)
//        webView.sizeToFit()
//        webView.sizeThatFits(frame.size)
//        webView.scrollView.sizeToFit()
//        webView.scrollView.sizeThatFits(frame.size)
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
//        webView.frame.size.height = 30
//        webView.scrollView.contentSize.height = 30
//        let request = URLRequest(url: URL(string: url)!)
//        webView.load(request)
//        webView.frame = CGRect(x: 0,y: 0 , width: 30, height:30)
    }
    
    
}

//struct SVGView: UIViewControllerRepresentable {
//    let url: String
//
//    init(url: String) {
//        self.url = url
//    }
//
//    typealias UIViewControllerType = SVGViewController
//
//    func makeUIViewController(context: Context) -> SVGViewController {
//        let svgViewController = SVGViewController(url: url)
//        return svgViewController
//    }
//
//    func updateUIViewController(_ uiViewController: SVGViewController, context: Context) {
//
//    }
//
//
//}
//
//class SVGViewController: UIViewController, WKUIDelegate {
//    var webView: WKWebView!
//    let url: String
//
//    init(url: String) {
//        self.url = url
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 30, height: 30)), configuration: webConfiguration)
//        webView.uiDelegate = self
//        //        let contentSize: CGSize = webView.scrollView.contentSize;
//        //        let viewSize: CGSize = self.view.bounds.size;
//        //        print(webView.scrollView.contentSize)
//        //        print(self.view.bounds.size)
//        //
//        //        let rw: CGFloat = viewSize.width / contentSize.width;
//        //
//        //        webView.scrollView.minimumZoomScale = rw;
//        //        webView.scrollView.maximumZoomScale = rw;
//        //        webView.scrollView.zoomScale = rw;
////        webView.frame = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 30, height: 30))
//        view = webView
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //        let webView = WKWebView(frame: view.bounds)
//        let request = URLRequest(url: URL(string: url)!)
//        webView.load(request)
//
//        //        view.addSubview(webView)
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        self.webView.frame   = CGRect(x: 0, y:0, width: 30, height: 30)
//    }
//}
