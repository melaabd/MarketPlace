//
//  SearchHistoryTVCell.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import UIKit

class SearchHistoryTVCell: UITableViewCell, TVCell {
    
    static var identifier: String = "SearchHistoryCVCell"
    var removeItemCompletion: Completion?
    
    var cellVM: SearchHistoryCellVM? {
        didSet {
            fillData()
        }
    }
    
    
    lazy private var historyStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    lazy private var titleLabe: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .txt
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy private var removeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.tintColor = .red
        return button
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        selectionStyle = .none
        setupViews()
    }
    
    func setupViews() {
        
        contentView.addSubview(historyStack)
        historyStack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        historyStack.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 5).isActive = true
        historyStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5).isActive = true
        historyStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        historyStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        removeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        removeButton.addTarget(self, action: #selector(removeBtnAction), for: .touchUpInside)

        [titleLabe, removeButton].forEach {
            historyStack.addArrangedSubview($0)
        }
    }
    
    func fillData() {
        GCD.onMain { [weak self] in
            guard let self = self, let vm = self.cellVM else { return }
            self.titleLabe.text = vm.title
        }
    }
    
    
    @objc func removeBtnAction() {
        removeItemCompletion?()
    }
    
}

