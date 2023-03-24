//
//  LatestView.swift
//  TestApp
//
//  Created by Yulia Ignateva on 21.03.2023.
//

import UIKit

final class LatestView: UIView {
    private let url: URL
    private let categoryLabelText: String
    private let nameLabelText: String
    private let priceLabelPrice: Int
    
    private let imageView = UIImageView()
    private let categoryLabel = UILabel()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let addView = UIImageView(image: UIImage(named: "Add"))
    
    init(url: URL, categoryLabelText: String, nameLabelText: String, priceLabelPrice: Int) {
        self.url = url
        self.categoryLabelText = categoryLabelText
        self.nameLabelText = nameLabelText
        self.priceLabelPrice = priceLabelPrice
        super.init(frame: .zero)
        
        configureImage()
        configureCategoryLabel()
        configureNameLabel()
        configurePriceLabel()
        configureAddView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImage() {
        imageView.loadImage(with: url)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 114),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func configureCategoryLabel() {
        categoryLabel.text = categoryLabelText
        categoryLabel.textColor = .black
        categoryLabel.font = UIFont.specialFont(size: 6.5, style: .bold)
        categoryLabel.textAlignment = .center
        categoryLabel.backgroundColor = UIColor(named: "LatestCategoryColor")
        categoryLabel.layer.opacity = 85
        categoryLabel.clipsToBounds = true
        categoryLabel.layer.cornerRadius = 5
        
        addSubview(categoryLabel)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.widthAnchor.constraint(equalToConstant: 40),
            categoryLabel.heightAnchor.constraint(equalToConstant: 12),
            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 91),
            categoryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 7)
        ])
    }
    
    private func configureNameLabel() {
        nameLabel.text = nameLabelText
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.specialFont(size: 9, style: .medium)
        nameLabel.numberOfLines = 0
        
        addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: 70),
            nameLabel.heightAnchor.constraint(equalToConstant: 25.14),
            nameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 2.31),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 7.46)
        ])
    }
    
    private func configurePriceLabel() {
        priceLabel.text = "$ \(priceLabelPrice)"
        priceLabel.font = UIFont.specialFont(size: 8.45, style: .bold)
        priceLabel.textColor = .black
        
        addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7.06),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 7.37)
        ])
    }
    
    private func configureAddView() {
        addSubview(addView)
        
        addView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addView.widthAnchor.constraint(equalToConstant: 20),
            addView.heightAnchor.constraint(equalToConstant: 20),
            addView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            addView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
