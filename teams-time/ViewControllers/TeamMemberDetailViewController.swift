//
//  TeamMemberDetailsViewController.swift
//  teams-time
//
//  Created by Аня Беликова on 11.03.2023.
//

import UIKit

final class TeamMemberDetailViewController: UIViewController {

    @IBOutlet var teamMemberImageView: UIImageView! {
        didSet {
            teamMemberImageView.layer.cornerRadius = teamMemberImageView.frame.height / 2
        }
    }
    @IBOutlet var contactButton: UIButton!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var currentTimeLabel: UILabel!
    
    var teamMember: TeamMember!
    
    private let timeStatus = DefineTimeStatus()

    override func viewDidLoad() {
        super.viewDidLoad()
        contactButton.layer.cornerRadius = 10
        teamMemberImageView.image = UIImage(named: teamMember.name)
        
        nameLabel.text = teamMember.name
        
        positionLabel.text = teamMember.jobTitle
        positionLabel.textColor = .systemGray
        
        timeStatus.update(
            timeLabel: currentTimeLabel,
            statusLabel: statusLabel,
            by: teamMember
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timeStatus.cancelTimer()
    }
    
    @IBAction func contactButtonTapped() {
        statusLabel.text == Status.active.rawValue
            ? showContactAlert(
                with: "Please, contact with employee by telegram",
                and: "Nickname is \(teamMember.contact ?? "")"
            )
            : showContactAlert(
                with: "Ooops! Employee is resting after work.",
                and: "You can`t contact with employee...🤷🏼"
            )
       }
}

extension TeamMemberDetailViewController {
    private func showContactAlert(with title: String, and message: String) {
        let contactAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        contactAlert.addAction(okAction)
        present(contactAlert, animated: true)
    }
}
