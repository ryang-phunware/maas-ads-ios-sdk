//
//  ViewController.swift
//  PWAdsRewardedVisitSample
//
//  Created on 3/8/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit

let zoneId = "78393"
let userId = "123456"

class ViewController: UIViewController {
    
    var videoIsPreCached = false
    let adRequest = PWAdsRequest(zoneID: zoneId)
    var rewardedVideo = PWAdsRewardedVideo()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var logView: UITextView!

    // MARK: - IBActions
    
    @IBAction func loadButtonPressed(_ sender: UIButton) {
        adRequest?.userID = userId
        rewardedVideo.load(adRequest)
        
        logView.text = ""
        logView.insertText("Loading ad......\n")
    }
    
    @IBAction func play(_ sender: UIButton) {
        playButton.isEnabled = false
        rewardedVideo.present(from: self)
    }
    
    // MARK: - View Controller Lifecyles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rewardedVideo.delegate = self
        playButton.isEnabled = false
    }
}

extension ViewController: PWAdsRewardedVideoDelegate {
    func rewardedVideoDidLoadAd(_ rewardedVideo: PWAdsRewardedVideo!, withAdExtensionData adExtensionData: [AnyHashable : Any]!) {
        logView.insertText("Caching video......\n")
    }
    
    func rewardedVideoDidFinishedPreCaching(_ rewardedVideo: PWAdsRewardedVideo!, withAdExtensionData adExtensionData: [AnyHashable : Any]!) {
        videoIsPreCached = true
        logView.insertText("Ready to play!\n")
        playButton.isEnabled = true
    }
    
    func rewardedVideoWillDismissModal(_ rewardedVideo: PWAdsRewardedVideo!, withAdExtensionData adExtensionData: [AnyHashable : Any]!) {
    }
    
    func rewardedVideoDidEndPlaybackSuccessfully(_ rewardedVideo: PWAdsRewardedVideo!, withRVResponseObject customData: [AnyHashable : Any]!, andAdExtensionData adExtensionData: [AnyHashable : Any]!) {
        logView.insertText("RV Success!\n")
    }
}
