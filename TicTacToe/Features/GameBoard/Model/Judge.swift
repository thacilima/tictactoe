//
//  Judge.swift
//  TicTacToe
//
//  Created by Thaciana Lima on 19/08/17.
//  Copyright © 2017 TL. All rights reserved.
//

import Foundation

class Judge {
    
    func createGameBoard() -> GameBoard {
        let gameBoardSize = 3
        var gameBoardPositions: GameBoardPositions = []
        for line in 0..<gameBoardSize {
            var lineArray: [Position] = []
            for column in 0..<gameBoardSize {
                let position = Position(x: line, y: column)
                lineArray.append(position)
            }
            gameBoardPositions.append(lineArray)
        }
        return GameBoard(gameBoardSize: gameBoardSize, positions: gameBoardPositions)
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
        if gameBoard.getAllEmptyPositions().count > 0 {
            return true
        }
        return false
    }
    
    private func isColunmWinner(onGameBoard gameBoard: GameBoard, lastPlayPosition: Position) -> Bool {
        
        let gameBoardPositions = gameBoard.getAllPositions()
        let playerLabel = lastPlayPosition.playerOwner
        let playerColunm = lastPlayPosition.y
        
        for line in 0..<gameBoard.gameBoardSize {
            guard gameBoardPositions[line][playerColunm].playerOwner == playerLabel else {
                return false
            }
        }
        
        return true
    }
    
    private func isLineWinner(onGameBoard gameBoard: GameBoard, lastPlayPosition: Position) -> Bool {
        
        let gameBoardPositions = gameBoard.getAllPositions()
        let playerLabel = lastPlayPosition.playerOwner
        let playerLine = lastPlayPosition.x
        
        for column in 0..<gameBoard.gameBoardSize {
            guard gameBoardPositions[playerLine][column].playerOwner == playerLabel else {
                return false
            }
        }
        
        return true
    }
    
    private func isMainDiagonalWinner(onGameBoard gameBoard: GameBoard, lastPlayPosition: Position) -> Bool {
        
        let playerLine = lastPlayPosition.x
        let playerColunm = lastPlayPosition.y
        guard playerLine == playerColunm else {
            return false
        }
        
        let playerLabel = lastPlayPosition.playerOwner
        let gameBoardPositions = gameBoard.getAllPositions()
        for index in 0..<gameBoard.gameBoardSize {
            guard gameBoardPositions[index][index].playerOwner == playerLabel else {
                return false
            }
        }
        
        return true
    }
    
    private func isSecondaryDiagonalWinner(onGameBoard gameBoard: GameBoard, lastPlayPosition: Position) -> Bool {
        
        let playerLine = lastPlayPosition.x
        let playerColunm = lastPlayPosition.y
        guard playerLine+playerColunm == gameBoard.gameBoardSize-1 else {
            return false
        }
        
        let playerLabel = lastPlayPosition.playerOwner
        let gameBoardPositions = gameBoard.getAllPositions()
        var i = 0
        var j = gameBoard.gameBoardSize-1
        while j >= 0 {
            guard gameBoardPositions[i][j].playerOwner == playerLabel else {
                return false
            }
            i += 1
            j -= 1
        }
        
        return true
    }
}
