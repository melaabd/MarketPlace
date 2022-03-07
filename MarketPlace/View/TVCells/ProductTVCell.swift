//
//  ProductTVCell.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import UIKit


class ProductTVCell: UITableViewCell, TVCell {
    
    static var identifier: String = "ProductTVCell"
    
    lazy private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .infoBackG
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return imageView
    }()

    lazy private var producStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .prime
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()

    lazy private var reviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .txt
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    lazy private var USPsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .txt
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    lazy private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()

    lazy private var buyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.tintColor = .prime
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 6
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
        
        contentView.addSubview(containerView)
        containerView.heightAnchor.constraint(equalToConstant: Utils.heightRatio(150)).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        
        
        containerView.addSubview(imgView)
        imgView.widthAnchor.constraint(equalToConstant: Utils.heightRatio(140) * 0.75).isActive = true
        imgView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
        imgView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        imgView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imgView.image = Assets.background.image // as place holder
        
        let infoView = UIView()
        infoView.backgroundColor = .clear
        containerView.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10).isActive = true
        infoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        infoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        infoView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        
        
        infoView.addSubview(producStack)
        producStack.centerYAnchor.constraint(equalTo: infoView.centerYAnchor).isActive = true
        producStack.topAnchor.constraint(greaterThanOrEqualTo: infoView.topAnchor).isActive = true
        producStack.bottomAnchor.constraint(lessThanOrEqualTo: infoView.bottomAnchor).isActive = true
        producStack.leadingAnchor.constraint(equalTo: infoView.leadingAnchor).isActive = true
        producStack.trailingAnchor.constraint(equalTo: infoView.trailingAnchor).isActive = true

        [nameLabel, reviewLabel, USPsLabel, priceLabel, buyButton].forEach {
            producStack.addArrangedSubview($0)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = Assets.background.image
    }
    
    func fillData() {
        /// will be called when data ready
    }

}
