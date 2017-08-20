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
        for line in gameBoard {
            for position in line {
                if position.playerOwner == nil {
                    position.playerOwner = self.label
                    return position
                }
            }
        }
        
        fatalError()
    }
}
