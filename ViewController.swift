//
//  ViewController.swift
//  Simon
//
//  Created by Johan Wejdenstolpe on 2017-01-12.
//  Copyright © 2017 Johan Wejdenstolpe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var highscoreHard: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let highscore = UserDefaults()
        if (highscore.string(forKey: "NormalHighscore") != nil){
            let score: String = highscore.string(forKey: "NormalHighscore")!
            highscoreLabel.text = "Normal: \(score)"
        } else {
            highscoreLabel.text = "Normal: 0"
        }
        
        if (highscore.string(forKey: "HardHighscore") != nil){
            let score: String = highscore.string(forKey: "HardHighscore")!
            highscoreHard.text = "Hard: \(score)"
        } else {
            highscoreHard.text = "Hard: 0"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

