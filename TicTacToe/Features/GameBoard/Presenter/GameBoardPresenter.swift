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
        view?.isCollectionUserInteractionEnabled(isEnabled: true)
    }
    
    func performUserPlay(position: Position) {
        if gameBoard.getAllPositions()[position.x][position.y].playerOwner == nil {
            
            view?.isCollectionUserInteractionEnabled(isEnabled: false)
            
            DispatchQueue.global().async { [weak self] in
                if let this = self {
                    this.performPlayBackground(position: position, label: this.userPlayer.label)
                }
            }
        }
    }
    
    fileprivate func performPlayBackground(position: Position, label: PlayerLabel, delay: Bool = false) {
        
        let positionUpdated = gameBoard.update(playerOwner: label, x: position.x, y: position.y)
        
        DispatchQueue.main.sync { [weak self] in
            if let this = self {
                Timer.scheduledTimer(timeInterval: (delay ? 0.6 : 0), target: this, selector: #selector(this.updatePositionOnView(timer:)), userInfo: positionUpdated, repeats: false)
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
            DispatchQueue.main.sync { [weak self] in
                self?.view?.isCollectionUserInteractionEnabled(isEnabled: true)
            }
        }
    }
    
    @objc fileprivate func updatePositionOnView(timer: Timer) {
        let positionUpdated: Position = timer.userInfo as! Position
        view?.updatePosition(position: positionUpdated, atIndex: convertToIndex(x: positionUpdated.x, y: positionUpdated.y, totalPerLine: gameBoard.gameBoardSize))
    }
    
    fileprivate func convertToIndex(x: Int, y: Int, totalPerLine: Int) -> Int {
        return (x * totalPerLine) + y
    }
}

