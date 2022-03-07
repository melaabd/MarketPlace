//
//  AppTheme.swift
//  MarketPlace
//
//  Created by melaabd on 3/6/22.
//

import UIKit

/// App back ground theme
protocol AppTheme: UIViewController {
    func setUpBG(title: String, isLarge:Bool)
}

extension AppTheme {
    /// set attrebutes for view title and default background
    /// - Parameter title: `String`
    func setUpBG(title: String = "", isLarge:Bool = true) {
        view.backgroundColor = .backG
        self.title = title
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.prime,
        ]
        navigationController?.navigationBar.prefersLargeTitles = isLarge
        
        let backGroundImgView = UIImageView()
        view.addSubview(backGroundImgView)
        backGroundImgView.translatesAutoresizingMaskIntoConstraints = false
        backGroundImgView.heightAnchor.constraint(equalToConstant: Utils.heightRatio(238)).isActive = true
        backGroundImgView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backGroundImgView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGroundImgView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backGroundImgView.image = Assets.background.image
        
    }
}
