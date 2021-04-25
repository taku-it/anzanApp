//
//  SetteiViewController.swift
//  ankiBattle
//
//  Created by 生田拓登 on 2020/06/14.
//

import UIKit
import AVFoundation

class SetteiViewController: UIViewController {

    var koukaonnButtomState: Bool = true
    let koukaonnData: UserDefaults = UserDefaults.standard
    let tapSoundPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "water-drop1")! .data)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        koukaonnButtomState = (koukaonnData.object(forKey: "koukaonnKey") != nil)
        print(koukaonnButtomState)
    }
    
    @IBAction func switchChange(_ sender: UISwitch) {
        koukaonnButtomState = !koukaonnButtomState
        print(koukaonnButtomState)
        koukaonnData.set(koukaonnButtomState, forKey: "koukaonnKey")
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
        koukaonnTrigger()
    }
   
    func koukaonnTrigger(){
        tapSoundPlayer.currentTime = 0
        tapSoundPlayer.play()
    }

}
