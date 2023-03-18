//
//  FocusViewController.swift
//  teams-time
//
//  Created by Bektemur Mamashayev on 17/03/23.
//

import UIKit

final class FocusViewController: UIViewController {
    
    @IBOutlet var timerLabel: UILabel!
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var pauseButton: UIButton!
    
    
    private var timeRemaining = 1 * 60
    private var pauseRemaining = 0 * 60
    private var timer: Timer!
    private var timerStarted = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButtonPressed() {
        if !timerStarted {
            timer = Timer.scheduledTimer(
                withTimeInterval: 1,
                repeats: true,
                block: { [weak self] timer in
                    self?.updateTimer()
                }
            )
        }
    }
    
    @IBAction func pauseButtonPressed() {
        if timer != nil {
            timer.invalidate()
            startButton.setTitle("Resume", for: .normal)
            timerStarted = false
        }
    }
    
}

private extension FocusViewController {
    func updateTimer() {
        if timeRemaining > 0 {
            
            if !timerStarted {
                timerStarted = true
            }
            
            timeRemaining -= 1
            let minutes = timeRemaining / 60
            let seconds = timeRemaining % 60
            let timeString = String(format: "%02d:%02d", minutes, seconds)
            timerLabel.text = timeString
        } else {
            timer.invalidate()
            timer = nil
            timerStarted = false
        }
        
    }
}
