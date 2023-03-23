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
        NSLayoutConstraint.activate(
            [leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.9),
             leftLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 11)])
    }
    
    private func configureRightLabel() {
        rightLabel.text = "View all"
        rightLabel.textColor = UIColor(named: "ViewAllLabel")
        rightLabel.font = UIFont.specialFont(size: 10, style: .medium)
        
        contentView.addSubview(rightLabel)
        
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.9),
             rightLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12.98)])
    }
    
    private func configureScrollView() {
        contentView.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [scrollView.topAnchor.constraint(equalTo: rightLabel.topAnchor, constant: 22.92),
             scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
             scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor)])
    }
    
    private func configureFirstProduct() {
        scrollView.addSubview(firstProduct)
        
        firstProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [firstProduct.topAnchor.constraint(equalTo: scrollView.topAnchor),
             firstProduct.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 11)])
    }
    
    private func configureSecondProduct() {
        scrollView.addSubview(secondProduct)
        
        secondProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [secondProduct.topAnchor.constraint(equalTo: scrollView.topAnchor),
             secondProduct.leftAnchor.constraint(equalTo: firstProduct.rightAnchor, constant: 9)])
    }
    
    private func configureThirdProduct() {
        scrollView.addSubview(thirdProduct)
        
        thirdProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [thirdProduct.topAnchor.constraint(equalTo: scrollView.topAnchor),
             thirdProduct.leftAnchor.constraint(equalTo: secondProduct.rightAnchor, constant: 9)])
    }
}
