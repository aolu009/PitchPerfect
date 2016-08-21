//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Lu Ao on 6/22/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    
    
    @IBOutlet weak var EchoButton: UIButton!
    @IBOutlet weak var ReverbButton: UIButton!
    @IBOutlet weak var DarthVadarButton: UIButton!
    @IBOutlet weak var ChipmunkButton: UIButton!
    @IBOutlet weak var SnailButton: UIButton!
    @IBOutlet weak var RabbitButton: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    
    var stopTimer: NSTimer!
    
    enum ButtonType: Int{ case Slow = 0, Fast,Chipmunk, Vadar, Echo, Reverb}
    
    
    @IBAction func playSoundForButton(sender: UIButton) {
        print("Play back!")
        switch(ButtonType(rawValue: sender.tag)!){
        case .Slow:
                playSound(rate: 0.5)
        case .Fast:
                playSound(rate: 1.5)
        case .Chipmunk:
                playSound(pitch: 1500,rate: 3.5)
        case .Vadar:
                playSound(pitch: -1000)
        case .Echo:
                playSound(echo: true)
        case .Reverb:
                playSound(reverb: true)
        }
        configureUI(.Playing)
    }
    
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        print("Play stop!")
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PlaySoundViewController loaded")
        setupAudio()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    
    override func viewWillDisappear(animated: Bool) {
        stopAudio()
    }

}
