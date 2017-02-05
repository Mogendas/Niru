//
//  Game.swift
//  Niru
//
//  Created by Johan Wejdenstolpe on 2017-01-23.
//  Copyright © 2017 Johan Wejdenstolpe. All rights reserved.
//

import Foundation

class Game {
    private var board = Board()
    private var player = Player()
    
    init(inMaxRandomNumber: UInt32) {
        let newPlayer = Player()
        player = newPlayer
        let newBoard = Board(inMaxRandomNumber: inMaxRandomNumber)
        board = newBoard
    }
    
    func getPlayer() -> Player {
        return player
    }
    
    func getBoard() -> Board {
        return board
    }
    
    func checkPlayerMoves() -> Bool {
        //        print("Check")
        //        print(getPlayer().getPlayerMoves().count)
        if player.getPlayerMoves().count <= board.getMove().count {
            for i in (0..<getPlayer().getPlayerMoves().count) {
                //                print("Forloop")
                if player.getPlayerMoves()[i] != board.getMove()[i]{
                    //                    print("Do not match")
                    return false
                } else {
                    //                    print("Match")
                    
                }
            }
        }
        
        return true
    }
    
    func checkEndOfRound() -> Bool {
        if player.getPlayerMoves().count == board.getMove().count {
            return true
        } else {
            return false
        }
    }
    
}
