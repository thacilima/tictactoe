//
//  Robot.swift
//  TicTacToe
//
//  Created by Thaciana Lima on 19/08/17.
//  Copyright © 2017 TL. All rights reserved.
//

import Foundation

class Robot: Player {
    
    func play(onGameBoard gameBoard: GameBoard) -> Position {
        return playRandom(onGameBoard: gameBoard)
    }
    
    func playOnFirstEmptyPosition(onGameBoard gameBoard: GameBoard) -> Position {
        let emptyPositions = gameBoard.getAllEmptyPositions()
        
        guard emptyPositions.count > 0 else {
            fatalError()
        }
        
        return emptyPositions[0]
    }
    
    func playRandom(onGameBoard gameBoard: GameBoard) -> Position {
        let emptyPositions = gameBoard.getAllEmptyPositions()
        let randomIndex = Int(arc4random_uniform(UInt32(emptyPositions.count)))
        
        return emptyPositions[randomIndex]
    }
}
