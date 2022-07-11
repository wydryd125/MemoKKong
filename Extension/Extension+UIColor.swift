//
//  Extension+UIColor.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import UIKit

extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
    
    class var backgroundColor: UIColor { UIColor(hex: 0xF6F6F6) }
    class var customBlueColor: UIColor { UIColor(hex: 0x5B86B2) }
    class var customDeepPinkColor: UIColor { UIColor(hex: 0x883D58) }
    class var customYellowColor: UIColor { UIColor(hex: 0xDFB076) }
    class var customLightGrayColor: UIColor { UIColor(hex: 0x535353) }
    
        
}
