//
//  VideoViewController.swift
//  Sample
//
//  Created on 8/14/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit
import PWAdvertising

struct VideoInterstitialConstants {
    static let zoneId = "75395"
    static let userId = "1234"
}

class VideoViewController: UIViewController {

    var request = PWAdsRequest(zoneID: VideoInterstitialConstants.zoneId)!
    var videoInterstitial = PWAdsVideoInterstitial()
    
    @IBAction func load(_ sender: UIButton) {
        request.userID = VideoInterstitialConstants.userId
        request.testMode = true
        print("Zone Id: \(request.zoneID!) \nRV User: \(request.userID!) \nTest Mode: \(request.testMode) \n")
        videoInterstitial.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoInterstitial.delegate = self
    }
}

extension VideoViewController: PWAdsVideoInterstitialDelegate {
    func videoInterstitialDidLoadAd(_ videoInterstitial: PWAdsVideoInterstitial!) {
        print("videoInterstitialDidLoadAd\n")
    }
    
    func videoInterstitial(_ videoInterstitial: PWAdsVideoInterstitial!, didFailError error: Error!) {
        print("rewardedVideo didFailError:\n")
        if let error = error {
            print("\(error)\n")
        }
    }
    
    func videoInterstitialDidDismissModal(_ videoInterstitial: PWAdsVideoInterstitial!) {
        print("videoInterstitialDidDismissModal\n")
    }
    
    func videoInterstitialDidPresentModal(_ videoInterstitial: PWAdsVideoInterstitial!) {
        print("videoInterstitialDidPresentModal")
    }
    
    func videoInterstitialWillDismissModal(_ videoInterstitial: PWAdsVideoInterstitial!) {
        print("videoInterstitialWillDismissModal\n")
    }
    
    func videoInterstitialWillLeaveApplication(_ videoInterstitial: PWAdsVideoInterstitial!) {
        print("videoInterstitialWillLeaveApplication\n")
    }
    
    func videoInterstitialDidFinishedPreCaching(_ videoInterstitial: PWAdsVideoInterstitial!) {
        print("videoInterstitialDidFinishedPreCaching\n")
        videoInterstitial.present(from: self)
    }
}

