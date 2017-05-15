//
//  RewardViewController.swift
//  PWAdvertising
//
//  Created on 4/17/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit

class RewardViewController: UIViewController {

    var message: PWMEZoneMessage? = nil
    let queue = DispatchQueue.global(qos: .userInteractive)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var rewardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let msg = message else {
            return
        }
        
        titleLabel.text = msg.alertTitle
        bodyLabel.text = msg.alertBody
        
        if let imageURLString = msg.metaData["imageURL"] as? String {
            queue.async {
                if let url = URL(string: imageURLString), let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.rewardImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}
