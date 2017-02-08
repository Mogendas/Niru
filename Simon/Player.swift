//
//  Player.swift
//  Simon
//
//  Created by Johan Wejdenstolpe on 2017-01-13.
//  Copyright © 2017 Johan Wejdenstolpe. All rights reserved.
//

import Foundation

class Player {
    //var name: String
    private var playerMoves = [Int]()
    
    init() {
        //name = inName
    }
    
    func addMove(choice: Int) {
        playerMoves.append(choice)
//        switch choice {
//        case "Green":
//            playerMoves.append(6)
//            break
//        case "Red":
//            playerMoves.append(1)
//            break
//        case "Yellow":
//            playerMoves.append(2)
//            break
//        case "Blue":
//            playerMoves.append(4)
//            break
//        case "Purple":
//            playerMoves.append(5)
//            break
//        case "Orange":
//            playerMoves.append(3)
//            break
//        default:
//            
//            break
//        }
       // playerMoves.append(choice)
    }
    
    func getPlayerMoves() -> [Int] {
        return playerMoves
    }
    
    func getPlayerMovesAsString() -> String {
        var choiceText = ""
        for color in playerMoves {
            choiceText += String(color)
            print(color)
        }
//        print("-")
        return choiceText
    }
    
    func resetPlayerMoves() {
        playerMoves.removeAll()
    }
    
}
