//
//  IconsView.swift
//  Sample
//
//  Created on 8/18/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit
import PWAdvertising

class IconsView: UIView {
    var nativeAds: [PWAdsNativeAd]! {
        didSet {
            setup()
        }
    }
    var adViewDelegate: PWAdsNativeAdViewDelegate!
    
    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var icon3: UIImageView!
    
    func setup() {
        if nativeAds.count == 1 {
            loadIcon(for: icon2, with: nativeAds.first!)

        } else if nativeAds.count == 3 {
            loadIcon(for: icon1, with: nativeAds[0])
            loadIcon(for: icon2, with: nativeAds[1])
            loadIcon(for: icon3, with: nativeAds[2])
        }
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
        
        let maskLayer = PWAdsNativeAdView(frame: imageView.bounds)
        maskLayer.delegate = adViewDelegate
        maskLayer.nativeAd = nativeAd
        imageView.addSubview(maskLayer)
    }
}

extension IconsView: NativeAdsView {
    func add(to view: UIView, with delegate: PWAdsNativeAdViewDelegate) {
        view.subviews.forEach({ $0.removeFromSuperview() })
        view.addSubview(self)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.icon1.bottomAnchor, constant: 8.0).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        adViewDelegate = delegate
    }
}
