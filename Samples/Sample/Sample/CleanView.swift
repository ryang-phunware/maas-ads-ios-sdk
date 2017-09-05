//
//  CleanView.swift
//  Sample
//
//  Created on 8/18/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit
import PWAdvertising

class CleanView: UIView {
    var nativeAd: PWAdsNativeAd! {
        didSet {
            setup()
        }
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cbaLabel: UILabel!
    
    func setup() {
        title.text = nativeAd.adTitle
        subtitle.text = nativeAd.adText
        cbaLabel.text = nativeAd.adCTA
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            if let url = URL(string: self.nativeAd.adIconURL) {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    DispatchQueue.main.async {
                        self.iconImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}

extension CleanView: NativeAdView {
    func add(to view: UIView, with delegate: PWAdsNativeAdViewDelegate) {
        view.subviews.forEach({ $0.removeFromSuperview() })
        view.addSubview(self)
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.5
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.cbaLabel.bottomAnchor, constant: 8.0).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize.zero
        
        let maskLayer = PWAdsNativeAdView(frame: self.bounds)
        maskLayer.delegate = delegate
        maskLayer.nativeAd = self.nativeAd
        view.addSubview(maskLayer)
    }
}
