//
//  UserActivityViewController.swift
//  teams-time
//
//  Created by Anton Kuzmin on 09.03.2023.
//

import UIKit

final class UserActivityViewController: UIViewController {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    var user: TeamMember!
    private var timeStatus: DefineTimeStatus!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "User Activity"
        userNameLabel.text = user.name
        timeStatus = DefineTimeStatus()
        timeStatus.update(timeLabel: currentTimeLabel, statusLabel: statusLabel, by: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        
        settingsVC.user = user
    }
    
    @IBAction func unwindTo(_ unwindSegue: UIStoryboardSegue) {
        guard let settingsVC = unwindSegue.source as? SettingsViewController else { return }
        timeStatus.cancelTimer()
        
        user.name = settingsVC.nameTextField.text!
        user.timezone = Timezone(rawValue: settingsVC.selectedTimeZone)!
        
        userNameLabel.text = user.name
        
        timeStatus = DefineTimeStatus()
        timeStatus.update(timeLabel: currentTimeLabel, statusLabel: statusLabel, by: user)
    }
}
