//
//  AppDelegate.swift
//  MarketPlace
//
//  Created by melaabd on 3/6/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initializeRootVC()
        
        return true
    }

    /// set root view controller
    private func initializeRootVC() {
        let navigation = UINavigationController()
        let searchVC = ProductsSearchVC()
        navigation.viewControllers = [searchVC]
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }

}

