//
//  selectLevelViewController.swift
//  ankiBattle
//
//  Created by 生田拓登 on 2020/08/10.
//

import UIKit
import AVFoundation

class selectLevelViewController: UIViewController {
    
    let levelData: UserDefaults = UserDefaults.standard
    var levelNum = 0
    
    @IBOutlet var easyButton: UIButton!
    @IBOutlet var normalButton: UIButton!
    @IBOutlet var hardButton: UIButton!
    
    
    
    let tapSoundPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "water-drop1")! .data)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hardButton.layer.cornerRadius = 10 ; hardButton.layer.borderColor = UIColor.systemRed.cgColor ; hardButton.layer.borderWidth = 2
        easyButton.layer.cornerRadius = 10 ; easyButton.layer.borderColor = UIColor.systemGreen.cgColor ; easyButton.layer.borderWidth = 2
        normalButton.layer.cornerRadius = 10 ; normalButton.layer.borderColor = UIColor.systemIndigo.cgColor ; normalButton.layer.borderWidth = 2
        
    }
    
    @IBAction func easy() {
        koukaonnTrigger()
        levelNum = 0
        levelData.set(levelNum, forKey: "levelDataKey")
        performSegue(withIdentifier: "toStartGame", sender: nil)
        print(levelNum)
    }
    @IBAction func normal() {
        koukaonnTrigger()
        levelNum = 1
        levelData.set(levelNum, forKey: "levelDataKey")
        performSegue(withIdentifier: "toStartGame", sender: nil)
        print(levelNum)
    }
    @IBAction func hard() {
        koukaonnTrigger()
        levelNum = 2
        levelData.set(levelNum, forKey: "levelDataKey")
        print(levelNum)
        performSegue(withIdentifier: "toStartGame", sender: nil)
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil )
        koukaonnTrigger()
    }
    func koukaonnTrigger(){
        tapSoundPlayer.currentTime = 0
        tapSoundPlayer.play()
    }
}
