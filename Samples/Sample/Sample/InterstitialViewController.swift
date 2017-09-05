//
//  InterstitialViewController.swift
//  Sample
//
//  Created on 8/15/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit
import PWAdvertising

struct InterstitialConstants {
    static let iPhoneZoneId = "7271"
    static let iPadZoneId = "33761"
}

class InterstitialViewController: UIViewController {
    
    // MARK: - Properties
    var zoneId: String!
    var request = PWAdsRequest()
    var interstitial = PWAdsInterstitial()
    
    // MARK: - IBActions
    @IBAction func load(_ sender: UIButton) {
        request.testMode = true
        print("Zone Id: \(request.zoneID!)\nTest mode is \(request.testMode)\n")
        interstitial.load(request)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial.delegate = self
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            zoneId = InterstitialConstants.iPadZoneId
        default:
            zoneId = InterstitialConstants.iPhoneZoneId
        }
        request.zoneID = zoneId
    }
}

extension InterstitialViewController: PWAdsInterstitialDelegate {
    func interstitialDidLoadAd(_ interstitialAd: PWAdsInterstitial!) {
        print("interstitialDidLoadAd\n")
        interstitialAd.present(from: self)
    }
    
    func interstitialDidDismissModal(_ interstitialAd: PWAdsInterstitial!) {
        print("interstitialDidDismissModal\n")
    }
    
    func interstitialDidPresentModal(_ interstitialAd: PWAdsInterstitial!) {
        print("interstitialDidPresentModal\n")
    }
    
    func interstitialWillDismissModal(_ interstitialAd: PWAdsInterstitial!) {
        print("interstitialWillDismissModal\n")
    }
    
    func interstitial(_ interstitial: PWAdsInterstitial!, didFailWithError error: Error!) {
        print("interstitial didFailWithError\n")
        if let error = error {
            print("\(error)\n")
        }
    }
    
    func shouldLeaveApplication(for interstitial: PWAdsInterstitial!) -> Bool {
        print("shouldLeaveApplication\n")
        return true
    }
}
