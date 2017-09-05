//
//  ContentWall.swift
//  Sample
//
//  Created on 8/18/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit
import PWAdvertising

class ContentWall: UIView, NativeAdView {
    
    var nativeAd: PWAdsNativeAd! {
        didSet {
            setup()
        }
    }
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var sponsoredLabel: UILabel!
    
    func setup() {
        sponsoredLabel.text = "SPONSORED"
        webView.loadHTMLString("<html><style>img{max-width: 100%;max-height: 100vh;height: auto;}</style>\(nativeAd.adHTML!)</html>", baseURL: nil)
    }

}
