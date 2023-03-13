//
//  TeamMemberDetailsViewController.swift
//  teams-time
//
//  Created by Аня Беликова on 11.03.2023.
//

import UIKit

class TeamMemberDetailViewController: UIViewController {

    @IBOutlet var teamMemberImageView: UIImageView! {
        didSet {
            teamMemberImageView.layer.cornerRadius = teamMemberImageView.frame.height / 2
        }
    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var currentTimeMember: UILabel!
    
    var currentTeamMember = TeamMember(name: "User", timezone: .dublin, contact: nil)
    var currentStatus = Status.self

    @IBOutlet var contactButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        contactButton.layer.cornerRadius = 10

    }
    
    @IBAction func contactButtonTapped() {
        statusLabel.text == Status.active.rawValue
            ? showContactAlert(
                withtitle: "Please, contact with employee by telegram",
                andmessage: "Nickname is \(currentTeamMember.contact ?? "")"
            )
            : showContactAlert(
                withtitle: "Ooops! Employee is resting after work.",
                andmessage: "You can`t contact with employee...🤷🏼"
            )
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let teamListVC = segue.destination as? TeamListViewController else { return }
        
        teamListVC.nameLabel = nameLabel
    }
    
    
    @IBAction func unwindTo(_ unwindSegue: UIStoryboardSegue) {
        guard let teamListVC = unwindSegue.source as? TeamListViewController else { return }
        
        currentTeamMember.name = teamListVC.nameLabel.text!
        currentTeamMember.jobTitle = teamListVC.positionLabel.text!
        currentTeamMember.timezone = Timezone(rawValue: teamListVC.selectedTimeZone)!
        UIImage(named: teamListVC.member.name)
    }

}

    extension TeamMemberDetailViewController {
        private func showContactAlert(withtitle title: String, andmessage message: String) {
            let contactAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            present(contactAlert, animated: true)
        }
        
    }
    




