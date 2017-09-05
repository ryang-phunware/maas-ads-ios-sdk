//
//  MasterViewController.swift
//  Sample
//
//  Created on 8/10/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit

enum AdType: Int {
    case banner
    case interstitial
    case video
    case rewardedVideo
    case native
    case landingPage
    
    func description() -> String {
        switch self {
        case .banner:
            return "Banner"
        case .interstitial:
            return "Interstitial"
        case .video:
            return "Video"
        case .rewardedVideo:
            return "Rewarded Video"
        case .native:
            return "Native"
        case .landingPage:
            return "Landing Page"
        }
    }
}

class MasterViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController,
            segue.identifier == "Detail",
            let selectedRow = tableView.indexPathForSelectedRow?.row,
            let selectedType = AdType(rawValue: selectedRow) {
            detailVC.adType = selectedType
        }
    }
}

extension MasterViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let type = AdType(rawValue: indexPath.row)!
        cell.textLabel?.text = type.description()
        
        return cell
    }
}
