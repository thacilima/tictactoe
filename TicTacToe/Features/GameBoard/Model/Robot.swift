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
        switch gameBoard.getPositions(forPlayer: label).count {
        case 0:
            return playRandom(onGameBoard: gameBoard)
        default:
            return playLookingForCheckMateAndCheckPositions(onGameBoard: gameBoard)
        }
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
    
    func playLookingForCheckMateAndCheckPositions(onGameBoard gameBoard: GameBoard) -> Position {
        
        if let defenseCheckmatePosition = findDefenseCheckmatePosition(onGameBoard: gameBoard) {
            return defenseCheckmatePosition
        }
        
        if let attackCheckmatePosition = findAttackCheckmatePosition(onGameBoard: gameBoard) {
            return attackCheckmatePosition
        }
        
        if let attackCheckPosition = findAttackCheckPosition(onGameBoard: gameBoard) {
            return attackCheckPosition
        }
        
        return playRandom(onGameBoard: gameBoard)
    }
    
    private func findAttackCheckPosition(onGameBoard gameBoard: GameBoard) -> Position? {
        let myPositions = gameBoard.getPositions(forPlayer: label)
        let emptyPositions = gameBoard.getEmptyPositions()
        
        for position in myPositions {
            if let lineCheckPosition = findLineEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: emptyPositions, line: position.x) {
                return lineCheckPosition
            }
            
            if let columnCheckPosition = findColunmEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: emptyPositions, colunm: position.y) {
                return columnCheckPosition
            }
            
            if position.x == position.y {
                if let mainDiagonalCheckPosition = findMainDiagonalEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: emptyPositions) {
                    return mainDiagonalCheckPosition
                }
            }
            
            if position.x + position.y == gameBoard.gameBoardSize - 1 {
                if let secondaryDiagonalCheckPosition = findSecondaryDiagonalEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: emptyPositions) {
                    return secondaryDiagonalCheckPosition
                }
            }
        }
        
        return nil
    }
    
    private func findAttackCheckmatePosition(onGameBoard gameBoard: GameBoard) -> Position? {
        let myPositions = gameBoard.getPositions(forPlayer: label)
        return findCheckmatePosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: myPositions)
    }
    
    private func findDefenseCheckmatePosition(onGameBoard gameBoard: GameBoard) -> Position? {
        let opponentPositions = gameBoard.getOpponentPositions(forPlayer: label)
        return findCheckmatePosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: opponentPositions)
    }
    
    private func findCheckmatePosition(onGameBoard gameBoard: GameBoard, positionsToSearchTwoObjects: [Position]) -> Position? {

        if let lineCheckMatePosition = findLineEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: positionsToSearchTwoObjects) {
            return lineCheckMatePosition
        }
        if let columnCheckMatePosition = findColunmEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: positionsToSearchTwoObjects) {
            return columnCheckMatePosition
        }
        if let mainDiagonalCheckMatePosition = findMainDiagonalEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: positionsToSearchTwoObjects) {
            return mainDiagonalCheckMatePosition
        }
        if let secondaryDiagonalCheckMatePosition = findSecondaryDiagonalEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: positionsToSearchTwoObjects) {
            return secondaryDiagonalCheckMatePosition
        }
        
        return nil
    }
    
    private func findLineEmptyPosition(onGameBoard gameBoard: GameBoard, positionsToSearchTwoObjects: [Position]) -> Position? {
        
        for line in 0..<gameBoard.gameBoardSize {
            if let threatPosition = findLineEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: positionsToSearchTwoObjects, line: line) {
                return threatPosition
            }
        }
        return nil
    }
    
    private func findLineEmptyPosition(onGameBoard gameBoard: GameBoard, positionsToSearchTwoObjects: [Position], line: Int) -> Position? {
        
        return findEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: positionsToSearchTwoObjects, condition: { $0.x == line })
    }
    
    private func findColunmEmptyPosition(onGameBoard gameBoard: GameBoard, positionsToSearchTwoObjects: [Position]) -> Position? {
        
        for colunm in 0..<gameBoard.gameBoardSize {
            if let threatPosition = findColunmEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: positionsToSearchTwoObjects, colunm: colunm) {
                return threatPosition
            }
        }
        return nil
    }
    
    private func findColunmEmptyPosition(onGameBoard gameBoard: GameBoard, positionsToSearchTwoObjects: [Position], colunm: Int) -> Position? {
        
        return findEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: positionsToSearchTwoObjects, condition: { $0.y == colunm })
    }
    
    private func findMainDiagonalEmptyPosition(onGameBoard gameBoard: GameBoard, positionsToSearchTwoObjects: [Position]) -> Position? {
        
        return findEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: positionsToSearchTwoObjects, condition: { $0.x == $0.y })
    }
    
    private func findSecondaryDiagonalEmptyPosition(onGameBoard gameBoard: GameBoard, positionsToSearchTwoObjects: [Position]) -> Position? {
        
        return findEmptyPosition(onGameBoard: gameBoard, positionsToSearchTwoObjects: positionsToSearchTwoObjects, condition: { $0.x + $0.y == gameBoard.gameBoardSize - 1 })
    }
    
    private func findEmptyPosition(onGameBoard gameBoard: GameBoard, positionsToSearchTwoObjects: [Position], condition: (Position) -> Bool) -> Position? {
        
        let emptyPositions = gameBoard.getEmptyPositions()
        
        if positionsToSearchTwoObjects.filter(condition).count == gameBoard.gameBoardSize-1 {
            if let threatPosition = emptyPositions.filter(condition).first {
                return threatPosition
            }
        }
        
        return nil
    }
}
