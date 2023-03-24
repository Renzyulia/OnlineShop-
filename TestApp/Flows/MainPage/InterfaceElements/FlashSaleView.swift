//
//  FlashSaleView.swift
//  TestApp
//
//  Created by Yulia Ignateva on 21.03.2023.
//

import UIKit

final class FlashSaleView: UIView {
    private let url: URL
    private let categoryLabelText: String
    private let nameLabelText: String
    private let priceLabelPrice: Double
    private let discount: Int
    
    private let imageView = UIImageView()
    private let iconView = UIImageView(image: UIImage(named: "Icon"))
    private let categoryLabel = UILabel()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let discountLabel = UILabel()
    private let addToFavoritesView = UIImageView(image: UIImage(named: "Favorites"))
    private let addView = UIImageView(image: UIImage(named: "Add"))
    

    
    init(url: URL, categoryLabelText: String, nameLabelText: String, priceLabelPrice: Double, discount: Int) {
        self.url = url
        self.categoryLabelText = categoryLabelText
        self.nameLabelText = nameLabelText
        self.priceLabelPrice = priceLabelPrice
        self.discount = discount
        super.init(frame: .zero)
        
        configureImage()
        configureIconView()
        configureCategoryLabel()
        configureNameLabel()
        configurePriceLabel()
        configureDiscountLabel()
        configureAddView()
        configureAddToFavoritesView()
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
            imageView.widthAnchor.constraint(equalToConstant: 180),
            imageView.heightAnchor.constraint(equalToConstant: 235),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func configureIconView() {
        addSubview(iconView)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 7.5),
            iconView.leftAnchor.constraint(equalTo: leftAnchor, constant: 7.5)
        ])
    }
    
    private func configureCategoryLabel() {
        categoryLabel.text = categoryLabelText
        categoryLabel.textColor = .black
        categoryLabel.font = UIFont.specialFont(size: 9.4, style: .bold)
        categoryLabel.textAlignment = .center
        categoryLabel.backgroundColor = UIColor(named: "LatestCategoryColor")
        categoryLabel.layer.opacity = 85
        categoryLabel.clipsToBounds = true
        categoryLabel.layer.cornerRadius = 5
        
        addSubview(categoryLabel)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.widthAnchor.constraint(equalToConstant: 46.58),
             categoryLabel.heightAnchor.constraint(equalToConstant: 17),
             categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 121),
             categoryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        ])
    }
    
    private func configureNameLabel() {
        nameLabel.text = nameLabelText
        nameLabel.textColor = .black
        nameLabel.font = UIFont.specialFont(size: 13, style: .medium)
        nameLabel.numberOfLines = 0
        
        addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 11.38),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 9.51)
        ])
    }
    
    private func configurePriceLabel() {
        priceLabel.text = "$ \(priceLabelPrice)"
        priceLabel.font = UIFont.specialFont(size: 11.22, style: .bold)
        priceLabel.textColor = .black
        
        addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25.66),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10.53)
        ])
    }
    
    private func configureDiscountLabel() {
        discountLabel.text = "\(discount)% off"
        discountLabel.textColor = .white
        discountLabel.textAlignment = .center
        discountLabel.font = UIFont.specialFont(size: 9.9, style: .bold)
        discountLabel.backgroundColor = UIColor(named: "DiscountLabelColor")
        discountLabel.clipsToBounds = true
        discountLabel.layer.cornerRadius = 9
        
        addSubview(discountLabel)
        
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            discountLabel.widthAnchor.constraint(equalToConstant: 55),
            discountLabel.heightAnchor.constraint(equalToConstant: 18),
            discountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            discountLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ])
    }
    
    private func configureAddView() {
        addSubview(addView)
        
        addView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addView.widthAnchor.constraint(equalToConstant: 35),
            addView.heightAnchor.constraint(equalToConstant: 35),
            addView.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
            addView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7)
        ])
    }
    
    private func configureAddToFavoritesView() {
        addSubview(addToFavoritesView)
        
        addToFavoritesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToFavoritesView.widthAnchor.constraint(equalToConstant: 28),
            addToFavoritesView.heightAnchor.constraint(equalToConstant: 28),
            addToFavoritesView.rightAnchor.constraint(equalTo: addView.leftAnchor, constant: -5),
            addToFavoritesView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
