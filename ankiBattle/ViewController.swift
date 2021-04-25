//
//  ViewController.swift
//  ankiBattle
//
//  Created by 生田拓登 on 2020/06/07.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet var gameButton: UIButton!
    @IBOutlet var settingButton: UIButton!
    @IBOutlet var timeButton: UIButton!
    
    let levelNumData: UserDefaults = UserDefaults.standard
    let tapSoundPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "water-drop1")! .data)
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        gameButton.layer.cornerRadius = 10 ; gameButton.layer.borderColor = UIColor.orange.cgColor ; gameButton.layer.borderWidth = 2
        settingButton.layer.cornerRadius  = 10 ; settingButton.layer.borderColor = UIColor.systemGreen.cgColor ; settingButton.layer.borderWidth = 2
        timeButton.layer.cornerRadius = 10 ; timeButton.layer.borderColor = UIColor.systemIndigo.cgColor ; timeButton.layer.borderWidth = 2
    }
    
    @IBAction func settei() {
       koukaonnTrigger()
        performSegue(withIdentifier: "toSettei", sender: nil)
    }
    
    @IBAction func Game() {
        koukaonnTrigger()
        performSegue(withIdentifier: "toSelectLevel", sender: nil)
    }
    @IBAction func time() {
        koukaonnTrigger()
        performSegue(withIdentifier: "toViewResult", sender: nil)
    
    }

    func koukaonnTrigger(){
        tapSoundPlayer.currentTime = 0
        tapSoundPlayer.play()
    }
}

