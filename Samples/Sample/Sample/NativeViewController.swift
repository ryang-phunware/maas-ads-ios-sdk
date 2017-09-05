//
//  NativeViewController.swift
//  Sample
//
//  Created on 8/15/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit
import PWAdvertising

enum NativeAdType: Int {
    case contentStream
    case newsFeed
    case appWall
    case contentWall
    case clean
    case threeUp
    case threeUpWithTwoAds
    case threeUpWithOneAd
    case singleIcon
    case multiIcon
    
    func name() -> String {
        switch self {
        case .contentStream:
            return "Content Stream"
        case .newsFeed:
            return "News Feed"
        case .appWall:
            return "App Wall"
        case .contentWall:
            return "Content Wall"
        case .clean:
            return "Clean"
        case .threeUp:
            return "3 Up"
        case .threeUpWithTwoAds:
            return "3 Up With 2 Ads"
        case .threeUpWithOneAd:
            return "3 Up With 1 Ad"
        case .singleIcon:
            return "Single Icon"
        case .multiIcon:
            return "Multi Icon"
        }
    }

    static var count: Int {
        return NativeAdType.multiIcon.hashValue + 1
    }
}

struct NativeConstants {
    static let zoneId = "64477"
}

class NativeViewController: UIViewController {

    // MARK: - Properties
    var request = PWAdsRequest(zoneID: NativeConstants.zoneId)!
    let nativeAdLoader = PWAdsNativeAdLoader()
    
    // MARK: - IBOutlets
    @IBOutlet weak var nativeAdView: UIView!
    @IBOutlet weak var nativeAdTypePicker: UIPickerView!
    
    // MARK: - IBActions
    @IBAction func load(_ sender: UIButton) {
        if let nativeAdType = NativeAdType(rawValue: nativeAdTypePicker.selectedRow(inComponent: 0)) {
            switch nativeAdType {
            case .threeUp, .multiIcon:
                request.numberOfAds = 3
            case .threeUpWithTwoAds:
                request.numberOfAds = 2
            default:
                // numberOfAds' defualt value is 1
                request.numberOfAds = 1
            }
        }
        request.testMode = true
        print("Zone Id: \(request.zoneID!)\nTest mode is \(request.testMode)\n")
        nativeAdLoader.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nativeAdTypePicker.delegate = self
        nativeAdLoader.delegate = self
    }
}

extension NativeViewController: PWAdsNativeAdLoaderDelegate {
    func nativeAdLoader(_ loader: PWAdsNativeAdLoader!, didFailWithError error: Error!) {
        print("interstitial didFailWithError\n")
        if let error = error {
            print("\(error)\n")
        }
    }
    
    func nativeAdLoaderDidLoadAds(_ nativeAds: [Any]!) {
        guard let nativeAds = nativeAds as? [PWAdsNativeAd], !nativeAds.isEmpty else {
            return
        }
        
        let nativeAd = nativeAds.first
        
        if let selectedType = NativeAdType(rawValue: nativeAdTypePicker.selectedRow(inComponent: 0)) {
            
            switch selectedType {
            case .contentStream:
                let view = ContentStreamView.fromNib(nibName: "ContentStream") as! ContentStreamView
                view.nativeAd = nativeAd
                view.add(to: self.nativeAdView, with: self)
            case .newsFeed, .appWall:
                let view = NewsFeedView.fromNib(nibName: "NewsFeed") as! NewsFeedView
                view.nativeAd = nativeAd
                view.add(to: self.nativeAdView, with: self)
            case .contentWall:
                let view = ContentWall.fromNib(nibName: "ContentWall") as! ContentWall
                view.nativeAd = nativeAd
                view.add(to: self.nativeAdView, with: self)
            case .clean:
                let view = CleanView.fromNib(nibName: "Clean") as! CleanView
                view.nativeAd = nativeAd
                view.add(to: self.nativeAdView, with: self)
            case .singleIcon, .multiIcon:
                let view = IconsView.fromNib(nibName: "Icons") as! IconsView
                view.nativeAds = nativeAds
                view.add(to: self.nativeAdView, with: self)
            case .threeUp, .threeUpWithOneAd, .threeUpWithTwoAds:
                let view = ThreeUp.fromNib(nibName: "ThreeUp") as! ThreeUp
                view.nativeAds = nativeAds
                view.add(to: self.nativeAdView, with: self)
            }
        }
    }
}

extension NativeViewController: PWAdsNativeAdViewDelegate {
    func nativeAdViewDidDismissModal(_ nativeAdView: PWAdsNativeAdView!) {
        print("nativeAdViewDidDismissModal\n")
    }
    
    func nativeAdViewDidPresentModal(_ nativeAdView: PWAdsNativeAdView!) {
        print("nativeAdViewDidPresentModal\n")
    }
    
    func nativeAdViewWillPresentModal(_ nativeAdView: PWAdsNativeAdView!) {
        print("nativeAdViewWillPresentModal\n")
    }
    
    func nativeAdViewWillDissmissModal(_ nativeAdView: PWAdsNativeAdView!) {
        print("nativeAdViewWillDissmissModal\n")
    }
}

extension NativeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NativeAdType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let NativeAdType = NativeAdType(rawValue: row) else {
            return nil
        }
        return NativeAdType.name()
    }
}



