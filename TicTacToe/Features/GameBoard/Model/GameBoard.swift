//
//  GameBoard.swift
//  TicTacToe
//
//  Created by Thaciana Lima on 20/08/17.
//  Copyright © 2017 TL. All rights reserved.
//

import Foundation

typealias GameBoardPositions = [[Position]]

class GameBoard {
    
    let gameBoardSize: Int
    
    private let positions: GameBoardPositions
    
    private var emptyPositions: [Position] = []
    private var playerXPositions: [Position] = []
    private var playerOPositions: [Position] = []
    
    init(gameBoardSize: Int, positions: [[Position]]) {
        self.gameBoardSize = gameBoardSize
        self.positions = positions
        for linePositions in positions {
            emptyPositions.append(contentsOf: linePositions)
        }
    }
    
    func update(playerOwner: PlayerLabel, x: Int, y: Int) -> Position {
        positions[x][y].playerOwner = playerOwner
        emptyPositions = emptyPositions.filter { !($0.x == x && $0.y == y) }
        
        switch playerOwner {
        case .X:
            playerXPositions.append(positions[x][y])
        default:
            playerOPositions.append(positions[x][y])
        }
        
        return positions[x][y]
    }
    
    func getAllPositions() -> [[Position]] {
        return positions
    }
    
    func getEmptyPositions() -> [Position] {
        return emptyPositions
    }
    
    func getOpponentPositions(forPlayer label: PlayerLabel) -> [Position] {
        switch label {
        case .X:
            return getPositions(forPlayer: .O)
        default:
            return getPositions(forPlayer: .X)
        }
    }
    
    func getPositions(forPlayer label: PlayerLabel) -> [Position] {
        switch label {
        case .X:
            return playerXPositions
        default:
            return playerOPositions
        }
    }
}
