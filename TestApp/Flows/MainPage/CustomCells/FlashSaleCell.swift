//
//  FlashSaleCell.swift
//  TestApp
//
//  Created by Yulia Ignateva on 21.03.2023.
//

import UIKit

final class FlashSaleCell: UITableViewCell {
    private var content: Data?
    private let rightLabel = UILabel()
    private let leftLabel = UILabel()
    private let scrollView = UIScrollView()
    
    private lazy var firstProduct = FlashSaleView(
        url: content!.flashSale[0].image_url,
        categoryLabelText: content!.flashSale[0].category,
        nameLabelText: content!.flashSale[0].name,
        priceLabelPrice: content!.flashSale[0].price,
        discount: content!.flashSale[0].discount)
    
    private lazy var secondProduct = FlashSaleView(
        url: content!.flashSale[1].image_url,
        categoryLabelText: content!.flashSale[1].category,
        nameLabelText: content!.flashSale[1].name,
        priceLabelPrice: content!.flashSale[1].price,
        discount: content!.flashSale[1].discount)
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, content: Data?) {
        self.content = content
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLeftLabel()
        configureRightLabel()
        configureScrollView()
        configureFirstProduct()
        configureSecondProduct()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLeftLabel() {
        leftLabel.text = "Flash Sale"
        leftLabel.textColor = .black
        leftLabel.font = UIFont.specialFont(size: 15, style: .medium)
        
        contentView.addSubview(leftLabel)
        
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18.9),
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
            rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.9),
            rightLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12.98)
        ])
    }
    
    private func configureScrollView() {
        contentView.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: rightLabel.topAnchor, constant: 25.92),
            scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    private func configureFirstProduct() {
        guard content != nil else { return }
        
        scrollView.addSubview(firstProduct)
        
        firstProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstProduct.topAnchor.constraint(equalTo: scrollView.topAnchor),
            firstProduct.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 11)
        ])
    }
    
    private func configureSecondProduct() {
        guard content != nil else { return }
        
        scrollView.addSubview(secondProduct)
        
        secondProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondProduct.topAnchor.constraint(equalTo: scrollView.topAnchor),
            secondProduct.leftAnchor.constraint(equalTo: firstProduct.rightAnchor, constant: 10)
        ])
    }
}
