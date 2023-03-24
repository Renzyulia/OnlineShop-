//
//  SignInViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 11.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class RegistrationViewController: UIViewController {
    
    var didFinishRegistrationBlock: ((String?) -> Void)?
    
    private let registrationViewModel: RegistrationViewModel
    private let disposeBag = DisposeBag()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let signInLabel = UILabel()
    private let firstNameTextField = DataTextField(isSecureText: false, placeholder: "First name", securityButton: nil)
    private let lastNameTextField = DataTextField(isSecureText: false, placeholder: "Last name", securityButton: nil)
    private let emailTextField = DataTextField(isSecureText: false, placeholder: "Email", securityButton: nil)
    private let signInButton = LoginAndSignInButton(title: "Sign in")
    private let haveAccountLabel = UILabel()
    private let logInButton = UIButton()
    private let signInWithGoogleButton = SignInWithView(company: .init(company: .google))
    private let signInWithAppleButton = SignInWithView(company: .init(company: .apple))
    private lazy var invalidEmailLabel = UILabel()
    private lazy var duplicateAccountLabel = UILabel()
    
    init(registrationViewModel: RegistrationViewModel, didFinishRegistrationBlock: ((String?) -> Void)?) {
        self.registrationViewModel = registrationViewModel
        self.didFinishRegistrationBlock = didFinishRegistrationBlock
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        configureScrollView()
        configureSignInLabel()
        configureFirstNameTF()
        configureLastNameTF()
        configureEmailTF()
        configureInvalidEmailLabel()
        configureSignInButton()
        configureHaveAccountLabel()
        configureLogInButton()
        configureSignInGoogleButton()
        configureSignInAppleButton()
        configureInvalidEmailLabel()
        configureDuplicateAccountLabel()
        
        let firstName = firstNameTextField.textField.rx.text
            .asObservable()
            .map { string in return string ?? "" }
        
        let lastName = lastNameTextField.textField.rx.text
            .asObservable()
            .map { string in return string ?? "" }
        
        let email = emailTextField.textField.rx.text
            .asObservable()
            .map { string in return string ?? "" }
        
        let input = RegistrationViewModelInput(
            signInClick: signInButton.rx.controlEvent(.touchUpInside).asObservable(),
            firstName: firstName,
            lastName: lastName,
            email: email
        )
        
        let output = registrationViewModel.bind(input)
        
        output.shouldShowInvalidEmailError.drive(onNext: { [weak self] in
            self?.invalidEmailLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self?.invalidEmailLabel.isHidden = true
            }
        })
        .disposed(by: disposeBag)
        
        output.shouldShowExistingLoginError.drive(onNext: { [weak self] shouldShowError in
            self?.duplicateAccountLabel.isHidden = (shouldShowError == false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self?.duplicateAccountLabel.isHidden = true
            }
        })
        .disposed(by: disposeBag)
        
        output.registrationIsCompleted.drive(onNext: { [weak self] in
            let login = LoginStorage.shared.getLogin()
            self?.didFinishRegistrationBlock?(login)
        })
        .disposed(by: disposeBag)
        
        output.shouldShowSavingError.drive(onNext: { [weak self] in
            self?.configureSavingErrorAlert()
        })
        .disposed(by: disposeBag)
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
    
    private func configureSignInLabel() {
        signInLabel.text = "Sign in"
        signInLabel.font = UIFont.specialFont(size: 25, style: .medium)
        signInLabel.textColor = .black
        
        contentView.addSubview(signInLabel)

        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 155.93),
            signInLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 142.7)
        ])
    }
    
    private func configureFirstNameTF() {
        contentView.addSubview(firstNameTextField)
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 77.77),
            firstNameTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 44),
            firstNameTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 42)
        ])
    }
    
    private func configureLastNameTF() {
        contentView.addSubview(lastNameTextField)
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 35),
            lastNameTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 44),
            lastNameTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 42)
        ])
    }
    
    private func configureEmailTF() {
        contentView.addSubview(emailTextField)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 35),
            emailTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 44),
            emailTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 42)
        ])
    }
    
    private func configureSignInButton() {
        contentView.addSubview(signInButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35),
            signInButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 43)
        ])
    }
    
    private func configureHaveAccountLabel() {
        haveAccountLabel.text = "Already have an account?"
        haveAccountLabel.font = UIFont.specialFont(size: 10, style: .medium)
        haveAccountLabel.textColor = UIColor(named: "HaveAccountLabel")
        haveAccountLabel.numberOfLines = 1
        
        contentView.addSubview(haveAccountLabel)
        
        haveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            haveAccountLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 41.99),
            haveAccountLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 14.58)
        ])
    }
    
    private func configureLogInButton() {
        logInButton.setTitle("Log in", for: .normal)
        logInButton.setTitleColor(UIColor(named: "LogInButton"), for: .normal)
        logInButton.titleLabel?.font = UIFont.specialFont(size: 10, style: .medium)
        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        
        contentView.addSubview(logInButton)
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logInButton.heightAnchor.constraint(equalToConstant: 10),
            logInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 14.43),
            logInButton.leftAnchor.constraint(equalTo: haveAccountLabel.rightAnchor, constant: 8.7)
        ])
    }
    
    @objc private func logIn() {
        didFinishRegistrationBlock?(nil)
    }
    
    private func configureSignInGoogleButton() {
        contentView.addSubview(signInWithGoogleButton)
        
        signInWithGoogleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInWithGoogleButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 109.92),
            signInWithGoogleButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 99)
        ])
    }
    
    private func configureSignInAppleButton() {
        contentView.addSubview(signInWithAppleButton)
        
        signInWithAppleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInWithAppleButton.topAnchor.constraint(equalTo: signInWithGoogleButton.bottomAnchor, constant: 58.73),
            signInWithAppleButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 99),
            signInWithAppleButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -133)
        ])
    }
    
    private func configureInvalidEmailLabel() {
        invalidEmailLabel.text = "Invalid e-mail form"
        invalidEmailLabel.font = UIFont.specialFont(size: 11, style: .medium)
        invalidEmailLabel.textColor = .red
        invalidEmailLabel.numberOfLines = 1
        invalidEmailLabel.isHidden = true
        
        contentView.addSubview(invalidEmailLabel)
        
        invalidEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            invalidEmailLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 9),
            invalidEmailLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 49)
        ])
    }
    
    private func configureDuplicateAccountLabel() {
        duplicateAccountLabel.text = "The account already exists. Log in."
        duplicateAccountLabel.font = UIFont.specialFont(size: 11, style: .medium)
        duplicateAccountLabel.textColor = .red
        duplicateAccountLabel.numberOfLines = 1
        duplicateAccountLabel.isHidden = true
        
        contentView.addSubview(duplicateAccountLabel)
        
        duplicateAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            duplicateAccountLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 9),
            duplicateAccountLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 49)
        ])
    }
    
    private func configureSavingErrorAlert() {
        let alert = UIAlertController(title: nil, message: "Error saving account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
