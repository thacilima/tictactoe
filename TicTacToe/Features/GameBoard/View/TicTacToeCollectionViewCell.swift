//
//  TicTacToeCollectionViewCell.swift
//  TicTacToe
//
//  Created by Thaciana Lima on 19/08/17.
//  Copyright © 2017 TL. All rights reserved.
//

import UIKit

class TicTacToeCollectionViewCell: UICollectionViewCell {
    
    fileprivate var sequenceOfLayersToAnimate: [CALayer] = []
    fileprivate var addedLayers: [CALayer] = []
    
    func fillWithO() {
        let size = bounds.size.width/2
        let origin = size/2
        
        let bezierPath = UIBezierPath(ovalIn: CGRect(x: origin, y: origin, width: size, height: size))
        
        let pathLayer = createPathLayer(bezierPath: bezierPath, strokeColor: Colors.secondaryLightGreen.cgColor)
        
        sequenceOfLayersToAnimate.append(contentsOf: [pathLayer])
        performNextAnimation()
    }
    
    func fillWithX() {
        let margin = bounds.size.width/4
        let size = bounds.size.width/2
        
        let xyFirstOrigin = margin
        let xyFirstEnd = margin + size
        let firstLinePathLayer = createLinePathLayer(origin: CGPoint(x: xyFirstOrigin, y: xyFirstOrigin), end: CGPoint(x: xyFirstEnd, y: xyFirstEnd))
       
        let xSecondOrigin = margin
        let ySecondOrigin = margin + size
        let xSecondEnd = margin + size
        let ySecondEnd = margin
        let secondLinePathLayer = createLinePathLayer(origin: CGPoint(x: xSecondOrigin, y: ySecondOrigin), end: CGPoint(x: xSecondEnd, y: ySecondEnd))
        
        sequenceOfLayersToAnimate.append(contentsOf: [firstLinePathLayer, secondLinePathLayer])
        performNextAnimation()
    }

    func clear() {
        for layer in addedLayers {
            layer.removeFromSuperlayer()
        }
    }
    
    fileprivate func performNextAnimation() {
        guard let pathLayer = sequenceOfLayersToAnimate.first else {
            return
        }
        sequenceOfLayersToAnimate.remove(at: 0)
        addedLayers.append(pathLayer)
        
        layer.addSublayer(pathLayer)
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 0.2
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        pathAnimation.delegate = self
        pathLayer.add(pathAnimation, forKey: nil)
    }
    
    private func createLinePathLayer(origin: CGPoint, end: CGPoint) -> CAShapeLayer {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: origin)
        bezierPath.addLine(to: end)
        
        return createPathLayer(bezierPath: bezierPath, strokeColor: Colors.secondaryGreen.cgColor)
    }
    
    private func createPathLayer(bezierPath: UIBezierPath, strokeColor: CGColor) -> CAShapeLayer {
        let pathLayer = CAShapeLayer()
        pathLayer.frame = bounds
        pathLayer.path = bezierPath.cgPath
        pathLayer.strokeColor = strokeColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 6
        return pathLayer
    }
}

extension TicTacToeCollectionViewCell: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        performNextAnimation()
    }
}
