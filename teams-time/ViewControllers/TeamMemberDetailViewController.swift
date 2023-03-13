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
    
    var currentTeamMember: TeamMember!
    var currentStatus = Status.self
    
    
    @IBOutlet var contactButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        contactButton.layer.cornerRadius = 10
        nameLabel.text = currentTeamMember.name
        positionLabel.text = currentTeamMember.jobTitle
        teamMemberImageView.image = UIImage(named: currentTeamMember.name)
    }
    
    @IBAction func contactButtonTapped() {
        statusLabel.text == currentStatus.active.rawValue
            ? showContactAlert(
                withtitle: "Please, contact with employee by telegram",
                andmessage: "Nickname is \(currentTeamMember.contact ?? "")"
            )
            : showContactAlert(
                withtitle: "Ooops! Employee is resting after work.",
                andmessage: "You can`t contact with employee...🤷🏼"
            )
       }
}

    extension TeamMemberDetailViewController {
        private func showContactAlert(withtitle title: String, andmessage message: String) {
            let contactAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            present(contactAlert, animated: true)
        }
        
    }
    




