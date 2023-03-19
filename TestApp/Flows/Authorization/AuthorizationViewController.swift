//
//  AuthorizationViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 11.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class AuthorizationViewController: UIViewController {
    private let welcomeLabel = UILabel()
    private let nameTextField = DataTextField(isSecureText: false, placeholder: "First name", securityButton: nil, width: .fullWidth)
    private let passwordTextField = DataTextField(isSecureText: true, placeholder: "Password", securityButton: UIButton(), width: .shortWidth)
    private let loginButton = LoginAndSignInButton(title: "Login")
    private let accountIsNotRegisteredLabel = UILabel()
    private let authorizationViewModel: AuthorizationViewModel
    private let disposeBag = DisposeBag()
    
    var didFinishAuthorizationBlock: (() -> Void)?
    
    init(authorizationViewModel: AuthorizationViewModel, didFinishAuthorizationBlock: (() -> Void)?) {
        self.authorizationViewModel = authorizationViewModel
        self.didFinishAuthorizationBlock = didFinishAuthorizationBlock
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        configureLabel()
        congfigureNameTF()
        configurePasswordTF()
        configureButton()
        configureAccountIsNotRegisteredLabel()
        
        let name = nameTextField.textField.rx.text
            .asObservable()
            .map({ (string: String?) -> String in return string ?? "" })
        
        let password = passwordTextField.textField.rx.text
            .asObservable()
            .map({ (string: String?) -> String in return string ?? "" })
        
        let input = AuthorizationViewModelInput(
            loginClick: loginButton.rx.controlEvent(.touchUpInside).asObservable(),
            firstName: name,
            password: password)
        
        let output = authorizationViewModel.bind(input)
        
        output.logInCompleted.drive(onNext: { [weak self] in
            self?.didFinishAuthorizationBlock?()
        })
        .disposed(by: disposeBag)
        
        output.shouldShowAccountIsNotRegistered.drive(onNext: { [weak self] (shouldShowError: Bool) in
            self?.accountIsNotRegisteredLabel.isHidden = (shouldShowError == false)
        })
        .disposed(by: disposeBag)
    }
    
    private func configureLabel() {
        welcomeLabel.text = "Welcome back"
        welcomeLabel.font = UIFont.specialFont(size: 19, style: .bold)
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 1
        
        view.addSubview(welcomeLabel)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 158.71),
             welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90.05)])
    }
    
    private func congfigureNameTF() {
        view.addSubview(nameTextField)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [nameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 80.82),
             nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44)])
    }
    
    private func configurePasswordTF() {
        view.addSubview(passwordTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 35),
             passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 43)])
    }
    
    private func configureButton() {
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [loginButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 99),
             loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 43)])
    }
    
    private func configureAccountIsNotRegisteredLabel() {
        accountIsNotRegisteredLabel.text = "The account was not found"
        accountIsNotRegisteredLabel.font = UIFont.specialFont(size: 14, style: .medium)
        accountIsNotRegisteredLabel.textColor = .red
        accountIsNotRegisteredLabel.numberOfLines = 1
        accountIsNotRegisteredLabel.isHidden = true
        
        view.addSubview(accountIsNotRegisteredLabel)
        
        accountIsNotRegisteredLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [accountIsNotRegisteredLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
             accountIsNotRegisteredLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 43)])
    }
}
