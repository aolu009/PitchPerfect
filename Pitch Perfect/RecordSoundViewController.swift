//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Lu Ao on 6/16/16.
//  Copyright © 2016 Lu Ao. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var RecordText: UILabel!
    @IBOutlet weak var Recording: UIButton!
    @IBOutlet weak var StopRecording: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Recording.enabled = true
        StopRecording.enabled = false
        RecordText.text = "按一下開始錄音"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        print("Test View_will_appear")
        RecordText.text = "按一下開始錄音"
        
    }
    override func viewWillDisappear(animated: Bool) {
        print("Testing View_will_disappear")
    }
    @IBAction func StopRecording(sender: AnyObject) {
        Recording.enabled = true
        StopRecording.enabled = false
        print("錄音完畢")
        RecordText.text = "錄音完畢"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        try! audioSession.setActive(false)
    }
    
    @IBAction func RecordAudio(sender: AnyObject) {
            StopRecording.enabled = true
            Recording.enabled = false
            print("錄音中")
            RecordText.text = "錄音中"
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
           print("Record successful and finished")
        }
        else{
            print("Record finished but not successful")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}

