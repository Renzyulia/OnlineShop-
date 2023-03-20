//
//  MainPageViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 17.03.2023.
//

import UIKit

final class MainPageViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let identifierCell = "identifierCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.title = "Trade by bata"
        
        configureTableView()
        
    }
    
    func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
             tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
             tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}

extension MainPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch (indexPath.section, indexPath.row) {
        case (0,0): cell = SearchCell()
        case (0,1): cell = CategoriesCell()
        default: cell = UITableViewCell()
        }
        return cell
    }
}

extension MainPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0,0): return 24
        case (0,1): return 80
        case (0,2): return 168
        default: return 50
        }
    }
}

final class SearchCell: UITableViewCell {
    private let textField = UITextField()
    private let icon = UIImageView(image: UIImage(named: "Search"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        textField.backgroundColor = UIColor(named: "TextFieldCell")
        textField.placeholder = "What are you looking for?"
        textField.font = UIFont.specialFont(size: 11, style: .medium)
        textField.textColor = .black
        textField.textAlignment = .center
        textField.layer.cornerRadius = 14.5
        textField.layer.masksToBounds = true
        
        contentView.addSubview(textField)
        contentView.addSubview(icon)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [textField.topAnchor.constraint(equalTo: contentView.topAnchor),
             textField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 57),
             textField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -56),
             textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
        
        NSLayoutConstraint.activate(
            [icon.widthAnchor.constraint(equalToConstant: 9),
             icon.heightAnchor.constraint(equalToConstant: 9),
             icon.rightAnchor.constraint(equalTo: textField.rightAnchor, constant: -17.5),
             icon.topAnchor.constraint(equalTo: textField.topAnchor, constant: 7.5),
             icon.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -7.5)])
    }
}

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

final class LatestCell: UITableViewCell {
    
}

final class LatestView: UIView {
    private let imageView = UIImageView()
    private let categoryLabel = UILabel()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let addView = UIImageView()
}
