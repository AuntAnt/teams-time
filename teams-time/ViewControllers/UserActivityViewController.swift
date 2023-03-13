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
    
    ///TODO: uncomment  variable and remove const, when can get User from Login Screen
//    var user: TeamMember!
    var user = TeamMember(name: "User", timezone: .dublin, contact: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = user.name
        updateTime()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        
        settingsVC.user = user
    }
    
    @IBAction func unwindTo(_ unwindSegue: UIStoryboardSegue) {
        guard let settingsVC = unwindSegue.source as? SettingsViewController else { return }
        
        user.name = settingsVC.nameTextField.text!
        user.timezone = Timezone(rawValue: settingsVC.selectedTimeZone)!
        
        userNameLabel.text = user.name
    }
    
    //MARK: - private methods
    private func updateTime() {
        let date = Date.now
        
        let timer = Timer(
            fireAt: date,
            interval: 1,
            target: self,
            selector: #selector(setCurrentTime),
            userInfo: nil,
            repeats: true
        )
        
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc private func setCurrentTime() {
        currentTimeLabel.text = getCurrentTime()

        defineStatus()
    }
    
    private func getCurrentTime() -> String {
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone(identifier: user.timezone.rawValue)
        formatter.dateFormat = "HH:mm:ss"
        
        return formatter.string(from: Date())
    }
    
    private func defineStatus() {
        let currentHour = currentTimeLabel.text?.components(separatedBy: ":").first ?? ""
        
        guard let hour = Int(currentHour) else { return }
        
        if (user.workingTime.from...user.workingTime.to).contains(hour) {
            statusLabel.text = Status.active.rawValue
        } else {
            statusLabel.text = Status.inactive.rawValue
        }
    }
}
