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
        if statusLabel.text != Status.active.rawValue {
            showAlert(
                with: "\(teamMember.name) is currently inactive",
                and: "Please, try to contact with \(teamMember.name) during their working time"
            )
        } else {
            guard let contact = teamMember.contact else {
                showAlert(
                    with: "No contact",
                    and: "\(teamMember.name) did not give his contact."
                )
                return
            }
            
            guard let url = URL(string: "tg://resolve?domain=\(contact)") else { return }
            
            UIApplication.shared.open(url)
        }
   }
}
