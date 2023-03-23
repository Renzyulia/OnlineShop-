//
//  CategoriesCell.swift
//  TestApp
//
//  Created by Yulia Ignateva on 21.03.2023.
//

import UIKit

final class CategoriesCell: UITableViewCell {
    private let scrollView = UIScrollView()
    private let phonesView = CategoriesView(category: .init(category: .phones))
    private let headphonesView = CategoriesView(category: .init(category: .headPhones))
    private let gamesView = CategoriesView(category: .init(category: .games))
    private let carsView = CategoriesView(category: .init(category: .cars))
    private let furnitureView = CategoriesView(category: .init(category: .furniture))
    private let kidsView = CategoriesView(category: .init(category: .kids))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureScrollView()
        configurePhonesView()
        configureHeadphonesView()
        configureGamesView()
        configureCarsView()
        configureFurnitureView()
        configureKidsView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureScrollView() {
        contentView.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
             scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
             scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
             scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }
    
    private func configurePhonesView() {
        scrollView.addSubview(phonesView)
        
        phonesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [phonesView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 17),
             phonesView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 12)])
    }
    
    private func configureHeadphonesView() {
        scrollView.addSubview(headphonesView)
        
        headphonesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [headphonesView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 17),
             headphonesView.leftAnchor.constraint(equalTo: phonesView.rightAnchor, constant: 3)])
    }
    
    private func configureGamesView() {
        scrollView.addSubview(gamesView)
        
        gamesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [gamesView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 17),
             gamesView.leftAnchor.constraint(equalTo: headphonesView.rightAnchor, constant: 3)])
    }
    
    private func configureCarsView() {
        scrollView.addSubview(carsView)
        
        carsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [carsView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 17),
             carsView.leftAnchor.constraint(equalTo: gamesView.rightAnchor, constant: 3)])
    }
    
    private func configureFurnitureView() {
        scrollView.addSubview(furnitureView)
        
        furnitureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [furnitureView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 17),
             furnitureView.leftAnchor.constraint(equalTo: carsView.rightAnchor, constant: 3)])
    }
    
    private func configureKidsView() {
        scrollView.addSubview(kidsView)
        
        kidsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [kidsView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 17),
             kidsView.leftAnchor.constraint(equalTo: furnitureView.rightAnchor, constant: 3)])
    }
}
