//
//  GameViewController.swift
//  ankiBattle
//
//  Created by 生田拓登 on 2020/06/07.
//

import UIKit
import AVFoundation


class GameViewController: UIViewController {
    //  タイム計測のデータを入れるuserdefaults
    let timerData: UserDefaults = UserDefaults.standard
    //  選択したレベルの数字を取り出すためのuserdefaults
    let levelData: UserDefaults = UserDefaults.standard
    
    var totalNum = 0
    var selectNum = 0
    
//    それぞれのモードの初期値
    var easyModeNum = 1
    var normalModeNum = 10
    var hardModeNum = 100
    
//    レベル判定するための数字
    var levelNum = 0
    
    
    
    //    タイム計測
    var timecount: Float = 0.0
    var timer: Timer = Timer()
    
    //    開始までのカウントダウン
    var countdown: Float = 5.0
    var countDownTimer: Timer = Timer()
    
    @objc func up() {
        timecount += 0.01
        timerLabel.text = String(format: "%.2f", timecount)
    }
    
    @objc func down() {
        if countdown >= 0.01{
            countdown -= 0.01
            countDownLabel.text = String(format: "%.0f", countdown)
        }
    }
    //    合計の数字
    @IBOutlet var num1Label: UILabel!
    //　　　足す数字
    @IBOutlet var num2Label: UILabel!
    //　　　選ぶ数字
    @IBOutlet var num3Label: UILabel!
    
    //    計測タイマーのラベル
    @IBOutlet var timerLabel: UILabel!
    //    カウントダウンのラベル
    @IBOutlet var countDownLabel: UILabel!
    
    //    計算用ボタン
    @IBOutlet var button0: UIButton!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    
//    pauseViewの上に置くボタン
    let restartButton = UIButton()
    let giveupButton = UIButton()
    let xmarkButton = UIButton()
    
    //    問題になる数字の配列
    var probNumArray: [Int] = []
    //   probArrayのランダム
    var ran: Int = 0
    
