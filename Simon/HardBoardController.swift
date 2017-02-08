//
//  HardBoardController.swift
//  Niru
//
//  Created by Johan Wejdenstolpe on 2017-01-24.
//  Copyright © 2017 Johan Wejdenstolpe. All rights reserved.
//

import UIKit
import AudioToolbox

class HardBoardController: UIViewController {
    let game = Game(inMaxRandomNumber: 6)
    var arrayCounter = 0
    var choice = 0
    let maxDiffInMs = 200
    var sequenceTimer: Timer?
//    var choiceTimer: Timer?
    var buttonCheckTimer: Timer?
    var btnYellowLastPressed: Int64 = 0
    var btnRedLastPressed: Int64 = 0
    var btnBlueLastPressed: Int64 = 0
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var infoTextField: UITextField!
//    @IBOutlet weak var highscoreLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
//        let highscore = UserDefaults()
//        if (highscore.string(forKey: "Highscore") != nil){
//            highscoreLabel.text = highscore.string(forKey: "Highscore")
//        } else {
//            highscoreLabel.text = "0"
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startSequenceTimer()
    }
    
    /* ------------------
       Handle button down
       ------------------ */
    @IBAction func yellowButtonDown(_ sender: UIButton) {
        
        if blueButton.isHighlighted == true {
            if choice != 0 && choice == 5{
                choice -= 1
            }
        }
        if redButton.isHighlighted == true {
            if choice != 0 && choice == 5{
                choice -= 4
            }
        }
        if choice == 0 || choice == 1 || choice == 4 {
        choice += 2
        }
    
//        print(choice)
        updateInfoImage()
    }
    @IBAction func redButtonDown(_ sender: UIButton) {
        
        if yellowButton.isHighlighted == true {
            if choice != 0 && choice == 6 {
                choice -= 4
            }
        }
        if blueButton.isHighlighted == true {
            if choice != 0 && choice == 6{
                choice -= 2
            }
        }
        if choice == 0 || choice == 2 || choice == 4 {
        choice += 1
        }
    
//        print(choice)
        updateInfoImage()
    }
    @IBAction func blueButtonDown(_ sender: UIButton) {
       
        if yellowButton.isHighlighted == true {
            if choice != 0 && choice == 3{
                choice -= 1
            }
        }
        if redButton.isHighlighted == true {
            if choice != 0 && choice == 3{
                choice -= 2
            }
        }
        if choice == 0 || choice == 1 || choice == 2 {
        choice += 4
        }
    
//        print(choice)
        updateInfoImage()
    }
    
    /* --------------------
       Handle button clicks
       -------------------- */
    @IBAction func yelloButtonClick(_ sender: UIButton) {
        btnYellowLastPressed = getCurrentMilliseconds()
        choice -= 2
        updateInfoImage()
//        startChoice()
        startButtonStatusTimer()
        
    }
    
    @IBAction func redButtonClick(_ sender: UIButton) {
        btnRedLastPressed = getCurrentMilliseconds()
        choice -= 1
        updateInfoImage()
//        startChoice()
        startButtonStatusTimer()
        
    }
    
    @IBAction func blueButtonClick(_ sender: UIButton) {
        btnBlueLastPressed = getCurrentMilliseconds()
        choice -= 4
        updateInfoImage()
//        startChoice()
        startButtonStatusTimer()
        
    }
    
    /* -----------------------------
       Handle drag out/in on buttons
       ----------------------------- */
    @IBAction func yellowButtonDragEnter(_ sender: UIButton) {
//        btnYellowDown = true
//        print("YellowEnter")
        choice += 2
        updateInfoImage()
    }
    
    @IBAction func yellowButtonDragExit(_ sender: UIButton) {
//        btnYellowDown = false
//        print("YellowExit")
        choice -= 2
        updateInfoImage()
    }
    
    @IBAction func redButtonDragEnter(_ sender: UIButton) {
//        btnRedDown = true
//        print("RedEnter")
        choice += 1
        updateInfoImage()
    }
    @IBAction func redButtonDragExit(_ sender: UIButton) {
//        btnRedDown = false
//        print("RedExit")
        choice -= 1
        updateInfoImage()
    }
    
    @IBAction func blueButtonDragEnter(_ sender: UIButton) {
//        btnBlueDown = true
//        print("BlueEnter")
        choice += 4
        updateInfoImage()
    }
    
    @IBAction func blueButtonDragExit(_ sender: UIButton) {
//        btnBlueDown = false
//        print("BlueExit")
        choice -= 4
        updateInfoImage()
    }
 
    @IBAction func updateTextField(_ sender: UIButton) {
//        infoTextField.text = game.getPlayer().getPlayerMovesAsString()
    }
    
    
    
    func updateInfoImage(){
        // Update the infoimage with the right button combination
        switch choice {
        case 0:
            infoImage.image = #imageLiteral(resourceName: "ButtonOff")
//            print("Off")
            break
        case 1:
            infoImage.image = #imageLiteral(resourceName: "RedOn")
//            print("redDown")
            break
        case 2:
            infoImage.image = #imageLiteral(resourceName: "YellowOn")
//            print("YellowDown")
            break
        case 3:
            infoImage.image = #imageLiteral(resourceName: "OrangeOn")
//            print("OrangeDown")
            break
        case 4:
            infoImage.image = #imageLiteral(resourceName: "BlueOn")
//            print("BlueDown")
            break
        case 5:
            infoImage.image = #imageLiteral(resourceName: "PurpleOn")
//            print("PurpleDown")
            break
        case 6:
            infoImage.image = #imageLiteral(resourceName: "GreenOn")
//            print("GreenDown")
            break
        default:
            break
            
        }
    }
    
    func startButtonStatusTimer(){
        // timer for buttonstatus
        if buttonCheckTimer == nil {
            buttonCheckTimer =  Timer.scheduledTimer(
                timeInterval: TimeInterval(0.1),
                target      : self,
                selector    : #selector(checkButtonStatus),
                userInfo    : nil,
                repeats     : true)
        }
    }
    
    func stopCheckButtonStatusTimer(){
        if buttonCheckTimer != nil {
            buttonCheckTimer?.invalidate()
            buttonCheckTimer = nil
        }
    }
    
    func checkButtonStatus(){
        // Checking to see that all buttons are released before checking button combination
        if yellowButton.isHighlighted == false && redButton.isHighlighted == false && blueButton.isHighlighted == false {
            addChoice()
            stopCheckButtonStatusTimer()
//            startChoice()
        }
    }
    
