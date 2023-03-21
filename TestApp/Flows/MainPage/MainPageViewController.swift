//
//  MainPageViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 17.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class MainPageViewController: UIViewController {
    private let mainPageViewModel: MainPageViewModel
    var didFinishMainPageBlock: (() -> ())?
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let identifierCell = "identifierCell"
    var dataLatest: (Data)? = nil
    private let disposeBag = DisposeBag()
    
    init(mainPageViewModel: MainPageViewModel) {
        self.mainPageViewModel = mainPageViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.title = "Trade by bata"
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let input = MainPageViewModelInput(
            viewWillAppear: self.rx.deallocated.asObservable()) //правильно ли я выбрала метод и расположение в viewWillAppear
        
        let output = mainPageViewModel.bind(input)
        
        output.data.drive{ (result: Result<Data,Error>) -> Void in
            switch result {
            case let .success(dataForUser):
                self.dataLatest = dataForUser
                print("Success! \(dataForUser)")
            case let .failure(error):
                print("Bad day! \(error)")
            }
        }
        .disposed(by: disposeBag)
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
    private let content: Data
    private let rightLabel = UILabel()
    private let leftLabel = UILabel()
    private let scrollView = UIScrollView()
    
    init(conteent: Data) {
        self.content = conteent
        super.init()
        configureScrollView()
        configureLeftLabel()
        configureRightLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureScrollView() {
        contentView.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
             scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
             scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor)])
    }
    
    func configureLeftLabel() {
        leftLabel.text = "Latest"
        leftLabel.textColor = .black
        leftLabel.font = UIFont.specialFont(size: 13, style: .bold)
        
        contentView.addSubview(leftLabel)
        
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
             leftLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 11.55)])
    }
    
    func configureRightLabel() {
        rightLabel.text = "View all"
        rightLabel.textColor = UIColor(named: "ViewAllLabel")
        rightLabel.font = UIFont.specialFont(size: 9, style: .medium)
        
        contentView.addSubview(rightLabel)
        
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
             rightLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 12.98)])
    }
    
    func configureFirstProduct() {
    }
}

final class LatestView: UIView {
    private let image: UIImage
    private let categoryLabelText: String
    private let nameLabelText: String
    private let priceLabelText: String
    
    private let imageView = UIImageView()
    private let categoryLabel = UILabel()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let addView = UIImageView(image: UIImage(named: "Add"))
    
    init(image: UIImage, categoryLabelText: String, nameLabelText: String, priceLabelText: String) {
        self.image = image
        self.categoryLabelText = categoryLabelText
        self.nameLabelText = nameLabelText
        self.priceLabelText = priceLabelText
        super.init()
        
        configureImage()
        configureCategoryLabel()
        configureNameLabel()
        configurePriceLabel()
        configureAddView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImage() {
        imageView.image = image
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [imageView.widthAnchor.constraint(equalToConstant: 114),
             imageView.heightAnchor.constraint(equalToConstant: 149),
             imageView.topAnchor.constraint(equalTo: self.topAnchor),
             imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
             imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             imageView.rightAnchor.constraint(equalTo: self.rightAnchor)])
    }
    
    func configureCategoryLabel() {
        categoryLabel.text = categoryLabelText
        categoryLabel.textColor = .black
        categoryLabel.font = UIFont.specialFont(size: 6.5, style: .bold)
        categoryLabel.textAlignment = .center
        categoryLabel.backgroundColor = UIColor(named: "LatestCategoryColor")
        categoryLabel.layer.opacity = 85
        categoryLabel.clipsToBounds = true
        categoryLabel.layer.cornerRadius = 25
        
        self.addSubview(categoryLabel)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [categoryLabel.widthAnchor.constraint(equalToConstant: 35),
             categoryLabel.heightAnchor.constraint(equalToConstant: 12),
             categoryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 91),
             categoryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7)])
    }
    
    func configureNameLabel() {
        nameLabel.text = nameLabelText
        nameLabel.textColor = .white
        nameLabel.font = UIFont.specialFont(size: 12, style: .bold)
        
        self.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [nameLabel.widthAnchor.constraint(equalToConstant: 57),
             nameLabel.heightAnchor.constraint(equalToConstant: 9.14),
             nameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 6.31),
             nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7.46)])
    }
    
    func configurePriceLabel() {
        priceLabel.text = "$ \(priceLabelText)"
        priceLabel.font = UIFont.specialFont(size: 8.45, style: .bold)
        priceLabel.textColor = .white
        
        self.addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [priceLabel.widthAnchor.constraint(equalToConstant: 30.02),
             priceLabel.heightAnchor.constraint(equalToConstant: 8.45),
             priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7.06),
             priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7.37)])
    }
    
    func configureAddView() {
        self.addSubview(addView)
        
        addView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [addView.widthAnchor.constraint(equalToConstant: 20),
             addView.heightAnchor.constraint(equalToConstant: 20),
             addView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
             addView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)])
    }
}
