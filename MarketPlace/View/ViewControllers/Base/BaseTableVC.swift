//
//  BaseTableVC.swift
//  MarketPlace
//
//  Created by melaabd on 3/6/22.
//

import UIKit
import os

class BaseTableVC: UIViewController {
    
    var safeArea:UILayoutGuide!
    
    lazy var loadingLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .darkGray
        lbl.accessibilityIdentifier = AccessibilityIds.productsSearchLoadingLblId
        lbl.isHidden = true
        return lbl
    }()
    
    lazy var tableView:UITableView = {
        let tableV = UITableView()
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.backgroundColor = .clear
        tableV.showsVerticalScrollIndicator = false
        tableV.separatorStyle = .none
        return tableV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        os_log("didReceiveMemoryWarning")
    }
    
    // MARK: - Setup Views
    func setupViews() {
        safeArea = view.layoutMarginsGuide
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(loadingLbl)
        loadingLbl.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        loadingLbl.heightAnchor.constraint(equalToConstant: 24).isActive = true
        loadingLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loadingLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
    }
    
    /// reload data in table view
    func reloadData() {
        GCD.onMain { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

// MARK: - Conform wiht table view protocols
extension BaseTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - conform wiht commen protocols
extension BaseTableVC: AppTheme, AlertDelegate {}
