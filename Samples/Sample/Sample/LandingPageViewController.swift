//
//  LandingPageViewController.swift
//  Sample
//
//  Created on 8/15/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit
import PWAdvertising

struct LandingPageConstants {
    static let iPhoneZoneId = "76663"
    static let iPadZoneId = "76663"
}

class LandingPageViewController: UIViewController {
    
    // MARK: - Properties
    var zoneId: String!
    var request = PWAdsRequest()
    var landingPage = PWAdsLandingPage()

    // MARK: - IBActions
    @IBAction func load(_ sender: UIButton) {
        request.testMode = true
        print("Zone Id: \(request.zoneID!)\nTest mode is \(request.testMode)\n")
        landingPage.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        landingPage.delegate = self
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            zoneId = LandingPageConstants.iPadZoneId
        default:
            zoneId = LandingPageConstants.iPhoneZoneId
        }
        request.zoneID = zoneId
    }
}

extension LandingPageViewController: PWAdsLandingPageDelegate {
    func landingPageDidLoadAd(_ landingPageAd: PWAdsLandingPage!) {
        print("landingPageDidLoadAd\n")
        landingPage.present(from: self)
    }
    
    func landingPageDidDismissModal(_ landingPageAd: PWAdsLandingPage!) {
        print("landingPageDidDismissModal\n")
    }
    
    func landingPageDidPresentModal(_ landingPageAd: PWAdsLandingPage!) {
        print("landingPageDidPresentModal\n")
    }
    
    func landingPageWillDismissModal(_ landingPageAd: PWAdsLandingPage!) {
        print("landingPageWillDismissModal\n")
    }
    
    func landingPage(_ landingPage: PWAdsLandingPage!, didFailWithError error: Error!) {
        print("landingPage didFailWithError\n")
        if let error = error {
            print("\(error)\n")
        }
    }
    
    func shouldLeaveApplicationForlandingPage(_ landingPage: PWAdsLandingPage!) -> Bool {
        print("shouldLeaveApplicationForlandingPage\n")
        return true
    }
}
