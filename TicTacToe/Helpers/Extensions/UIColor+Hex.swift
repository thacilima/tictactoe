//
//  UIColor+Hex.swift
//  TicTacToe
//
//  Created by Thaciana Lima on 19/08/17.
//  Copyright © 2017 TL. All rights reserved.
//

import UIKit

protocol UIColor_Hex { }

extension UIColor_Hex where Self: UIColor {
    init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

extension UIColor: UIColor_Hex { }

// This way of making an extension prevents all the UIColor class usages on the project to have possible errors when the swift is updated to a new version (if any update make this code to break)
