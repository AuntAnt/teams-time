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
    
    private var timeRemaining: Int!
    private var timer: Timer!
    private var timerStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isEnabled = false
        resetTimer()
    }
    
    @IBAction func startButtonPressed() {
        pauseButton.isEnabled = true
        startButton.setTitle("restart", for: .normal)
        startButton.setImage(UIImage(systemName: "repeat.circle"), for: .normal)
        
        pauseButton.setTitle("pause", for: .normal)
        pauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        if !timerStarted {
            resetTimer()
            updateTimer()
            runTimer()
        } else {
            timer.invalidate()
            resetTimer()
            updateTimer()
            runTimer()
        }
    }
    
    @IBAction func pauseButtonPressed() {
        if timerStarted {
            timer.invalidate()
            timerStarted = false
            pauseButton.setTitle("resume", for: .normal)
            pauseButton.setImage(UIImage(systemName: "restart.circle"), for: .normal)
        } else {
            updateTimer()
            runTimer()
            pauseButton.setTitle("pause", for: .normal)
            pauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        }
    }
}

private extension FocusViewController {
    
    func resetTimer() {
        timeRemaining = 25 * 60
    }
    
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
    
    func runTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true,
            block: { [weak self] timer in
                self?.updateTimer()
            }
        )
    }
}
