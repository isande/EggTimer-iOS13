//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft": 300, "Medium": 480, "Hard": 720]
    var secondsPassed = 0
    var totalTime = 0
    var timer: Timer?
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        

        timer?.invalidate()
        totalTime = 0
        secondsPassed = 0
        progressBar.progress = 0.0

    
        guard let hardness = sender.currentTitle else { return }
        
        totalTime = eggTimes[hardness] ?? 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed <= self.totalTime {
                self.progressBar.progress = Float(self.secondsPassed) / Float(self.totalTime)
                self.secondsPassed += 1
            } else {
                Timer.invalidate()
                self.playAlarm()
            }
        }
    }
    
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
