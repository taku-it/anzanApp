//
//  ResultViewController.swift
//  ankiBattle
//
//  Created by 生田拓登 on 2020/08/08.
//

import UIKit
import AVFoundation

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let timerData: UserDefaults = UserDefaults.standard
    let resultTimeArrayData: UserDefaults = UserDefaults.standard
    let levelNumData: UserDefaults = UserDefaults.standard
    
    var EResultTime: String!
    var NResultTime: String!
    var HResultTime: String!
    
    var levelNum:Int!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var easyButton: UIButton!
    @IBOutlet var normalButton: UIButton!
    @IBOutlet var hardButton: UIButton!
    
    
    let tapSoundPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "water-drop1")! .data)
    
    var EresultTimeArray: [String] = []
    var NresultTimeArray: [String] = []
    var HresultTimeArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        levelNum = levelNumData.integer(forKey: "levelDataKey")
        dataLoad()
        decoration()
        buttonDecoration()
    }
    
    func decoration() {
        //        tableViewの装飾
        if levelNum == 0{
            tableView.layer.cornerRadius = 10 ; tableView.layer.borderColor = UIColor.systemGreen.cgColor ; tableView.layer.borderWidth = 3
        }else if levelNum == 1{
            tableView.layer.cornerRadius = 10 ; tableView.layer.borderColor = UIColor.systemIndigo.cgColor ; tableView.layer.borderWidth = 3
        }else if levelNum == 2{
            tableView.layer.cornerRadius = 10 ; tableView.layer.borderColor = UIColor.systemRed.cgColor ; tableView.layer.borderWidth = 3
        }
        //        ボタンの装飾
        backButton.layer.cornerRadius = 10  ;   backButton.layer.borderColor = UIColor.systemTeal.cgColor ; backButton.layer.borderWidth = 1
        
        
        tableView.dataSource = self
    }
    
    func dataLoad(){
        print("levelNum: \(levelNum!)")
        
        if levelNum == 0 {
            EResultTime = timerData.object(forKey: "EResultTimeKey") as? String
            if resultTimeArrayData.object(forKey: "EresultTimeArrayKey") != nil{
                EresultTimeArray = resultTimeArrayData.object(forKey: "EresultTimeArrayKey") as! [String]
            }
            if EResultTime != nil{
                EresultTimeArray.insert(EResultTime, at: 0)
                print("EresultTime:\(EresultTimeArray)")
            }
            if resultTimeArrayData.object(forKey: "HresultTimeArrayKey") != nil{
                HresultTimeArray = resultTimeArrayData.object(forKey: "HresultTimeArrayKey") as!
                    [String]
            }
            if resultTimeArrayData.object(forKey: "NresultTimeArrayKey") != nil{
                NresultTimeArray = resultTimeArrayData.object(forKey: "NresultTimeArrayKey") as! [String]
            }
            
        }else if levelNum == 1 {
            NResultTime = timerData.object(forKey: "NResultTimeKey") as? String
            if resultTimeArrayData.object(forKey: "NresultTimeArrayKey") != nil{
                NresultTimeArray = resultTimeArrayData.object(forKey: "NresultTimeArrayKey") as! [String]
            }
            if NResultTime != nil{
                NresultTimeArray.insert(NResultTime, at: 0)
            }
            if resultTimeArrayData.object(forKey: "EresultTimeArrayKey") != nil{
                EresultTimeArray = resultTimeArrayData.object(forKey: "EresultTimeArrayKey") as! [String]
            }
            if  resultTimeArrayData.object(forKey: "HresultTimeArrayKey") != nil{
                HresultTimeArray = resultTimeArrayData.object(forKey: "HresultTimeArrayKey") as!
                    [String]
            }
        }else if levelNum == 2 {
            HResultTime = timerData.object(forKey: "HResultTimeKey") as? String
            if resultTimeArrayData.object(forKey: "HresultTimeArrayKey") != nil{
                HresultTimeArray = resultTimeArrayData.object(forKey: "HresultTimeArrayKey") as!
                    [String]
            }
            if HResultTime != nil{
                HresultTimeArray.insert(HResultTime, at: 0)
            }
            if resultTimeArrayData.object(forKey: "EresultTimeArrayKey") != nil{
                EresultTimeArray = resultTimeArrayData.object(forKey: "EresultTimeArrayKey") as! [String]
            }
            if resultTimeArrayData.object(forKey: "NresultTimeArrayKey") != nil{
                
                NresultTimeArray = resultTimeArrayData.object(forKey: "NresultTimeArrayKey") as!
                    [String]
            }
            
        }else{
            if resultTimeArrayData.object(forKey: "EResultTimeKey") != nil{
                
                EresultTimeArray = resultTimeArrayData.object(forKey: "EresultTimeArrayKey") as! [String]
            }
            if resultTimeArrayData.object(forKey: "NResultTimeKey") != nil{
                
                NresultTimeArray = resultTimeArrayData.object(forKey: "NresultTimeArrayKey") as! [String]
            }
            if resultTimeArrayData.object(forKey: "HResultTimeKey") != nil{
                
                HresultTimeArray = resultTimeArrayData.object(forKey: "HresultTimeArrayKey") as!
                    [String]
            }
        }
    }
    
    
    @IBAction func back() {
        print("backtoStartView")
        
        koukaonnTrigger()
        
        resultTimeArrayData.set(EresultTimeArray, forKey: "EresultTimeArrayKey")
        timerData.removeObject(forKey: "EResultTimeKey")
        
        
        resultTimeArrayData.set(NresultTimeArray, forKey: "NresultTimeArrayKey")
        timerData.removeObject(forKey: "NResultTimeKey")
        
        
        resultTimeArrayData.set(HresultTimeArray, forKey: "HresultTimeArrayKey")
        timerData.removeObject(forKey: "HResultTimeKey")
        
        levelNumData.removeObject(forKey: "levelDataKey")
    }
    
    @IBAction func easy() {
        levelNum = 0
        koukaonnTrigger()
        tableView.reloadData()
        //        ボタンの装飾
        easyButton.layer.backgroundColor = UIColor.systemGreen.cgColor;self.view.bringSubviewToFront(easyButton)
        normalButton.layer.backgroundColor = UIColor.systemGray6.cgColor;self.view.sendSubviewToBack(normalButton)
        hardButton.layer.backgroundColor = UIColor.systemGray6.cgColor;self.view.sendSubviewToBack(hardButton)
        
        //        tableViewの装飾
        tableView.layer.cornerRadius = 10 ; tableView.layer.borderColor = UIColor.systemGreen.cgColor ; tableView.layer.borderWidth = 3
        
    }
    
    @IBAction func normal() {
        levelNum = 1
        koukaonnTrigger()
        tableView.reloadData()
        //        ボタンの装飾
        easyButton.layer.backgroundColor = UIColor.systemGray6.cgColor;self.view.sendSubviewToBack(easyButton)
        normalButton.layer.backgroundColor = UIColor.systemIndigo.cgColor;self.view.bringSubviewToFront(normalButton)
        hardButton.layer.backgroundColor = UIColor.systemGray6.cgColor;self.view.sendSubviewToBack(hardButton)
        //        tableViewの装飾
        tableView.layer.cornerRadius = 10 ; tableView.layer.borderColor = UIColor.systemIndigo.cgColor ; tableView.layer.borderWidth = 3
        
    }
    
    @IBAction func hard() {
        levelNum = 2
        tableView.reloadData()
        koukaonnTrigger()
        //        ボタンの装飾
        easyButton.layer.backgroundColor = UIColor.systemGray6.cgColor;self.view.sendSubviewToBack(easyButton)
        normalButton.layer.backgroundColor = UIColor.systemGray6.cgColor;self.view.sendSubviewToBack(normalButton)
        hardButton.layer.backgroundColor = UIColor.systemRed.cgColor;self.view.bringSubviewToFront(hardButton)
        //        tableviewの装飾
        tableView.layer.cornerRadius = 10 ; tableView.layer.borderColor = UIColor.systemRed.cgColor ; tableView.layer.borderWidth = 3
        
    }
    
    
    func koukaonnTrigger() {
        tapSoundPlayer.currentTime = 0
        tapSoundPlayer.play()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if levelNum == 0{
            return EresultTimeArray.count
        }
        
        if levelNum == 1{
            return NresultTimeArray.count
        }
        if levelNum == 2{
            return HresultTimeArray.count
        }
        
        return EresultTimeArray.count
    }
    
