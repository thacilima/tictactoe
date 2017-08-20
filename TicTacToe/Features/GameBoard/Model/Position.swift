//
//  PositionViewObject.swift
//  TicTacToe
//
//  Created by Thaciana Lima on 19/08/17.
//  Copyright © 2017 TL. All rights reserved.
//

import Foundation

typealias GameBoard = [[Position]]

class Position {
    var playerOwner: PlayerLabel?
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
