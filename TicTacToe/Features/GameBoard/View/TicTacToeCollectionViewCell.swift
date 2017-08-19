//
//  TicTacToeCollectionViewCell.swift
//  TicTacToe
//
//  Created by Thaciana Lima on 19/08/17.
//  Copyright © 2017 TL. All rights reserved.
//

import UIKit

class TicTacToeCollectionViewCell: UICollectionViewCell {
    
    func fillWith(label: String) {
        
        
        let size = bounds.size.width/2
        let origin = size/2
        
        let path = UIBezierPath(ovalIn: CGRect(x: origin, y: origin, width: size, height: size))
        
        let pathLayer = CAShapeLayer()
        pathLayer.frame = bounds
        pathLayer.path = path.cgPath
        pathLayer.strokeColor = Colors.secondaryGreen.cgColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 6
        layer.addSublayer(pathLayer)
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 0.2
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        pathLayer.add(pathAnimation, forKey: "strokeEnd")
    }
}
