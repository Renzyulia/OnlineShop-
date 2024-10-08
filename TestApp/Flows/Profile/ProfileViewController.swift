//
//  ProfileViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 16.03.2023.
//

import UIKit
import RxSwift
import RxCocoa
import Photos

final class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var profileViewModel: ProfileViewModel
    var didFinishProfileBlock: ((String?) -> ())?
    let viewWillAppear = PublishRelay<Void>()
    let changePhotoClick = PublishRelay<UIImage>()
    
    private let login: String
    private let disposeBag = DisposeBag()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let backIcon = UIImageView(image: UIImage(named: "Back"))
    private let titleLabel = UILabel()
    private var photoView = PhotoView()
    private let loginLabel = UILabel()
    private let uploadItemButton = UploadItemButton()
    private let storeSection = SectionView(title: "Trade store", iconStyle: .wallet, sectionStyle: .transition)
    private let paymentSection = SectionView(title: "Payment method", iconStyle: .wallet, sectionStyle: .transition)
    private let balanceSection = SectionView(title: "Balance", iconStyle: .wallet, sectionStyle: .information)
    private let tradeHistorySection = SectionView(title: "Trade history", iconStyle: .wallet, sectionStyle: .transition)
    private let restoreSection = SectionView(title: "Restore Purchase", iconStyle: .restore, sectionStyle: .transition)
    private let helpSection = SectionView(title: "Help", iconStyle: .help, sectionStyle: nil)
    private let logOutSection = SectionView(title: "Log out", iconStyle: .logOut, sectionStyle: nil)
    
    init(login: String, viewModel: ProfileViewModel) {
        self.login = login
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
            logOutClick: logOutSection.rx.controlEvent(.touchUpInside).asObservable(),
            viewWillAppear: viewWillAppear.asObservable(),
            changePhotoClick: changePhotoClick.asObservable()
        )
            
        let output = profileViewModel.bind(input)
        
        output.logOutCompleted.drive(onNext: { [weak self] in
            self?.didFinishProfileBlock?(nil)
        })
        .disposed(by: disposeBag)
        
        output.photoProfile.drive(onNext: { [photoView] image in
            photoView.photo = image
        })
        .disposed(by: disposeBag)
        
        output.photoProfileChanged.drive(onNext: { [photoView] image in
            photoView.photo = image
        })
        .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppear.accept(())
    }
    
    private func configureScrollView() {
        scrollView.backgroundColor = UIColor(named: "BackgroundColor")
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func configureBackIcon() {
        contentView.addSubview(backIcon)
        
        backIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backIcon.widthAnchor.constraint(equalToConstant: 14),
            backIcon.heightAnchor.constraint(equalToConstant: 14),
            backIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 63),
            backIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Profile"
        titleLabel.font = UIFont.specialFont(size: 15, style: .bold)
        titleLabel.numberOfLines = 1
        
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 65.2),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func configurePhotoView() {
        photoView.button.addTarget(self, action: #selector(changePhoto), for: .touchUpInside)
        
        contentView.addSubview(photoView)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoView.heightAnchor.constraint(equalToConstant: 77),
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 96.5),
            photoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    @objc private func changePhoto() {
        
        let alert = UIAlertController(
            title: "Photo Source",
            message: "Choose a source",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] (action: UIAlertAction) in
            guard let self = self else { return }
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        changePhotoClick.accept(image)
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    private func configureLoginLabel() {
        loginLabel.text = login
        loginLabel.font = UIFont.specialFont(size: 16, style: .bold)
        
        contentView.addSubview(loginLabel)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: photoView.button.bottomAnchor, constant: 19.6),
            loginLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func configureUploadItemButton() {
        contentView.addSubview(uploadItemButton)
        
        uploadItemButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uploadItemButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 37.82),
            uploadItemButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 43),
            uploadItemButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -42)
        ])
    }
    
    private func configureStoreSection() {
        contentView.addSubview(storeSection)
        
        storeSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storeSection.topAnchor.constraint(equalTo: uploadItemButton.bottomAnchor, constant: 14),
            storeSection.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            storeSection.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32)
        ])
    }
    
    private func configurePaymentSection() {
        contentView.addSubview(paymentSection)
        
        paymentSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paymentSection.topAnchor.constraint(equalTo: storeSection.bottomAnchor, constant: 25),
            paymentSection.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            paymentSection.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32)
        ])
    }
    
    private func configureBalanceSection() {
        contentView.addSubview(balanceSection)
        
        balanceSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            balanceSection.topAnchor.constraint(equalTo: paymentSection.bottomAnchor, constant: 25),
            balanceSection.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            balanceSection.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32)
        ])
    }
    
    private func configureTradeHistorySection() {
        contentView.addSubview(tradeHistorySection)
        
        tradeHistorySection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tradeHistorySection.topAnchor.constraint(equalTo: balanceSection.bottomAnchor, constant: 25),
            tradeHistorySection.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            tradeHistorySection.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32)
        ])
    }
    
    private func configureRestoreSection() {
        contentView.addSubview(restoreSection)
        
        restoreSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restoreSection.topAnchor.constraint(equalTo: tradeHistorySection.bottomAnchor, constant: 25),
            restoreSection.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            restoreSection.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32)
        ])
    }
    
    private func configureHelpSection() {
        contentView.addSubview(helpSection)
        
        helpSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helpSection.topAnchor.constraint(equalTo: restoreSection.bottomAnchor, constant: 25),
            helpSection.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            helpSection.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32)
        ])
    }
    
    private func configureLogOutSection() {
        contentView.addSubview(logOutSection)
        
        logOutSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutSection.topAnchor.constraint(equalTo: helpSection.bottomAnchor, constant: 25),
            logOutSection.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            logOutSection.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            logOutSection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
