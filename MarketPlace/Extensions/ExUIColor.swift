//
//  ExUIColor.swift
//  MarketPlace
//
//  Created by melaabd on 3/6/22.
//

import UIKit

/// design custom colors
extension UIColor {
    
    static let backG = UIColor(hexString: "#D6D3DE")
    static let infoBackG = UIColor(hexString: "#FFFFFF")
    static let prime = UIColor(hexString: "#2388C7")
    static let txt = UIColor(hexString: "#3D4548")
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.currentIndex = hexString.index(hexString.startIndex, offsetBy: 1)
        }
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
