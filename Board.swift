//
//  Board.swift
//  Simon
//
//  Created by Johan Wejdenstolpe on 2017-01-13.
//  Copyright © 2017 Johan Wejdenstolpe. All rights reserved.
//

import Foundation
import UIKit

class Board {
    private var move = [Int]()
    let maxRandomNumber: UInt32?
    
    init(inMaxRandomNumber: UInt32) {
        maxRandomNumber = inMaxRandomNumber
        addNextMove()
        //let newPlayer = Player()
        //player = newPlayer
    }
    
    init() {
        maxRandomNumber = 0
        addNextMove()
    }
    
    func addNextMove() {
        let randomNumber = Int(arc4random_uniform(maxRandomNumber!))
//        print("Random \(randomNumber)")
        switch randomNumber {
        case 0:
            move.append(1)
            break
        case 1:
            move.append(2)
            break
        case 2:
            move.append(4)
            break
        case 3:
            move.append(6)
            break
        case 4:
            move.append(3)
            break
        case 5:
            move.append(5)
            break
        default:
            print("ooops")
            break
        }
        
    }
    func getMove() -> [Int] {
        return move
    }
    
//    func getPlayer() -> Player {
//        return player
//    }
    
    func getMovesAsString() -> String {
        var choiceText = ""
        for color in move {
            choiceText += String(color)
            //print(color)
        }
        //        print("-")
        return choiceText
    }
    
//    func checkPlayerMoves() -> Bool {
////        print("Check")
////        print(getPlayer().getPlayerMoves().count)
//        if getPlayer().getPlayerMoves().count <= move.count {
//            for i in (0..<getPlayer().getPlayerMoves().count) {
////                print("Forloop")
//                if player.getPlayerMoves()[i] != move[i]{
////                    print("Do not match")
//                    return false
//                } else {
////                    print("Match")
//                    
//                }
//            }
//        }
//        
//        return true
//    }
    
//    func checkEndOfRound() -> Bool {
//        if getPlayer().getPlayerMoves().count == move.count {
//            return true
//        } else {
//            return false
//        }
//    }
    
    func resetMoves() {
        move.removeAll()
        addNextMove()
    }
    
    
}
