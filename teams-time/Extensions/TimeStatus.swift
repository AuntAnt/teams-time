//
//  TimeStatus.swift
//  teams-time
//
//  Created by Anton Kuzmin on 11.03.2023.
//

import UIKit

//MARK: - Extension for updating time and status
extension UIViewController {
    
    func update(timeLabel: UILabel, statusLabel: UILabel, for teamMember: TeamMember) {
        let date = Date.now

        let timer = Timer(
            fireAt: date,
            interval: 1,
            target: self,
            selector: #selector(setCurrentTime(sender:)),
            userInfo: [
                "timeLabel": timeLabel,
                "statusLabel": statusLabel,
                "teamMember": teamMember
            ],
            repeats: true
        )

        RunLoop.main.add(timer, forMode: .common)
    }

    @objc private func setCurrentTime(sender: Timer) {
        guard let userInfo = sender.userInfo as? [String: Any] else { return }
        guard let teamMember = userInfo["teamMember"] as? TeamMember else { return }

        var currentHour = ""

        if let timeLabel = userInfo["timeLabel"] as? UILabel {
            let currentTime = getCurrentTime(teamMember: teamMember)
            timeLabel.text = currentTime
            currentHour = currentTime.components(separatedBy: ":").first ?? ""
        }

        if let statusLabel = userInfo["statusLabel"] as? UILabel {
            let status = defineStatus(currentHour: currentHour, teamMember: teamMember)
            statusLabel.text = status
            statusLabel.textColor = status == Status.active.rawValue
            ? .systemGreen
            : .systemRed
        }
    }

    private func getCurrentTime(teamMember: TeamMember) -> String {
        let formatter = DateFormatter()

        formatter.timeZone = TimeZone(identifier: teamMember.timezone.rawValue)
        formatter.dateFormat = "HH:mm:ss"

        return formatter.string(from: Date())
    }

    private func defineStatus(currentHour: String, teamMember: TeamMember) -> String {
        guard let hour = Int(currentHour) else { return ""}

        return (teamMember.workingTime.from..<teamMember.workingTime.to).contains(hour)
        ? Status.active.rawValue
        : Status.inactive.rawValue
    }
}
