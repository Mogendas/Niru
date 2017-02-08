//
//  BoardController.swift
//  Simon
//
//  Created by Johan Wejdenstolpe on 2017-01-12.
//  Copyright © 2017 Johan Wejdenstolpe. All rights reserved.
//

import UIKit
import AudioToolbox

class BoardController: UIViewController {
    
    //let player = Player()
    let game = Game(inMaxRandomNumber: 4)
    var arrayCounter = 0
    var myTimer: Timer?
    
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var redButton: UIButton!

    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //colorTextField.text = board.getMovesAsString()
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startTimer()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnGreenDown(_ sender: Any) {
//        colorTextField.text = "Green"
    }
    @IBAction func greenClick(_ sender: Any) {
        //Green click
        game.getPlayer().addMove(choice: 6)
        checkRound()
        
    }
    
    @IBAction func btnRedDown(_ sender: Any) {
//        colorTextField.text = "Red"
    }
    
    @IBAction func redClick(_ sender: Any) {
        //Red click
        game.getPlayer().addMove(choice: 1)
        checkRound()
    }

    @IBAction func btnYellowClick(_ sender: Any) {
        //Yellow click
        game.getPlayer().addMove(choice: 2)
        checkRound()
    }
    

    @IBAction func btnYellowDown(_ sender: Any) {
//        colorTextField.text = "Yellow"
    }
    
    @IBAction func btnBlueDown(_ sender: Any) {
//        colorTextField.text = "Blue"
    }
    
    @IBAction func blueClick(_ sender: Any) {
        //blueClick
        game.getPlayer().addMove(choice: 4)
        checkRound()
    }
    @IBAction func resetTextField(_ sender: UIButton) {
//        print(board.getPlayer().getPlayerMoves())
        //colorTextField.text = board.getMovesAsString()
    }
    
    func startTimer () {
//        print("Starting timer")
        infoLabel.text = "Niru says"
        if myTimer == nil {
            redButton.isUserInteractionEnabled = false
            yellowButton.isUserInteractionEnabled = false
            blueButton.isUserInteractionEnabled = false
            greenButton.isUserInteractionEnabled = false
            
            myTimer =  Timer.scheduledTimer(
                timeInterval: TimeInterval(0.5),
                target      : self,
                selector    : #selector(showSequence),
                userInfo    : nil,
                repeats     : true)
        }
    }
    
    func stopTimer() {
        if myTimer != nil {
            myTimer?.invalidate()
            myTimer = nil
//            print("Stopping timer")
            redButton.isUserInteractionEnabled = true
            yellowButton.isUserInteractionEnabled = true
            blueButton.isUserInteractionEnabled = true
            greenButton.isUserInteractionEnabled = true
            infoLabel.text = "Your turn!"
        }
    }
    func showSequence() {
//        print("Change")
        if redButton.isHighlighted == true || yellowButton.isHighlighted == true || blueButton.isHighlighted == true || greenButton.isHighlighted == true {
            redButton.isHighlighted = false
            yellowButton.isHighlighted = false
            blueButton.isHighlighted = false
            greenButton.isHighlighted = false
//            print("Reset")
            if arrayCounter > game.getBoard().getMove().count - 1 {
                stopTimer()
                //                print("Stopping timer")
                arrayCounter = 0
            }

        } else {
            if game.getBoard().getMove()[arrayCounter] == 1{
                redButton.isHighlighted = true
//                    print("Red")
            }
            
            if game.getBoard().getMove()[arrayCounter] == 2{
                yellowButton.isHighlighted = true
//                    print("Yellow")
            }
            
            if game.getBoard().getMove()[arrayCounter] == 4{
                blueButton.isHighlighted = true
//                    print("Blue")
            }
            
            if game.getBoard().getMove()[arrayCounter] == 6{
                greenButton.isHighlighted = true
//                    print("Green")
            }
//                print("Arraycounter = \(arrayCounter)")
//                print(board.getMove().count)
            
            arrayCounter += 1
        }
    }
    
    func storeHighscore() {
        let highscore = UserDefaults()
        
        if (highscore.string(forKey: "NormalHighscore") != nil){
            let storedScore: Int = Int(highscore.string(forKey: "NormalHighscore")!)!
            let score: Int = Int(scoreLabel.text!)!
//            print(storedScore)
//            print(score)
            if (storedScore < score){
                highscore.setValue(scoreLabel.text, forKey: "NormalHighscore")
                highscore.synchronize()
            }
        }else{
            highscore.setValue(scoreLabel.text, forKey: "NormalHighscore")
            highscore.synchronize()
        }
    }
    
    func checkRound() {
//        print(board.getMove())
//        print(board.getPlayer().getPlayerMoves())
        if !game.checkPlayerMoves() {
//            print("Wrong")
            self.game.getBoard().resetMoves()
            self.game.getPlayer().resetPlayerMoves()
            let message = UIAlertController(title: "Wrong move!", message: "Retry?", preferredStyle: UIAlertControllerStyle.alert)
            message.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                self.storeHighscore()
                self.game.getBoard().resetMoves()
                self.game.getPlayer().resetPlayerMoves()
                self.performSegue(withIdentifier: "toMenu", sender: self)
                }))
            
            message.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                self.storeHighscore()
                self.game.getBoard().resetMoves()
                self.scoreLabel.text = "0"
                self.game.getPlayer().resetPlayerMoves()
                self.colorTextField.text = self.game.getBoard().getMovesAsString()
                self.startTimer()
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
            startTimer()

            }
        }
}
