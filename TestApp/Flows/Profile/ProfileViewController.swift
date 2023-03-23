//
//  ProfileViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 16.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var profileViewModel: ProfileViewModel
    var didFinishProfileBlock: ((String?) -> ())?
    let viewWillAppear = PublishRelay<Void>()
    let changePhotoClick = PublishRelay<UIImage>()
    
    private let login: String
    private let disposeBag = DisposeBag()
    
    private let scrollView = UIScrollView()
    private let backIcon = UIImageView(image: UIImage(named: "Back"))
    private let titleLabel = UILabel()
    private var photoView = PhotoView()
    private let loginLabel = UILabel()
    private let uploadItemButton = UploadItemButton()
    private let storeSection = SectonView(title: "Trade store", iconStyle: .wallet, sectionStyle: .transition)
    private let paymentSection = SectonView(title: "Payment method", iconStyle: .wallet, sectionStyle: .transition)
    private let balanceSection = SectonView(title: "Balance", iconStyle: .wallet, sectionStyle: .information)
    private let tradeHistorySection = SectonView(title: "Trade history", iconStyle: .wallet, sectionStyle: .transition)
    private let restoreSection = SectonView(title: "Restore Purchase", iconStyle: .restore, sectionStyle: .transition)
    private let helpSection = SectonView(title: "Help", iconStyle: .help, sectionStyle: nil)
    private let logOutSection = SectonView(title: "Log out", iconStyle: .logOut, sectionStyle: nil)
    
    init(login: String, didFinishProfileBlock: ((String?) -> ())?, viewModel: ProfileViewModel) {
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
             backIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)])
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Profile"
        titleLabel.font = UIFont.specialFont(size: 15, style: .bold)
        titleLabel.numberOfLines = 1
        
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 65.2),
             titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
    private func configurePhotoView() {
        photoView.button.addTarget(self, action: #selector(changePhoto), for: .touchUpInside)
        
        scrollView.addSubview(photoView)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [photoView.heightAnchor.constraint(equalToConstant: 77),
             photoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 96.5),
             photoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 157.5)])
    }
    
    @objc private func changePhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alert = UIAlertController(
            title: "Photo Source",
            message: "Choose a source",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alert, animated: true)
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
