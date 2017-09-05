//
//  NewsFeedView.swift
//  Sample
//
//  Created on 8/17/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit
import Cosmos
import PWAdvertising

class NewsFeedView: UIView {
    
    var nativeAd: PWAdsNativeAd! {
        didSet {
            setup()
        }
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var sponsoredLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    func setup() {
        title.text = nativeAd.adTitle
        subtitle.text = nativeAd.adText
        button.titleLabel?.text = nativeAd.adCTA
        ratingView.rating = nativeAd.adRating as! Double
        sponsoredLabel.text = "SPONSORED"
        
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

extension NewsFeedView: NativeAdView {
    func add(to view: UIView, with delegate: PWAdsNativeAdViewDelegate) {
        view.subviews.forEach({ $0.removeFromSuperview() })
        
        view.addSubview(self)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 8.0).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        
        let maskLayer = PWAdsNativeAdView(frame: self.bounds)
        maskLayer.delegate = delegate
        maskLayer.nativeAd = self.nativeAd
        view.addSubview(maskLayer)
    }
}
