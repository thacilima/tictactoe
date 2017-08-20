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
        
        if let defensePosition = findDefense(onGameBoard: gameBoard) {
            return defensePosition
        }
        
        if let attachPosition = findAttach(onGameBoard: gameBoard) {
            return attachPosition
        }
        
        return playRandom(onGameBoard: gameBoard)
    }
    
    private func findAttach(onGameBoard gameBoard: GameBoard) -> Position? {
        let myPositions = gameBoard.getPositions(forPlayer: label)
        return findThreat(onGameBoard: gameBoard, positionsToSearch: myPositions)
    }
    
    private func findDefense(onGameBoard gameBoard: GameBoard) -> Position? {
        let opponentPositions = gameBoard.getOpponentPositions(forPlayer: label)
        return findThreat(onGameBoard: gameBoard, positionsToSearch: opponentPositions)
    }
    
    private func findThreat(onGameBoard gameBoard: GameBoard, positionsToSearch: [Position]) -> Position? {

        if let lineThreat = findLineThreat(onGameBoard: gameBoard, positionsToSearch: positionsToSearch) {
            return lineThreat
        }
        if let columnThreat = findColunmThreat(onGameBoard: gameBoard, positionsToSearch: positionsToSearch) {
            return columnThreat
        }
        if let mainDiagonalThreat = findMainDiagonalThreat(onGameBoard: gameBoard, positionsToSearch: positionsToSearch) {
            return mainDiagonalThreat
        }
        if let secondaryDiagonalThreat = findSecondaryDiagonalThreat(onGameBoard: gameBoard, positionsToSearch: positionsToSearch) {
            return secondaryDiagonalThreat
        }
        
        return nil
    }
    
    private func findLineThreat(onGameBoard gameBoard: GameBoard, positionsToSearch: [Position]) -> Position? {
        for line in 0..<gameBoard.gameBoardSize {
            if let threatPosition = findThreat(onGameBoard: gameBoard, positionsToSearch: positionsToSearch, threatCondition: { $0.x == line }) {
                return threatPosition
            }
        }
        return nil
    }
    
    private func findColunmThreat(onGameBoard gameBoard: GameBoard, positionsToSearch: [Position]) -> Position? {
        for colunm in 0..<gameBoard.gameBoardSize {
            if let threatPosition = findThreat(onGameBoard: gameBoard, positionsToSearch: positionsToSearch, threatCondition: { $0.y == colunm }) {
                return threatPosition
            }
        }
        return nil
    }
    
    private func findMainDiagonalThreat(onGameBoard gameBoard: GameBoard, positionsToSearch: [Position]) -> Position? {
        return findThreat(onGameBoard: gameBoard, positionsToSearch: positionsToSearch, threatCondition: { $0.x == $0.y })
    }
    
    private func findSecondaryDiagonalThreat(onGameBoard gameBoard: GameBoard, positionsToSearch: [Position]) -> Position? {
        return findThreat(onGameBoard: gameBoard, positionsToSearch: positionsToSearch, threatCondition: { $0.x + $0.y == gameBoard.gameBoardSize - 1 })
    }
    
    private func findThreat(onGameBoard gameBoard: GameBoard, positionsToSearch: [Position], threatCondition: (Position) -> Bool) -> Position? {
        let emptyPositions = gameBoard.getEmptyPositions()
        
        if positionsToSearch.filter(threatCondition).count == gameBoard.gameBoardSize-1 {
            if let threatPosition = emptyPositions.filter(threatCondition).first {
                return threatPosition
            }
        }
        
        return nil
    }
}
