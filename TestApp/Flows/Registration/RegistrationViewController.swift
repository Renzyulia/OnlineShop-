//
//  SignInViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 11.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

class RegistrationViewController: UIViewController {
    
    private let signInLabel = UILabel()
    private let firstNameTextField = DataTextField(isSecureText: false, placeholder: "First name", securityButton: nil, width: .fullWidth)
    private let lastNameTextField = DataTextField(isSecureText: false, placeholder: "Last name", securityButton: nil, width: .fullWidth)
    private let emailTextField = DataTextField(isSecureText: false, placeholder: "Email", securityButton: nil, width: .fullWidth)
    private let signInButton = LoginAndSignInButton(title: "Sign in")
    private let haveAccountLabel = UILabel()
    private let logInButton = UIButton()
    private let signInWithGoogleButton = SignInWithView(company: .init(company: .google))
    private let signInWithAppleButton = SignInWithView(company: .init(company: .apple))
    private lazy var invalidEmailLabel = UILabel()
    private lazy var duplicateAccountLabel = UILabel()
    private let registrationViewModel: RegistrationViewModel
    private let disposeBag = DisposeBag()
    
    var didFinishRegistrationBlock: (() -> Void)?
    
    init(registrationViewModel: RegistrationViewModel, didFinishRegistrationBlock: (() -> Void)?) {
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
            .map({ (string: String?) -> String in return string ?? "" })
        
        let lastName = lastNameTextField.textField.rx.text
            .asObservable()
            .map({ (string: String?) -> String in return string ?? "" })
        
        let email = emailTextField.textField.rx.text
            .asObservable()
            .map({ (string: String?) -> String in return string ?? "" })
        
        let input = RegistrationViewModelInput(
            signInClick: signInButton.rx.controlEvent(.touchUpInside).asObservable(),
            firstName: firstName,
            lastName: lastName,
            email: email
        )
        
        let output = registrationViewModel.bind(input)
        
        output.shouldShowInvalidEmailError.drive(onNext: { [weak self] in
            self?.invalidEmailLabel.isHidden = false
        })
        .disposed(by: disposeBag)
        
        output.shouldShowExisitingLoginError.drive(onNext: { [weak self] (shouldShowError: Bool) in
            self?.duplicateAccountLabel.isHidden = (shouldShowError == false)
        })
        .disposed(by: disposeBag)
        
        output.registrationIsCompleted.drive(onNext: { [weak self] in
            self?.didFinishRegistrationBlock?()
        })
        .disposed(by: disposeBag)
        
        output.shouldShowSavingError.drive(onNext: { [weak self] in
            self?.configureSavingErrorAlert()
        })
        .disposed(by: disposeBag)
    }
    
    private func configureSignInLabel() {
        signInLabel.text = "Sign in"
        signInLabel.font = UIFont.specialFont(size: 25, style: .bold)
        signInLabel.textAlignment = .center
        signInLabel.textColor = .black
        
        view.addSubview(signInLabel)

        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [signInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 155.93),
             signInLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 142.7),
             signInLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -144.78)])
    }
    
    private func configureFirstNameTF() {
        view.addSubview(firstNameTextField)
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [firstNameTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 77.77),
             firstNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44)])
    }
    
    private func configureLastNameTF() {
        view.addSubview(lastNameTextField)
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 35),
             lastNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44)])
    }
    
    private func configureEmailTF() {
        view.addSubview(emailTextField)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 35),
             emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44)])
    }
    
    private func configureSignInButton() {
        view.addSubview(signInButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [signInButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35),
             signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 43)])
    }
    
    private func configureHaveAccountLabel() {
        haveAccountLabel.text = "Already have an account?"
        haveAccountLabel.font = UIFont.specialFont(size: 9, style: .medium)
        haveAccountLabel.textColor = UIColor(named: "HaveAccountLabel")
        haveAccountLabel.numberOfLines = 1
        
        view.addSubview(haveAccountLabel)
        
        haveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [haveAccountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 41.99),
             haveAccountLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 17.58)])
    }
    
    private func configureLogInButton() {
        logInButton.setTitle("Log in", for: .normal)
        logInButton.setTitleColor(UIColor(named: "LogInButton"), for: .normal)
        logInButton.titleLabel?.font = UIFont.specialFont(size: 9, style: .bold)
        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        
        view.addSubview(logInButton)
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [logInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 17.43),
             logInButton.leftAnchor.constraint(equalTo: haveAccountLabel.rightAnchor, constant: 8.7)])
    }
    
    @objc private func logIn() {
        didFinishRegistrationBlock!()
    }
    
    private func configureSignInGoogleButton() {
        view.addSubview(signInWithGoogleButton)
        
        signInWithGoogleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [signInWithGoogleButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 109.92),
             signInWithGoogleButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 99)])
    }
    
    private func configureSignInAppleButton() {
        view.addSubview(signInWithAppleButton)
        
        signInWithAppleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [signInWithAppleButton.topAnchor.constraint(equalTo: signInWithGoogleButton.bottomAnchor, constant: 48.73),
             signInWithAppleButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 99)])
    }
    
    private func configureInvalidEmailLabel() {
        invalidEmailLabel.text = "Invalid e-mail form"
        invalidEmailLabel.font = UIFont.specialFont(size: 9, style: .medium)
        invalidEmailLabel.textColor = .red
        invalidEmailLabel.numberOfLines = 1
        invalidEmailLabel.isHidden = true
        
        view.addSubview(invalidEmailLabel)
        
        invalidEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [invalidEmailLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 9),
             invalidEmailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44)])
    }
    
    private func configureDuplicateAccountLabel() {
        duplicateAccountLabel.text = "The account already exists. Log in."
        duplicateAccountLabel.font = UIFont.specialFont(size: 9, style: .medium)
        duplicateAccountLabel.textColor = .red
        duplicateAccountLabel.numberOfLines = 1
        duplicateAccountLabel.isHidden = true
        
        view.addSubview(duplicateAccountLabel)
        
        duplicateAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [duplicateAccountLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
             duplicateAccountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44)])
    }
    
    private func configureSavingErrorAlert() {
        let alert = UIAlertController(title: nil, message: "Error saving account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
