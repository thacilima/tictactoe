//
//  GameBoardView.swift
//  TicTacToe
//
//  Created by Thaciana Lima on 19/08/17.
//  Copyright © 2017 TL. All rights reserved.
//

import Foundation

protocol GameBoardView: class {
    func setPositions(positions: [Position])
    func updatePosition(position: Position, atIndex index: Int)
    func isCollectionUserInteractionEnabled(isEnabled: Bool)
    func update(turnLabel: String)
    func update(winnerLabel: String)
}
