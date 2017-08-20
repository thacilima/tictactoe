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
    private var gameBoard: GameBoard!
    
    func attachView(view: GameBoardView) {
        self.view = view
    }
    
    func startGame() {
        gameBoard = judge.createGameBoard()
        view?.setPositions(positions: gameBoard.getEmptyPositions())
    }
    
    func performUserPlay(position: Position) {
        DispatchQueue.global().async { [weak self] in
            if let this = self {
                this.performPlayBackground(position: position, label: this.userPlayer.label)
            }
        }
    }
    
    fileprivate func performPlayBackground(position: Position, label: PlayerLabel, delay: Bool = false) {
        
        let positionUpdated = gameBoard.update(playerOwner: label, x: position.x, y: position.y)
        
        var seconds = 0
        if delay {
            seconds = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds)) { [weak self] in
            if let this = self {
                this.view?.updatePosition(position: positionUpdated, atIndex: this.convertToIndex(x: position.x, y: position.y, totalPerLine: this.gameBoard.gameBoardSize))
            }
        }
        
        if judge.isWinner(onGameBoard: gameBoard, lastPlayPosition: position) {
            //Show winner
            return
        }
        
        guard judge.shouldKeepPlaying(onGameBoard: gameBoard) else {
            //Show end
            return
        }
        
        if (label == userPlayer.label) {
            performPlayBackground(position: robot.play(onGameBoard: gameBoard), label: robot.label, delay: true)
        }
        else {
            DispatchQueue.main.async { [weak self] in
                self?.view?.isCollectionUserInteractionEnabled(isEnabled: true)
            }
        }
    }
    
    fileprivate func convertToIndex(x: Int, y: Int, totalPerLine: Int) -> Int {
        return (x * totalPerLine) + y
    }
}

