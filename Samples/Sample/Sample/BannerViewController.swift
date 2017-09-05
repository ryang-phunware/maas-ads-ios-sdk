//
//  BannerViewController.swift
//  Sample
//
//  Created on 8/14/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit
import PWAdvertising

struct BannerConstants {
    static let iPhoneZoneId = "7268"
    static let iPadZoneId = "33755"
    static let mediumRectZoneId = "7270"
}

enum BannerType: String {
    case regular = "RegularBannerAd"
    case mediumRect = "MediumRectBannerAd"
    case animated = "AnimatedBannerAd"
}

enum AnimationType: Int {
    case random
    case threeDimensionalRotation
    case curlUp
    case curlDown
    case flipFromLeft
    case flipFromRight
    case none
    
    func name() -> String {
        switch self {
        case .none:
            return "None"
        case .random:
            return "Random"
        case .threeDimensionalRotation:
            return "3D Rotation"
        case .curlUp:
            return "Curl Up"
        case .curlDown:
            return "Curl Down"
        case .flipFromLeft:
            return "Flip From Left"
        case .flipFromRight:
            return "Flip From Right"
        }
    }
    
    static var count: Int {
        return AnimationType.none.hashValue + 1
    }
    
    func animation() -> PWAdsBannerAnimationTransition {
        switch self {
        case .none:
            return .transitionNone
        case .random:
            return .transitionRandom
        case .threeDimensionalRotation:
            return .transition3DRotation
        case .curlUp:
            return .transitionCurlUp
        case .curlDown:
            return .transitionCurlDown
        case .flipFromLeft:
            return .transitionFlipFromLeft
        case .flipFromRight:
            return .transitionFlipFromRight
        }
    }
}

class BannerViewController: UIViewController {
    
    // MARK: - Properties
    var zoneId: String!
    var request: PWAdsRequest!
    
    // MARK: - IBOutlets
    @IBOutlet weak var bannerView: PWAdsBannerView!
    @IBOutlet weak var animationTypePicker: UIPickerView!
    
    // MARK: - IBActions
    @IBAction func load(_ sender: UIButton) {
    
        if let animationTypePicker = animationTypePicker, let animationType = AnimationType(rawValue: animationTypePicker.selectedRow(inComponent: 0)) {
            bannerView.bannerAnimationTransition = animationType.animation()
        }
        request.testMode = true
        print("Zone Id: \(request.zoneID!)\nTest mode is \(request.testMode)\n")
        bannerView.load(request)
    }
    
    // MARK: - View Controller Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.delegate = self
        bannerView.loadAnimated = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let bannerType = BannerType(rawValue: self.restorationIdentifier!) {
            switch bannerType {
            case .regular, .animated:
                switch UIDevice.current.userInterfaceIdiom {
                case .pad:
                    zoneId = BannerConstants.iPadZoneId
                default:
                    zoneId = BannerConstants.iPhoneZoneId
                }
                
                if bannerType == .animated {
                    animationTypePicker.delegate = self
                }
            case .mediumRect:
                zoneId = BannerConstants.mediumRectZoneId
        }
            request = PWAdsRequest(zoneID: zoneId)
        }
    }
}

extension BannerViewController: PWAdsBannerViewDelegate {
    func bannerViewDidLoadAd(_ bannerView: PWAdsBannerView!) {
        print("bannerViewDidLoadAd\n")
    }
    
    func bannerView(_ bannerView: PWAdsBannerView!, didFailWithError error: Error!) {
        print("rewardedVideo didFailError:\n")
        if let error = error {
            print("\(error)\n")
        }
    }
    
    func bannerViewWillPresentModal(_ bannerView: PWAdsBannerView!) {
        print("bannerViewWillPresentModal\n")
    }
    
    func bannerViewDidPresentModal(_ bannerView: PWAdsBannerView!) {
        print("bannerViewDidPresentModal\n")
    }
    
    func bannerViewWillDissmissModal(_ bannerView: PWAdsBannerView!) {
        print("bannerViewWillDissmissModal\n")
    }
    
    func bannerViewDidDismissModal(_ bannerView: PWAdsBannerView!) {
        print("bannerViewDidDismissModal\n")
    }
    
    func shouldLeaveApplication(for bannerView: PWAdsBannerView!) -> Bool {
        print("shouldLeaveApplication\n")
        return true
    }
}

extension BannerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AnimationType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let animationType = AnimationType(rawValue: row) else {
            return nil
        }
        return animationType.name()
    }
}
