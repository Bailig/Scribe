//
//  MainViewController.swift
//  Scribe
//
//  Created by Bailig Abhanar on 2017-04-11.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class MainViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var trascriptionTextView: UITextView!
    @IBAction func playBtnPressed(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        requestSpeechAuth()
    }
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            guard authStatus == SFSpeechRecognizerAuthorizationStatus.authorized, let path = Bundle.main.url(forResource: "test", withExtension: "m4a") else { return }
            do {
                let sound = try AVAudioPlayer(contentsOf: path)
                self.audioPlayer = sound
                self.audioPlayer.delegate = self
                sound.play()
            } catch let error as NSError{
                print(error.debugDescription)
            }
            
            let recognizer = SFSpeechRecognizer()
            let request = SFSpeechURLRecognitionRequest(url: path)
            recognizer?.recognitionTask(with: request) { result, error in
                guard let result = result else {
                    print("error: result assignment failed!")
                    if let error = error {
                        fatalError(error.localizedDescription)
                    }
                    return
                }
                self.trascriptionTextView.text = result.bestTranscription.formattedString
                print(result.bestTranscription.formattedString)
            }
        }
    }
}

