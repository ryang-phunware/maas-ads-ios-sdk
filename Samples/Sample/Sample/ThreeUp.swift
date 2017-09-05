//
//  ThreeUp.swift
//  Sample
//
//  Created on 8/18/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit
import PWAdvertising

class UpView: UIView {
    var nativeAd: PWAdsNativeAd! {
        didSet {
            setup()
        }
    }
    var adViewDelegate: PWAdsNativeAdViewDelegate!
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var cta: UILabel!
    
    func setup() {
        self.isHidden = false
        loadIcon(for: icon, with: nativeAd)
        title.text = nativeAd.adTitle
        subtitle.text = nativeAd.adText
        cta.text = nativeAd.adCTA
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

class ThreeUp: UIView {
    var nativeAds: [PWAdsNativeAd]! {
        didSet {
            setup()
        }
    }
    
    var adViewDelegate: PWAdsNativeAdViewDelegate!

    @IBOutlet weak var upView1: UpView!
    @IBOutlet weak var upView2: UpView!
    @IBOutlet weak var upView3: UpView!
    
    func setup() {
        switch nativeAds.count {
        case 1:
            upView1.nativeAd = nativeAds[0]
        case 2:
            upView1.nativeAd = nativeAds[0]
            upView2.nativeAd = nativeAds[1]
        case 3:
            upView1.nativeAd = nativeAds[0]
            upView2.nativeAd = nativeAds[1]
            upView3.nativeAd = nativeAds[2]
        default:
            upView1.nativeAd = nativeAds[0]
        }
    }
}

extension ThreeUp: NativeAdsView {
    func add(to view: UIView, with delegate: PWAdsNativeAdViewDelegate) {
        view.subviews.forEach({ $0.removeFromSuperview() })
        view.addSubview(self)
        
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10.0
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: upView1.bottomAnchor, constant: 2.0).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        adViewDelegate = delegate
    }
}
