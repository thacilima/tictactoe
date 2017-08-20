//
//  Judge.swift
//  TicTacToe
//
//  Created by Thaciana Lima on 19/08/17.
//  Copyright © 2017 TL. All rights reserved.
//

import Foundation

class Judge {
    
    private let gameBoardSize = 3
    
    func createGameBoard() -> GameBoard {
        var gameBoard: GameBoard = []
        for line in 0..<gameBoardSize {
            var lineArray: [Position] = []
            for column in 0..<gameBoardSize {
                let position = Position(x: line, y: column)
                lineArray.append(position)
            }
            gameBoard.append(lineArray)
        }
        return gameBoard
    }
    
    func isWinner(onGameBoard gameBoard: GameBoard, lastPlayPosition: Position) -> Bool {
        
        if isColunmWinner(onGameBoard: gameBoard, lastPlayPosition: lastPlayPosition) {
            return true
        }
        if isLineWinner(onGameBoard: gameBoard, lastPlayPosition: lastPlayPosition) {
            return true
        }
        if isMainDiagonalWinner(onGameBoard: gameBoard, lastPlayPosition: lastPlayPosition) {
            return true
        }
        if isSecondaryDiagonalWinner(onGameBoard: gameBoard, lastPlayPosition: lastPlayPosition) {
            return true
        }
        
        return false
    }
    
    func shouldKeepPlaying(onGameBoard gameBoard: GameBoard) -> Bool {
        for line in 0..<gameBoard.count {
            for column in 0..<gameBoard[line].count {
                let position = gameBoard[line][column]
                if position.playerOwner == nil {
                    return true
                }
            }
        }
        return false
    }
    
    private func isColunmWinner(onGameBoard gameBoard: GameBoard, lastPlayPosition: Position) -> Bool {
        
        let playerLabel = lastPlayPosition.playerOwner
        let playerColunm = lastPlayPosition.y
        
        for line in 0..<gameBoardSize {
            guard gameBoard[line][playerColunm].playerOwner == playerLabel else {
                return false
            }
        }
        
        return true
    }
    
    private func isLineWinner(onGameBoard gameBoard: GameBoard, lastPlayPosition: Position) -> Bool {
        
        let playerLabel = lastPlayPosition.playerOwner
        let playerLine = lastPlayPosition.x
        
        for column in 0..<gameBoardSize {
            guard gameBoard[playerLine][column].playerOwner == playerLabel else {
                return false
            }
        }
        
        return true
    }
    
    private func isMainDiagonalWinner(onGameBoard gameBoard: GameBoard, lastPlayPosition: Position) -> Bool {
        
        let playerLabel = lastPlayPosition.playerOwner
        let playerLine = lastPlayPosition.x
        let playerColunm = lastPlayPosition.y
        
        guard playerLine == playerColunm else {
            return false
        }
        
        for index in 0..<gameBoardSize {
            guard gameBoard[index][index].playerOwner == playerLabel else {
                return false
            }
        }
        
        return true
    }
    
    private func isSecondaryDiagonalWinner(onGameBoard gameBoard: GameBoard, lastPlayPosition: Position) -> Bool {
        
        let playerLabel = lastPlayPosition.playerOwner
        let playerLine = lastPlayPosition.x
        let playerColunm = lastPlayPosition.y
        
        guard playerLine+playerColunm == gameBoardSize-1 else {
            return false
        }
        
        var i = 0
        var j = gameBoardSize-1
        while j >= 0 {
            guard gameBoard[i][j].playerOwner == playerLabel else {
                return false
            }
            i += 1
            j -= 1
        }
        
        return true
    }
}
