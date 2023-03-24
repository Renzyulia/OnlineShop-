//
//  BrandsCell.swift
//  TestApp
//
//  Created by Yulia Ignateva on 22.03.2023.
//

import UIKit

final class BrandsCell: UITableViewCell {
    private let rightLabel = UILabel()
    private let leftLabel = UILabel()
    private let scrollView = UIScrollView()
    private let contentScrollView = UIView()
    private let firstProduct = BrandsView()
    private let secondProduct = BrandsView()
    private let thirdProduct = BrandsView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLeftLabel()
        configureRightLabel()
        configureScrollView()
        configureFirstProduct()
        configureSecondProduct()
        configureThirdProduct()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLeftLabel() {
        leftLabel.text = "Brands"
        leftLabel.textColor = .black
        leftLabel.font = UIFont.specialFont(size: 15, style: .medium)
        
        contentView.addSubview(leftLabel)
        
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.9),
            leftLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 11)
        ])
    }
    
    private func configureRightLabel() {
        rightLabel.text = "View all"
        rightLabel.textColor = UIColor(named: "ViewAllLabel")
        rightLabel.font = UIFont.specialFont(size: 10, style: .medium)
        
        contentView.addSubview(rightLabel)
        
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.9),
            rightLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12.98)
        ])
    }
    
    private func configureScrollView() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        scrollView.showsHorizontalScrollIndicator = false
        
        contentView.addSubview(scrollView)
        scrollView.addSubview(contentScrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: rightLabel.topAnchor, constant: 22.92),
            scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentScrollView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func configureFirstProduct() {
        contentScrollView.addSubview(firstProduct)
        
        firstProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstProduct.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            firstProduct.leftAnchor.constraint(equalTo: contentScrollView.leftAnchor, constant: 5)
        ])
    }
    
    private func configureSecondProduct() {
        contentScrollView.addSubview(secondProduct)
        
        secondProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondProduct.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            secondProduct.leftAnchor.constraint(equalTo: firstProduct.rightAnchor, constant: 9)
        ])
    }
    
    private func configureThirdProduct() {
        contentScrollView.addSubview(thirdProduct)
        
        thirdProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdProduct.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            thirdProduct.leftAnchor.constraint(equalTo: secondProduct.rightAnchor, constant: 9),
            thirdProduct.rightAnchor.constraint(equalTo: contentScrollView.rightAnchor, constant: -2)
        ])
    }
}
