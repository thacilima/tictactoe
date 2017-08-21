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
        view?.update(turnLabel: Strings.startGame)
        view?.update(winnerLabel: "")
    }
    
    func performUserPlay(position: Position) {
        if gameBoard.getAllPositions()[position.x][position.y].playerOwner == nil {
            
            view?.isCollectionUserInteractionEnabled(isEnabled: false)
            view?.update(turnLabel: "")
            
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
                this.view?.updatePosition(position: positionUpdated, atIndex: this.convertToIndex(x: positionUpdated.x, y: positionUpdated.y, totalPerLine: this.gameBoard.gameBoardSize))
            }
        }
        
        usleep(200000)
        if judge.isWinner(onGameBoard: gameBoard, lastPlayPosition: position) {
            var winnerLabel = ""
            switch position.playerOwner! {
            case .X:
                winnerLabel = Strings.xWon
            default:
                winnerLabel = Strings.oWon
            }
            DispatchQueue.main.sync { [weak self] in
                self?.view?.update(turnLabel: Strings.endGame)
                self?.view?.update(winnerLabel: winnerLabel)
            }
            return
        }
        
        guard judge.shouldKeepPlaying(onGameBoard: gameBoard) else {
            DispatchQueue.main.sync { [weak self] in
                self?.view?.update(turnLabel: Strings.endGame)
                self?.view?.update(winnerLabel: Strings.draw)
            }
            return
        }
        
        if (label == userPlayer.label) {
            usleep(200000)
            performPlayBackground(position: robot.play(onGameBoard: gameBoard), label: robot.label, delay: true)
        }
        else {
            DispatchQueue.main.sync { [weak self] in
                self?.view?.isCollectionUserInteractionEnabled(isEnabled: true)
            }
        }
    }
    
    fileprivate func convertToIndex(x: Int, y: Int, totalPerLine: Int) -> Int {
        return (x * totalPerLine) + y
    }
}