    //  　問題になる数字を作る
    func makeProbNum() {
        
        if levelNum == 1 {
//            10...99
            for _ in 10...99 {
                probNumArray.append(normalModeNum)
                normalModeNum += 1
            }
        print("NormalMode")
            print("問題数: \(probNumArray.count)")
        }
            
        if levelNum == 2{
//            100...999
            for _ in 100...999 {
                probNumArray.append(hardModeNum)
                hardModeNum += 1
            }
            print("HardMode")
            print("問題数: \(probNumArray.count)")
        }
            if levelNum == 0{
            for _ in 0...14 {
                probNumArray.append(easyModeNum)
                if probNumArray.count % 2 == 0{
                easyModeNum += 1
                }
            }
        print("EasyMode")
                print("問題数: \(probNumArray.count)")
        }
        
        print("\(probNumArray)が生成されました。")
        
    }
//        効果音
        let keySoundPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "cursor4")! .data)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelDecoration()
        
        countDownLabel.text = String(format: "%.0f", countdown)
        levelNum = levelData.integer(forKey: "levelDataKey")
        
        makeProbNum()
        
        ran  = Int.random(in: 0 ... (probNumArray.count - 1 ))
        num2Label.text = String(probNumArray[ran])
        print(levelNum)
        
        
        
        //        始まったらカウントダウン
        if !countDownTimer.isValid{
            countDownTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.down), userInfo: nil, repeats: true)
            KeisanButtonState()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.00) {
                self.countDownTimer.invalidate()
                self.countDownLabel.isHidden = true
                //            ボタンを押せるようにする
                self.KeisanButtonState()
                //            タイム計測をスタートさせる
                self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
                print(self.countDownLabel.text)
            }
        }
    }
    
    func labelDecoration(){
        timerLabel.layer.cornerRadius = 10
        timerLabel.layer.borderColor = UIColor.black.cgColor
        timerLabel.layer.borderWidth = 1
        
    }
    
    // 　選んだ数字があっているか判定し、次の数字を表示
    func selectNumHantei() {
        
        if totalNum + probNumArray[ran] == selectNum {
            totalNum = totalNum + probNumArray[ran]
            print("残り問題数:\(probNumArray.count)", terminator: " ran番号:"); print(ran)
            probNumArray.remove(at: ran)
            num1Label.text = String(totalNum)
            selectNum *= 0
            num3Label.text = String(selectNum)
            
//            レベルごとに問題数を設定する
            if levelNum == 1{
                if probNumArray.count == 85 {
                    num2Label.text = String("0")
                    KeisanButtonState()
                    gameover()
                }else{
                    ran = Int.random(in: 0 ... (probNumArray.count - 1))
                    num2Label.text = String(probNumArray[ran])
                }
            }else if levelNum == 2{
                if probNumArray.count == 897{
                    num2Label.text = String("0")
                    KeisanButtonState()
                    gameover()
                }else{
                    ran = Int.random(in: 0 ... (probNumArray.count - 1))
                    num2Label.text = String(probNumArray[ran])
                }
            }else{
                if probNumArray.count == 0{
                    num2Label.text = String("0")
                    KeisanButtonState()
                    gameover()
                }else{
                    ran = Int.random(in: 0 ... (probNumArray.count - 1))
                    num2Label.text = String(probNumArray[ran])
                }
            }
            
        }
    }
    
    func gameover() {
        
        if timer.isValid {
            timer.invalidate()
        }
        countDownLabel.isHidden = false
        countDownLabel.text = String("Finish!")
        print("ゲーム終了")
        timerSaveData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.00) {
            self.performSegue(withIdentifier: "toViewResult", sender: nil)
        }
    }
    
    
    
    //    計算用ボタンの状態(押せる/押せない)を変える
    func KeisanButtonState() {
        if countDownTimer.isValid{
            print("stopButton")
            button0.isEnabled = false
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
            button4.isEnabled = false
            button5.isEnabled = false
            button6.isEnabled = false
            button7.isEnabled = false
            button8.isEnabled = false
            button9.isEnabled = false
            
        }else if !countDownTimer.isValid{
            print("canPushButton")
            button0.isEnabled = true
            button1.isEnabled = true
            button2.isEnabled = true
            button3.isEnabled = true
            button4.isEnabled = true
            button5.isEnabled = true
            button6.isEnabled = true
            button7.isEnabled = true
            button8.isEnabled = true
            button9.isEnabled = true
        }
        if probNumArray.count == 0{
            print("stopButton2")
            button0.isEnabled = false
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
            button4.isEnabled = false
            button5.isEnabled = false
            button6.isEnabled = false
            button7.isEnabled = false
            button8.isEnabled = false
            button9.isEnabled = false
        }
    }
    
    func timerSaveData (){
        
        let timecountRound = roundf(timecount*100)/100
        if levelNum == 1{
            //            normalモードのデータを保存
            timerData.set(dateformatAndSave(time: timecountRound), forKey: "NResultTimeKey")
            print("normalModeTimeDataSaved")
        }else if levelNum == 2{
            //            hardモードのデータを保存
            timerData.set(dateformatAndSave(time: timecountRound), forKey: "HResultTimeKey")
            print("hardModeTimeDataSaved")
        }else{
            //            easyモードのデータを保存
            timerData.set(dateformatAndSave(time: timecountRound), forKey: "EResultTimeKey")
            print("easyModeTimeDataSaved")
        }
    }
    
    //   記録したタイマーをstringにする
    func dateformatAndSave(time: Float) -> String {
        return String(time)
    }
    
    // 計算用ボタンの処理
    @IBAction func num1B() {
        selectNum = selectNum * 10 + 1
        num3Label.text = String(selectNum)
        selectNumHantei()
        
    }
    @IBAction func num2B() {
        selectNum = selectNum * 10 + 2
        num3Label.text = String(selectNum)
        selectNumHantei()
    }
    @IBAction func num3B() {
        selectNum = selectNum * 10 + 3
        num3Label.text = String(selectNum)
        selectNumHantei()
    }
    @IBAction func num4B() {
        selectNum = selectNum * 10 + 4
        num3Label.text = String(selectNum)
        selectNumHantei()
    }
    @IBAction func num5B() {
        selectNum = selectNum * 10 + 5
        num3Label.text = String(selectNum)
        selectNumHantei()
    }
    @IBAction func num6B() {
        selectNum = selectNum * 10 + 6
        num3Label.text = String(selectNum)
        selectNumHantei()
    }
    @IBAction func num7B() {
        selectNum = selectNum * 10 + 7
        num3Label.text = String(selectNum)
        selectNumHantei()
    }
    @IBAction func num8B() {
        selectNum = selectNum * 10 + 8
        num3Label.text = String(selectNum)
        selectNumHantei()
        selectNum += 0
    }
    @IBAction func num9B() {
        selectNum = selectNum * 10 + 9
        num3Label.text = String(selectNum)
        selectNumHantei()
    }
    @IBAction func num0B() {
        selectNum *= 10
        num3Label.text = String(selectNum)
        selectNumHantei()
    }
    @IBAction func delete() {
        selectNum = selectNum / 10
        num3Label.text = String(selectNum)
        if selectNum != 0{
            
        }
        
    }
//    一時停止ボタン
//    @IBAction func pause(){
//
//        if timer.isValid{
//            timer.invalidate()
////            各部品の装飾
//            pauseView.layer.borderWidth = 1;pauseView.layer.cornerRadius = 10;pauseView.layer.borderColor = UIColor.darkGray.cgColor
//            view.bringSubviewToFront(pauseView);pauseView.layer.shadowRadius = 2;pauseView.layer.shadowOpacity = 2
//            restartButton.layer.borderWidth = 2;restartButton.layer.cornerRadius = 10;restartButton.layer.borderColor = UIColor.systemGreen.cgColor
//            giveupButton.layer.borderWidth = 2;giveupButton.layer.cornerRadius  = 10;giveupButton.layer.borderColor = UIColor.systemRed.cgColor
////            pause画面のボタンを表示
//            giveupButton.isHidden = false
//            restartButton.isHidden = false
//            pauseView.isHidden = false
//        }
//    }
    
//    @IBAction func restartGame(){
//
//    }
//    @IBAction func giveupGame(){
//        if !timer.isValid {
//            timer.invalidate()
//
//        }
//    }
//    @IBAction func xmarkButtonToClosePause(){
//        giveupButton.isHidden = true
//        restartButton.isHidden = true
//        pauseView.isHidden = true
//        if !countDownTimer.isValid{
//            countdown = 3.0
//            self.countDownLabel.isHidden = false
//            countDownTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.down), userInfo: nil, repeats: true)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.00) {
//                self.countDownTimer.invalidate()
//                self.countDownLabel.isHidden = true
//                //            タイム計測をスタートさせる
//                self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
//            }
//        }
//        }
    }
