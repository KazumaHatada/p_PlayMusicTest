//
//  ViewController.swift
//  PlayMusicTest
//
//  Created by Kazuma Hatada on 2019/07/30.
//  Copyright © 2019 Kazuma Hatada. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var lVolume: UILabel!
    @IBOutlet weak var lIsPlaying: UILabel!
    @IBAction func bStart(_ sender: UIButton) {
        prepareEngine()
        player.play()
        if player.isPlaying {
            lIsPlaying.text = "演奏中だよ"
        } else {
            lIsPlaying.text = "鳴ってないよ。。"
        }
    }
    
    
    @IBAction func bPause(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
            lIsPlaying.text = "一時停止中だよ"
        } else {
            player.play()
            lIsPlaying.text = "また鳴りだしたよ"
        }
    }
    
    
    @IBAction func bStop(_ sender: UIButton) {
        player.stop()
        lIsPlaying.text = "止まったよ"
    }
    
    
    @IBAction func sVolume(_ sender: UISlider) {
        player.volume = sender.value
        lVolume.text = String(format: "%.2f%%", player.volume * 100)
    }
    
    let player = AVAudioPlayerNode()
    let engine = AVAudioEngine()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareEngine()
    }
    
    func prepareEngine() {
        if let path = Bundle.main.path(forResource: "eine", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            
            if let file = try? AVAudioFile(forReading: url) {
                engine.attach(player)
                engine.connect(player, to: engine.mainMixerNode, format: file.processingFormat)
                player.scheduleFile(file, at: nil, completionHandler: nil)
                try? engine.start()
                
                player.volume = 0.5
                lVolume.text = String(format: "%.2f%%", player.volume * 100)
            }
        }
    }

}

