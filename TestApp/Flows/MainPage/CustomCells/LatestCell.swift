//
//  LatestCell.swift
//  TestApp
//
//  Created by Yulia Ignateva on 21.03.2023.
//

import UIKit

final class LatestCell: UITableViewCell {
    private var content: Data?
    private let rightLabel = UILabel()
    private let leftLabel = UILabel()
    private let scrollView = UIScrollView()
    
    private lazy var firstProduct = LatestView(
        url: content!.latest[0].image_url,
        categoryLabelText: content!.latest[0].category,
        nameLabelText: content!.latest[0].name,
        priceLabelPrice: content!.latest[0].price)
    
    private lazy var secondProduct = LatestView(
        url: content!.latest[1].image_url,
        categoryLabelText: content!.latest[1].category,
        nameLabelText: content!.latest[1].name,
        priceLabelPrice: content!.latest[1].price)
    
    private lazy var thirdProduct = LatestView(
        url: content!.latest[2].image_url,
        categoryLabelText: content!.latest[2].category,
        nameLabelText: content!.latest[2].name,
        priceLabelPrice: content!.latest[2].price)
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, content: Data?) {
        self.content = content
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
        leftLabel.text = "Latest"
        leftLabel.textColor = .black
        leftLabel.font = UIFont.specialFont(size: 15, style: .medium)
        
        contentView.addSubview(leftLabel)
        
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25.5),
             leftLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 11)])
    }
    
    private func configureRightLabel() {
        rightLabel.text = "View all"
        rightLabel.textColor = UIColor(named: "ViewAllLabel")
        rightLabel.font = UIFont.specialFont(size: 10, style: .medium)
        
        contentView.addSubview(rightLabel)
        
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28.5),
             rightLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12.98)])
    }
    
    private func configureScrollView() {
        contentView.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [scrollView.topAnchor.constraint(equalTo: rightLabel.topAnchor, constant: 23.92),
             scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
             scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor)])
    }
    
    private func configureFirstProduct() {
        guard content != nil else { return }
        
        scrollView.addSubview(firstProduct)
        
        firstProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [firstProduct.topAnchor.constraint(equalTo: scrollView.topAnchor),
             firstProduct.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 11)])
    }
    
    private func configureSecondProduct() {
        guard content != nil else { return }
        
        scrollView.addSubview(secondProduct)
        
        secondProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [secondProduct.topAnchor.constraint(equalTo: scrollView.topAnchor),
             secondProduct.leftAnchor.constraint(equalTo: firstProduct.rightAnchor, constant: 12)])
    }
    
    private func configureThirdProduct() {
        guard content != nil else { return }
        
        scrollView.addSubview(thirdProduct)
        
        thirdProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [thirdProduct.topAnchor.constraint(equalTo: scrollView.topAnchor),
             thirdProduct.leftAnchor.constraint(equalTo: secondProduct.rightAnchor, constant: 12)])
    }
}