//    func startChoice(){
//        print("Yellow: \(yellowButton.isHighlighted)")
//        print("Red: \(redButton.isHighlighted)")
//        print("Blue: \(blueButton.isHighlighted)")
//        
////        if yellowButton.isHighlighted == false && redButton.isHighlighted == false && blueButton.isHighlighted == false {
//            if choiceTimer == nil {
//                choiceTimer =  Timer.scheduledTimer(
//                    timeInterval: TimeInterval(),
//                    target      : self,
//                    selector    : #selector(addChoice),
//                    userInfo    : nil,
//                    repeats     : false)
//            }
////        }
//    }
//    
//    func stopChoice(){
//        if choiceTimer != nil {
//            choiceTimer?.invalidate()
//            choiceTimer = nil
//        }
//    }
    
    func addChoice(){
        var button = 0
//        print("YellowTime: \(btnYellowLastPressed)")
//        print("RedTime: \(btnRedLastPressed)")
//        print("BlueTime: \(btnBlueLastPressed)")
        
        if btnYellowLastPressed >= btnRedLastPressed && btnYellowLastPressed >= btnBlueLastPressed {
            button = 2
            if btnYellowLastPressed - btnRedLastPressed < maxDiffInMs {
                button = 3
            }else if btnYellowLastPressed - btnBlueLastPressed < maxDiffInMs {
                button = 6
            }
        }
        
        if btnRedLastPressed >= btnYellowLastPressed && btnRedLastPressed >= btnBlueLastPressed {
            button = 1
            if btnRedLastPressed - btnYellowLastPressed < maxDiffInMs {
                button = 3
            } else if btnRedLastPressed - btnBlueLastPressed < maxDiffInMs {
                button = 5
            }
        }
        
        if btnBlueLastPressed >= btnYellowLastPressed && btnBlueLastPressed >= btnRedLastPressed {
            button = 4
            if btnBlueLastPressed - btnYellowLastPressed < maxDiffInMs {
                button = 6
            } else if btnBlueLastPressed - btnRedLastPressed < maxDiffInMs {
                button = 5
            }
        }
        
        updateInfoImage()
        
//        if (yellowButton.isHighlighted == false && redButton.isHighlighted == false && blueButton.isHighlighted == false){
        
        game.getPlayer().addMove(choice: button)
        
    //        print(game.getPlayer().getPlayerMoves())
        
        choice = 0
        infoImage.image = #imageLiteral(resourceName: "ButtonOff")
        updateInfoImage()
        checkRound()
        
//        }
//        stopChoice()
    }
    
    
    
    func startSequenceTimer () {
        //        print("Starting timer")
        infoLabel.text = "Niru says"
        if sequenceTimer == nil {
            redButton.isUserInteractionEnabled = false
            yellowButton.isUserInteractionEnabled = false
            blueButton.isUserInteractionEnabled = false
//            greenButton.isUserInteractionEnabled = false
            
            sequenceTimer =  Timer.scheduledTimer(
                timeInterval: TimeInterval(0.5),
                target      : self,
                selector    : #selector(showSequence),
                userInfo    : nil,
                repeats     : true)
        }
    }
    
    func stopSequenceTimer() {
        if sequenceTimer != nil {
            sequenceTimer?.invalidate()
            sequenceTimer = nil
            //            print("Stopping timer")
            redButton.isUserInteractionEnabled = true
            yellowButton.isUserInteractionEnabled = true
            blueButton.isUserInteractionEnabled = true
//            greenButton.isUserInteractionEnabled = true
            infoLabel.text = "Your turn!"
        }
    }
    func showSequence() {
//                print("Change")
        if infoImage.image != #imageLiteral(resourceName: "ButtonOff") {
            infoImage.image = #imageLiteral(resourceName: "ButtonOff")
//                        print("Reset")
            if arrayCounter > game.getBoard().getMove().count - 1{
                stopSequenceTimer()
                //                print("Stopping timer")
                arrayCounter = 0
            }

        } else {
            if game.getBoard().getMove()[arrayCounter] == 1{
                infoImage.image = #imageLiteral(resourceName: "RedOn")
//                                        print("Red")
            }
            
            if game.getBoard().getMove()[arrayCounter] == 2{
                infoImage.image = #imageLiteral(resourceName: "YellowOn")
//                                        print("Yellow")
            }
            
            if game.getBoard().getMove()[arrayCounter] == 3{
                infoImage.image = #imageLiteral(resourceName: "OrangeOn")
//                                        print("Orange")
            }
            
            if game.getBoard().getMove()[arrayCounter] == 4{
                infoImage.image = #imageLiteral(resourceName: "BlueOn")
//                                        print("Blue")
            }
            
            if game.getBoard().getMove()[arrayCounter] == 5{
                infoImage.image = #imageLiteral(resourceName: "PurpleOn")
//                                        print("Purple")
            }
            
            if game.getBoard().getMove()[arrayCounter] == 6{
                infoImage.image = #imageLiteral(resourceName: "GreenOn")
//                                        print("Green")
            }
            arrayCounter += 1
        }     
    }
    
    func storeHighscore() {
        let highscore = UserDefaults()
        
        if (highscore.string(forKey: "HardHighscore") != nil){
            let storedScore: Int = Int(highscore.string(forKey: "HardHighscore")!)!
            let score: Int = Int(scoreLabel.text!)!
            //            print(storedScore)
            //            print(score)
            if (storedScore < score){
                highscore.setValue(scoreLabel.text, forKey: "HardHighscore")
                highscore.synchronize()
            }
        }else{
            highscore.setValue(scoreLabel.text, forKey: "HardHighscore")
            highscore.synchronize()
        }
    }
    
    func checkRound() {
        //        print(board.getMove())
//                print(game.getPlayer().getPlayerMoves())
        if !game.checkPlayerMoves() {
            //            print("Wrong")
            self.game.getBoard().resetMoves()
            self.game.getPlayer().resetPlayerMoves()
            let message = UIAlertController(title: "Wrong move!", message: "Retry?", preferredStyle: UIAlertControllerStyle.alert)
            message.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                self.storeHighscore()
                self.game.getBoard().resetMoves()
                self.game.getPlayer().resetPlayerMoves()
                self.performSegue(withIdentifier: "fromHard", sender: self)
            }))
            
            message.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                self.storeHighscore()
                self.game.getBoard().resetMoves()
                self.scoreLabel.text = "0"
                self.game.getPlayer().resetPlayerMoves()
//                self.colorTextField.text = self.game.getBoard().getMovesAsString()
                self.startSequenceTimer()
            }))
            
            present(message, animated: true, completion: nil)
            
        } else if game.checkEndOfRound() {
            //            print("CORRECT!!!")
            if game.getVibrateStatus(){
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
            scoreLabel.text = String(game.getBoard().getMove().count)
            game.getPlayer().resetPlayerMoves()
            game.getBoard().addNextMove()
            startSequenceTimer()
            
        }
    }
    
    func getCurrentMilliseconds()->Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}