//    func dataHantei() {
//        if resultTimeArrayData.object(forKey: "EresultTimeArrayKey") != nil{
//            EresultTimeArray = resultTimeArrayData.object(forKey: "EresultTimeArrayKey") as! [String]
//        }
//        if resultTimeArrayData.object(forKey: "NresultTimeArrayKey") != nil{
//            NresultTimeArray = resultTimeArrayData.object(forKey: "NresultTimeArrayKey") as! [String]
//        }
//        if resultTimeArrayData.object(forKey: "HresultTimeArrayKey") != nil {
//            HresultTimeArray = resultTimeArrayData.object(forKey: "HresultTimeArrayKey") as! [String]
//        }
//    }
    
    func buttonDecoration(){
        if levelNum == 0{
            easyButton.layer.backgroundColor = UIColor.systemGreen.cgColor;self.view.bringSubviewToFront(easyButton);easyButton.layer.cornerRadius = 2
            normalButton.layer.backgroundColor = UIColor.systemGray6.cgColor;self.view.sendSubviewToBack(normalButton);normalButton.layer.cornerRadius = 2
            hardButton.layer.backgroundColor = UIColor.systemGray6.cgColor;self.view.sendSubviewToBack(hardButton);hardButton.layer.cornerRadius = 2
        }else if levelNum == 1{
            easyButton.layer.backgroundColor = UIColor.systemGray6.cgColor;self.view.sendSubviewToBack(easyButton)
            normalButton.layer.backgroundColor = UIColor.systemIndigo.cgColor;self.view.bringSubviewToFront(normalButton)
            hardButton.layer.backgroundColor = UIColor.systemGray6.cgColor;self.view.sendSubviewToBack(hardButton)
        }else if levelNum == 2{
            easyButton.layer.backgroundColor = UIColor.systemGray6.cgColor;self.view.sendSubviewToBack(easyButton)
            normalButton.layer.backgroundColor = UIColor.systemGray6.cgColor;self.view.sendSubviewToBack(normalButton)
            hardButton.layer.backgroundColor = UIColor.systemRed.cgColor;self.view.bringSubviewToFront(hardButton)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell")
        if levelNum == 0{
            cell?.textLabel?.text = (EresultTimeArray[indexPath.row])
        }
        if levelNum == 1{
            cell?.textLabel?.text = (NresultTimeArray[indexPath.row])
        }
        if levelNum == 2{
            cell?.textLabel?.text = (HresultTimeArray[indexPath.row])
        }
        
        return cell!
    }
}

