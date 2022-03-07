//
//  AlertDelegate.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import UIKit

/// Protocol for showing a alerts in case error happened
protocol AlertDelegate: UIViewController {
    func alertWith(title:String, msg: String)
}

/// default implementation for alert protocol
extension AlertDelegate {
    func alertWith(title:String = "Error", msg: String) {
        GCD.onMain { [weak self] in
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
            alert.addAction(dismissAction)
            self?.present(alert, animated: true)
        }
    }
}
