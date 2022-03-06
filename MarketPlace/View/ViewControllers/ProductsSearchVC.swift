//
//  ProductsSearchVC.swift
//  MarketPlace
//
//  Created by melaabd on 3/6/22.
//

import UIKit

class ProductsSearchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBG(title: Strings.searchVCTitle)
    }

}

extension ProductsSearchVC: AppTheme { }
