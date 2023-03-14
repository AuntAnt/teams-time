//
//  TeamListViewController.swift
//  teams-time
//
//  Created by Bektemur Mamashayev on 10/03/23.
//

import UIKit

final class TeamListViewController: UITableViewController {
    
    private let teamMembers = TeamMember.getMembers()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let personVC = segue.destination as? TeamMemberDetailViewController
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        personVC?.teamMember = teamMembers[indexPath.section]
    }
}
// MARK: - Table view data source
extension TeamListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        teamMembers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "member", for: indexPath) as! MemberCell
        let member = teamMembers[indexPath.section]
        cell.memberImageView.image = UIImage(named: member.name.lowercased())
        cell.memberImageView.layer.cornerRadius = cell.memberImageView.frame.width / 2
        cell.nameLabel.text = member.name
        cell.positionLabel.text = member.jobTitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        teamMembers[section].timezone.rawValue
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
}
