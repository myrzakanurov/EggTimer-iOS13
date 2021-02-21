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
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var timer = Timer()

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        let result = eggTimes[hardness]!

        var seconds: Float = Float(result) * 1.0
        progressBar.progress = 0.0
        messageLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if seconds > 0 {
                print ("\(seconds) seconds")
                self.progressBar.setProgress(seconds / 1.0, animated: true)
                seconds -= 1
            } else if(seconds == 0){
                self.progressBar.progress = 1.0
                self.messageLabel.text = "DONE"
                self.playSound()
                self.timer.invalidate()
            } else {
                Timer.invalidate()
            }
        }
    }
    
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
