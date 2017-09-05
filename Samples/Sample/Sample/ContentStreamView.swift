//
//  ContentStreamView.swift
//  Sample
//
//  Created on 8/17/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit
import PWAdvertising
import Cosmos

class ContentStreamView: UIView, NativeAdView {
    
    var nativeAd: PWAdsNativeAd! {
        didSet {
            setup()
        }
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var sponsoredLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    func setup() {
        title.text = nativeAd.adTitle
        subtitle.text = nativeAd.adText
        button.titleLabel?.text = nativeAd.adCTA
        ratingView.rating = nativeAd.adRating as! Double
        sponsoredLabel.text = "SPONSORED"
        webView.loadHTMLString("<html><style>img{max-width: 100%;max-height: 100vh;height: auto;}</style>\(nativeAd.adHTML!)</html>", baseURL: nil)
        loadIcon(for: iconImageView, with: nativeAd)
    }
    
    func loadIcon(for imageView: UIImageView, with nativeAd: PWAdsNativeAd) {
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            if let urlString = nativeAd.adIconURL, let url = URL(string: urlString) {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}
