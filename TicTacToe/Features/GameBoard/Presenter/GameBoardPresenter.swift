//
//  GameBoardPresenter.swift
//  TicTacToe
//
//  Created by Thaciana Lima on 19/08/17.
//  Copyright © 2017 TL. All rights reserved.
//

import Foundation

class GameBoardPresenter {
    
    private weak var view: GameBoardView?
    private let userPlayer = Player(label: .X)
    private let robot = Robot(label: .O)
    private let judge = Judge()
    private var gameBoard: GameBoard = []
    
    func attachView(view: GameBoardView) {
        self.view = view
    }
    
    func startGame() {
        gameBoard = judge.createGameBoard()
        
        var positions:[Position] = []
        for positionsInLine in gameBoard {
            positions.append(contentsOf: positionsInLine)
        }
        view?.setPositions(positions: positions)
    }
}
