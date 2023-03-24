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
    var uploadedData: Data? = nil
    var didFinishMainPageBlock: ((String?) -> ())?
    
    private let viewWillAppear = PublishRelay<Void>()
    private let mainPageViewModel: MainPageViewModel
    private let disposeBag = DisposeBag()
    private let rightViewNavigationBar = UIImageView()
    private let locationView = LocationView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let identifierSearchCell = "identifierSearchCell"
    private let identifierCategoriesCell = "identifierCategoriesCell"
    private let identifierLatestCell = "identifierLatestCell"
    private let identifierFlashSaleCell = "identifierFlashSaleCell"
    private let identifierBrandCell = "identifierBrandCell"
    
    
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
        
        configureNavigationBar()
        configureLocationView()
        configureTableView()
        
        let input = MainPageViewModelInput(
            viewWillAppear: viewWillAppear.asObservable()
        )
        
        let output = mainPageViewModel.bind(input)
        
        output.data.drive(onNext: { result in
            switch result {
            case let .success(dataForUser):
                self.uploadedData = dataForUser
                self.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        })
        .disposed(by: disposeBag)
        
        output.photoProfile.drive(onNext: { [rightViewNavigationBar] image in
            rightViewNavigationBar.image = image
        })
        .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppear.accept(())
    }
    
    private func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
// MARK: - configure title
        let titleLabel = UILabel()
        
        let title = NSMutableAttributedString(
            string: "Trade by ",
            attributes: [
                .font: UIFont.specialFont(size: 21, style: .bold),
                .foregroundColor: UIColor.black
            ]
        )
        let secondPart = NSAttributedString(
            string: "bata",
            attributes: [
                .font: UIFont.specialFont(size: 21, style: .bold),
                .foregroundColor: UIColor(named: "NavigationTitleColor")!
            ]
        )
        title.append(secondPart)
                
        titleLabel.textAlignment = .center
        titleLabel.attributedText = title
        
        navigationBar.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 102)
        ])
        
// MARK: - configure rightLabel
        rightViewNavigationBar.frame = CGRect(x: 100, y: 100, width: 34, height: 34)
        rightViewNavigationBar.layer.cornerRadius = 0.5 * rightViewNavigationBar.bounds.size.width
        rightViewNavigationBar.layer.masksToBounds = true
        
        navigationBar.addSubview(rightViewNavigationBar)
        rightViewNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightViewNavigationBar.widthAnchor.constraint(equalToConstant: 34),
            rightViewNavigationBar.heightAnchor.constraint(equalToConstant: 34),
            rightViewNavigationBar.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 10),
            rightViewNavigationBar.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -47.57)
        ])
        
// MARK: - configure leftLabel
        let leftViewNavigationBar = UIImageView(image: UIImage(named: "Menu"))
        
        navigationBar.addSubview(leftViewNavigationBar)
        leftViewNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftViewNavigationBar.widthAnchor.constraint(equalToConstant: 24),
            leftViewNavigationBar.heightAnchor.constraint(equalToConstant: 26),
            leftViewNavigationBar.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 12),
            leftViewNavigationBar.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 20)
        ])
    }
    
    private func configureLocationView() {
        view.addSubview(locationView)
        
        locationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            locationView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -37)
        ])
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.clipsToBounds = true
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: 8),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            cell = SearchCell(
                style: .default,
                reuseIdentifier: identifierSearchCell
            )
        case (0,1):
            cell = CategoriesCell(
                style: .default,
                reuseIdentifier: identifierCategoriesCell
            )
        case (0,2):
            cell = LatestCell(
                style: .default,
                reuseIdentifier: identifierLatestCell,
                content: uploadedData
            )
        case (0,3):
            cell = FlashSaleCell(
                style: .default,
                reuseIdentifier: identifierFlashSaleCell,
                content: uploadedData
            )
        case (0,4):
            cell = BrandsCell(
                style: .default,
                reuseIdentifier: identifierBrandCell
            )
        default:
            cell = UITableViewCell()
        }
        return cell
    }
}

extension MainPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0,0): return 24
        case (0,1): return 80
        case (0,2): return 210
        case (0,3): return 270
        case (0,4): return 200
        default: return 0
        }
    }
}







