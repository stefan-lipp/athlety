//
//  AttachementView.swift
//  Athlety
//
//  Created by Stefan Cimander on 20.10.23.
//

import SwiftUI
import WebKit

struct AttachementView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
