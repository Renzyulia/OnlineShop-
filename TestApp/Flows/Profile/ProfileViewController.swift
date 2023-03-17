//
//  ProfileViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 16.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    var didFinishProfileBlock: (() -> ())?
    
    private let login: String
    private let profileViewModel: ProfileViewModel
    private let disposeBag = DisposeBag()
    
    private let scrollView = UIScrollView()
    private let backIcon = UIImageView(image: UIImage(named: "Back"))
    private let titleLabel = UILabel()
    private let photoView = PhotoView(photo: nil)
    private let loginLabel = UILabel()
    private let uploadItemButton = UploadItemButton()
    private let storeSection = SectonView(title: "Trade store", iconStyle: .wallet, sectionStyle: .transition)
    private let paymentSection = SectonView(title: "Payment method", iconStyle: .wallet, sectionStyle: .transition)
    private let balanceSection = SectonView(title: "Balance", iconStyle: .wallet, sectionStyle: .information)
    private let tradeHistorySection = SectonView(title: "Trade history", iconStyle: .wallet, sectionStyle: .transition)
    private let restoreSection = SectonView(title: "Restore Purchase", iconStyle: .restore, sectionStyle: .transition)
    private let helpSection = SectonView(title: "Help", iconStyle: .help, sectionStyle: nil)
    private let logOutSection = SectonView(title: "Log out", iconStyle: .logOut, sectionStyle: nil)
    
    init(login: String, didFinishProfileBlock: (() -> ())?, viewModel: ProfileViewModel) {
        self.login = login
        self.didFinishProfileBlock = didFinishProfileBlock
        self.profileViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollView()
        configureBackIcon()
        configureTitleLabel()
        configurePhotoView()
        configureLoginLabel()
        configureUploadItemButton()
        configureStoreSection()
        configurePaymentSection()
        configureBalanceSection()
        configureTradeHistorySection()
        configureRestoreSection()
        configureHelpSection()
        configureLogOutSection()
        
        let input = ProfileViewModelInput(
            logOutClick: logOutSection.rx.controlEvent(.touchUpInside).asObservable())
        
        let output = profileViewModel.bind(input)
        
        output.logOutCompleted.drive(onNext: { [weak self] in
            self?.didFinishProfileBlock?()
        })
        .disposed(by: disposeBag)
    }
    
    private func configureScrollView() {
        scrollView.backgroundColor = UIColor(named: "BackgroundColor")
        
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [scrollView.topAnchor.constraint(equalTo: view.topAnchor),
             scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
             scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
             scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func configureBackIcon() {
        scrollView.addSubview(backIcon)
        
        backIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [backIcon.widthAnchor.constraint(equalToConstant: 14),
             backIcon.heightAnchor.constraint(equalToConstant: 14),
             backIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 63),
             backIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
    ])
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Profile"
        titleLabel.font = UIFont.specialFont(size: 15, style: .bold)
        titleLabel.numberOfLines = 1
        
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.2),
             titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 166.25)])
    }
    
    private func configurePhotoView() {
        scrollView.addSubview(photoView)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [photoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 96.5),
             photoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 157.5)])
    }
    
    private func configureLoginLabel() {
        loginLabel.text = login
        loginLabel.font = UIFont.specialFont(size: 16, style: .bold)
        
        scrollView.addSubview(loginLabel)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [loginLabel.topAnchor.constraint(equalTo: photoView.button.bottomAnchor, constant: 19.6),
             loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
    private func configureUploadItemButton() {
        scrollView.addSubview(uploadItemButton)
        
        uploadItemButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [uploadItemButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 37.82),
             uploadItemButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 43)])
    }
    
    private func configureStoreSection() {
        scrollView.addSubview(storeSection)
        
        storeSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [storeSection.topAnchor.constraint(equalTo: uploadItemButton.bottomAnchor, constant: 14),
             storeSection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)])
    }
    
    private func configurePaymentSection() {
        scrollView.addSubview(paymentSection)
        
        paymentSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [paymentSection.topAnchor.constraint(equalTo: storeSection.bottomAnchor, constant: 25),
             paymentSection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)])
    }
    
    private func configureBalanceSection() {
        scrollView.addSubview(balanceSection)
        
        balanceSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [balanceSection.topAnchor.constraint(equalTo: paymentSection.bottomAnchor, constant: 25),
             balanceSection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)])
    }
    
    private func configureTradeHistorySection() {
        scrollView.addSubview(tradeHistorySection)
        
        tradeHistorySection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [tradeHistorySection.topAnchor.constraint(equalTo: balanceSection.bottomAnchor, constant: 25),
             tradeHistorySection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)])
    }
    
    private func configureRestoreSection() {
        scrollView.addSubview(restoreSection)
        
        restoreSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [restoreSection.topAnchor.constraint(equalTo: tradeHistorySection.bottomAnchor, constant: 25),
             restoreSection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)])
    }
    
    private func configureHelpSection() {
        scrollView.addSubview(helpSection)
        
        helpSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [helpSection.topAnchor.constraint(equalTo: restoreSection.bottomAnchor, constant: 25),
             helpSection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)])
    }
    
    private func configureLogOutSection() {
        scrollView.addSubview(logOutSection)
        
        logOutSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [logOutSection.topAnchor.constraint(equalTo: helpSection.bottomAnchor, constant: 25),
             logOutSection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32)])
    }
}
