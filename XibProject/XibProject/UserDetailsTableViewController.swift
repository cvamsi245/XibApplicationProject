//
//  UserDetailsTableViewController.swift
//  XibProject
//
//  Created by vamsi on 31/07/24.
//

import UIKit

class UserDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailIdLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var companyDetails: UILabel!
    
    var userDetails: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = userDetails?.name
        userNameLabel.text = userDetails?.username
        emailIdLabel.text = userDetails?.email
        phoneLabel.text = userDetails?.phone
        websiteLabel.text = userDetails?.website
        companyDetails.text = """
                \(userDetails?.company?.name ?? "")
                \(userDetails?.company?.catchPhrase ?? "")
                \(userDetails?.company?.bs ?? "")
                """
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight
    }
    // MARK: - Table view data source


}
