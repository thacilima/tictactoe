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
//        return playRandom(onGameBoard: gameBoard)
        return playLookingForThreat(onGameBoard: gameBoard)
    }
    
    func playOnFirstEmptyPosition(onGameBoard gameBoard: GameBoard) -> Position {
        let emptyPositions = gameBoard.getEmptyPositions()
        
        guard emptyPositions.count > 0 else {
            fatalError()
        }
        
        return emptyPositions[0]
    }
    
    func playRandom(onGameBoard gameBoard: GameBoard) -> Position {
        let emptyPositions = gameBoard.getEmptyPositions()
        let randomIndex = Int(arc4random_uniform(UInt32(emptyPositions.count)))
        
        return emptyPositions[randomIndex]
    }
    
    func playLookingForThreat(onGameBoard gameBoard: GameBoard) -> Position {
        let opponentPositions = gameBoard.getOpponentPositions(forPlayer: label)
        let emptyPositions = gameBoard.getEmptyPositions()
        
        //line threat
        for line in 0..<gameBoard.gameBoardSize {
            if opponentPositions.filter({ $0.x == line }).count == gameBoard.gameBoardSize-1 {
                if let threatPosition = emptyPositions.filter({ $0.x == line }).first {
                    return threatPosition
                }
            }
        }
        
        //colunm threat
        for colunm in 0..<gameBoard.gameBoardSize {
            if opponentPositions.filter({ $0.y == colunm }).count == gameBoard.gameBoardSize-1 {
                if let threatPosition = emptyPositions.filter({ $0.y == colunm }).first {
                    return threatPosition
                }
            }
        }
        
        return playRandom(onGameBoard: gameBoard)
    }
}
