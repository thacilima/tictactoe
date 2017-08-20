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
        
        var positions: [Position] = []
        for positionsInLine in gameBoard {
            positions.append(contentsOf: positionsInLine)
        }
        view?.setPositions(positions: positions)
    }
    
    func performUserPlay(position: Position) {
        performPlay(position: position, label: userPlayer.label)
    }
    
    fileprivate func performPlay(position: Position, label: PlayerLabel) {
        gameBoard[position.x][position.y].playerOwner = label
        
        view?.updatePosition(position: gameBoard[position.x][position.y], atIndex: convertToIndex(x: position.x, y: position.y, totalPerLine: gameBoard.count))
        
        if judge.isWinner(onGameBoard: gameBoard, lastPlayPosition: position) {
            //Show winner
            return
        }
        
        guard judge.shouldKeepPlaying(onGameBoard: gameBoard) else {
            //Show end
            return
        }
        
        performNextPlayIfNeeded(currentPlayPlayerLabel: label)
    }
    
    fileprivate func performNextPlayIfNeeded(currentPlayPlayerLabel label: PlayerLabel) {
        if (label == userPlayer.label) {
            performPlay(position: robot.play(onGameBoard: gameBoard), label: robot.label)
        }
    }
    
    fileprivate func convertToIndex(x: Int, y: Int, totalPerLine: Int) -> Int {
        return (x * totalPerLine) + y
    }
}

