//
//  TVCell.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import Foundation

protocol TVCell {

    /// Cell Identifier to be used with UITableView Delegate
    static var identifier:  String { get }

    /// Initial view setup
    func setupViews()

    /// Required method to be called, useful to be called when viewModel didSet
    func fillData()
}
