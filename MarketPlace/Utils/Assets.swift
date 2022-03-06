//
//  Assets.swift
//  MarketPlace
//
//  Created by melaabd on 3/6/22.
//

import UIKit

/// commen use Assets in app
enum Assets: String {
    case background
    
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
}
