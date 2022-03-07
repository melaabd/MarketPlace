//
//  Utils.swift
//  MarketPlace
//
//  Created by melaabd on 3/6/22.
//

import UIKit

typealias StatusCompletion = ((_ isLoading:Bool)->Void)
typealias Completion = (()->Void)

struct Utils {
    
    /// get dynamic height depending on screen height
    /// - Parameter staticHeight: `CGFloat`
    /// - Returns: `CGFloat`
    static func heightRatio(_ staticHeight: CGFloat) -> CGFloat {
        let sh = UIScreen.main.bounds.height
        return (staticHeight/667)*sh
    }
}
