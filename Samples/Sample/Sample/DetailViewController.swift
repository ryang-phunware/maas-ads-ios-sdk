//
//  DetailViewController.swift
//  Sample
//
//  Created on 8/10/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit

struct Storyboard {
    static let bannerStoryboard = "Banner"
}

class DetailViewController: UIViewController {
    
    var adType: AdType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = adType?.description()
        
        if let _ = adType {
            setup()
        }
    }
    
    func setup() {
        let storyboard = UIStoryboard.init(name: adType.description(), bundle: nil)
        let childVC = storyboard.instantiateViewController(withIdentifier: adType.description())
        
        self.addChildViewController(childVC)
        self.view.addSubview(childVC.view)
        
        childVC.view.frame = self.view.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
