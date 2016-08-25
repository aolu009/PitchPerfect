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
    }
    
    
    override func viewWillAppear(animated: Bool) {
        RecordText.text = "按一下開始錄音"
        
    }
    override func viewWillDisappear(animated: Bool) {
    }
    // Should try to use if let
    func recordStateChange( state:String ){
        if state == "錄音完畢"{
            Recording.enabled = true
            StopRecording.enabled = false
            RecordText.text = state
        }
        else{
            StopRecording.enabled = true
            Recording.enabled = false
            RecordText.text = state
        }
    }
    
    @IBAction func StopRecording(sender: AnyObject) {
        recordStateChange("錄音完畢")
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        try! audioSession.setActive(false)
    }
    
    @IBAction func RecordAudio(sender: AnyObject) {
        recordStateChange("錄音中")
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
        if flag {
            performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
            print("Record successful and finished")
        }
        else{
            RecordText.text = "Record finished but not successful"
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

