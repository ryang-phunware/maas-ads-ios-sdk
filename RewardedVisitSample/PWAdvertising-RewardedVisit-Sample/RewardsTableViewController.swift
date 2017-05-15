//
//  RewardsTableViewController.swift
//  PWAdvertising
//
//  Created on 3/9/17.
//  Copyright © 2017 Phunware, Inc. All rights reserved.
//

import UIKit

class RewardsTableViewController: UITableViewController {
    
    @IBOutlet weak var refresh: UIRefreshControl!
    
    // MARK: Constants
    
    private struct Storyboard {
        static let RewardTableViewCellIdentifier = "Reward Cell"
        static let segueIdentifier = "Reward"
    }
    
    // MARK: Model
    
    var messages: [PWMEZoneMessage]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var message: PWMEZoneMessage? = nil
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshMessages(refresh)
    }
    
    @IBAction func refreshMessages(_ sender: UIRefreshControl) {
        if let msgs = PWEngagement.messages() as? [PWMEZoneMessage] {
            messages = msgs
        }
        refresh.endRefreshing()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.RewardTableViewCellIdentifier, for: indexPath)
        let message = messages?[indexPath.row]
        cell.textLabel?.text = message?.alertTitle
        cell.detailTextLabel?.text = message?.alertBody
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.segueIdentifier, let rewardVC = segue.destination as? RewardViewController {
            if let msg = messages?[(tableView.indexPathForSelectedRow?.row)!] {
                rewardVC.message = msg
            } else if let msg = self.message {
                rewardVC.message = msg
            }
        }
    }
}
