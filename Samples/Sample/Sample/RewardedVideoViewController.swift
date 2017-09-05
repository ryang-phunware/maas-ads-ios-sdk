//
//  RewardedVideoViewController.swift
//  Sample
//
//  Created on 8/11/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit
import PWAdvertising

struct RewardedVideoConstants {
    static let zoneId = "78393"
    static let userId = "1234"
}

class RewardedVideoViewController: UIViewController {
    
    var request = PWAdsRequest(zoneID: RewardedVideoConstants.zoneId)!
    var rewardedVideo = PWAdsRewardedVideo()
    
    
    @IBAction func load(_ sender: UIButton) {
        request.userID = RewardedVideoConstants.userId
        request.customData = ["rewardType": "fuel",
                              "levelKind": "amateur",
                              "points": "13232321123124432430",
                              "userName": "userName1"]
        
        print("Zone Id: \(request.zoneID!) \nRV User: \(request.userID!) \nTest Mode: \(request.testMode) \n")
        
        rewardedVideo.load(request)
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        rewardedVideo.delegate = self
    }
    
    func showOfferWall(_ remainingViews: Int) {
        let offerAlert = UIAlertController(title: "Phunware", message: "You have \(remainingViews) remaining views", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            self.rewardedVideo.present(from: self)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        offerAlert.addAction(ok)
        offerAlert.addAction(cancel)
        self.present(offerAlert, animated: true, completion: nil)
    }
}

extension RewardedVideoViewController: PWAdsRewardedVideoDelegate {
    func rewardedVideoDidFinishedPreCaching(_ rewardedVideo: PWAdsRewardedVideo!, withAdExtensionData adExtensionData: [AnyHashable : Any]!) {
        print("rewardedVideoDidFinishedPreCaching\n")
        showOfferWall(1)
    }
    
    func rewardedVideoDidLoadAd(_ rewardedVideo: PWAdsRewardedVideo!, withAdExtensionData adExtensionData: [AnyHashable : Any]!) {
        print("rewardedVideoDidLoadAd\n")
    }
    
    func rewardedVideo(_ rewardedVideo: PWAdsRewardedVideo!, didFailError error: Error!, withAdExtensionData adExtensionData: [AnyHashable : Any]!) {
        print("rewardedVideo didFailError:\n")
        if let error = error {
            print("\(error)\n")
        }
    }
    
    func rewardedVideoWillLeaveApplication(_ rewardedVideo: PWAdsRewardedVideo!) {
        print("rewardedVideoWillLeaveApplication\n")
    }
    
    func rewardedVideoDidDismissModal(_ rewardedVideo: PWAdsRewardedVideo!, withAdExtensionData adExtensionData: [AnyHashable : Any]!) {
         print("rewardedVideoDidDismissModal\n")
    }
    
    func rewardedVideoDidPresentModal(_ rewardedVideo: PWAdsRewardedVideo!, withAdExtensionData adExtensionData: [AnyHashable : Any]!) {
        print("rewardedVideoDidPresentModal\n")
    }
    
    func rewardedVideoWillDismissModal(_ rewardedVideo: PWAdsRewardedVideo!, withAdExtensionData adExtensionData: [AnyHashable : Any]!) {
        print("rewardedVideoWillDismissModal\n")
    }
    
    func rewardedVideoDidEndPlaybackSuccessfully(_ rewardedVideo: PWAdsRewardedVideo!, withRVResponseObject customData: [AnyHashable : Any]!, andAdExtensionData adExtensionData: [AnyHashable : Any]!) {
        print("rewardedVideoDidEndPlaybackSuccessfully\n")
    }
}
