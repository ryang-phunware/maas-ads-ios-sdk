//
//  NativeAdView.swift
//  Sample
//
//  Created on 8/17/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import Foundation
import PWAdvertising

// MARK: - NativeAdView
protocol NativeAdView {
    var nativeAd: PWAdsNativeAd! {get set}
    
    func add(to view: UIView, with delegate: PWAdsNativeAdViewDelegate)
}

extension NativeAdView where Self: UIView {
    func add(to view: UIView, with delegate: PWAdsNativeAdViewDelegate) {
        // remove all the subviews
        view.subviews.forEach({ $0.removeFromSuperview() })
        
        view.addSubview(self)
        self.frame = view.bounds
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10.0
        
        let maskLayer = PWAdsNativeAdView(frame: self.bounds)
        maskLayer.delegate = delegate
        maskLayer.nativeAd = self.nativeAd
        view.addSubview(maskLayer)
    }
    
    static func fromNib<T : UIView>(nibName: String) -> T {
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)![0] as! T
    }
}

// MARK: - NativeAdsView

protocol NativeAdsView {
    var nativeAds: [PWAdsNativeAd]! {get set}
    func add(to view: UIView, with delegate: PWAdsNativeAdViewDelegate)
}

extension NativeAdsView where Self: UIView {
    static func fromNib<T : UIView>(nibName: String) -> T {
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)![0] as! T
    }
}
