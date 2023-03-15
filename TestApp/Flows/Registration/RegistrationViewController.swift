//
//  SignInViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 11.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

class RegistrationViewController: ViewController {
    
    private let signInLabel = UILabel()
    private let firstNameTextField = DataView(isSecureText: false, placeholder: "First name", securityButton: nil, width: .fullWidth)
    private let lastNameTextField = DataView(isSecureText: false, placeholder: "Last name", securityButton: nil, width: .fullWidth)
    private let emailTextField = DataView(isSecureText: false, placeholder: "Email", securityButton: nil, width: .fullWidth)
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
        
        configureSignInLabel()
        configureFirstNameTF()
        configureLastNameTF()
        configureEmailTF()
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
            self?.invalidEmailLabel.isHidden = true
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
        signInLabel.font = UIFont.specialFont(size: 25)
        signInLabel.textAlignment = .center
        signInLabel.textColor = .black

        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [signInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 155.93),
             signInLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 142.7),
             signInLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -144.78)])
    }
    
    private func configureFirstNameTF() {
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [firstNameTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 77.77),
             firstNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44)])
    }
    
    private func configureLastNameTF() {
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.topAnchor, constant: 35),
             lastNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44)])
    }
    
    private func configureEmailTF() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [emailTextField.topAnchor.constraint(equalTo: lastNameTextField.topAnchor, constant: 35),
             emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44)])
    }
    
    private func configureSignInButton() {
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [signInButton.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 35),
             signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 43)])
    }
    
    private func configureHaveAccountLabel() {
        haveAccountLabel.text = "Already have an account?"
        haveAccountLabel.font = UIFont.specialFont(size: 9)
        haveAccountLabel.textColor = UIColor(named: "HaveAccountLabel")
        haveAccountLabel.numberOfLines = 1
        
        view.addSubview(haveAccountLabel)
        NSLayoutConstraint.activate(
            [haveAccountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 41.99),
             haveAccountLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 17.58),
             haveAccountLabel.rightAnchor.constraint(equalTo: logInButton.leftAnchor, constant: 8.7)]) //нужно ли здесь указывать тоже это расстояние от соседнего объекта, если в у этого соседнего объекта я уже указала этот отступ? И достаточно ли этих трех отступов или нужен еще нижний?
    }
    
    private func configureLogInButton() {
        logInButton.setTitle("Log in", for: .normal)
        logInButton.setTitleColor(UIColor(named: "LogInButton"), for: .normal)
        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        
        view.addSubview(logInButton)
        NSLayoutConstraint.activate(
            [logInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 17.43), //здесь я сделала отступы со всех четырех сторон, верно ли это?
             logInButton.leftAnchor.constraint(equalTo: haveAccountLabel.rightAnchor, constant: 8.7),
             logInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -173.41),
             logInButton.bottomAnchor.constraint(equalTo: signInWithGoogleButton.topAnchor, constant: -82.92)])
    }
    
    @objc private func logIn() {
        didFinishRegistrationBlock!()
    }
    
    private func configureSignInGoogleButton() {
        signInWithGoogleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [signInWithGoogleButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 101),
             signInWithGoogleButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 99)])
    }
    
    private func configureSignInAppleButton() {
        signInWithAppleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [signInWithAppleButton.topAnchor.constraint(equalTo: signInWithGoogleButton.bottomAnchor, constant: 38),
             signInWithAppleButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 99)])
    }
    
    private func configureInvalidEmailLabel() {
        invalidEmailLabel.text = "Invalid e-mail form"
        invalidEmailLabel.font = UIFont.specialFont(size: 9)
        invalidEmailLabel.textColor = .red
        invalidEmailLabel.numberOfLines = 1
        
        invalidEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [invalidEmailLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 9),
             invalidEmailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44)])
    }
    
    private func configureDuplicateAccountLabel() {
        duplicateAccountLabel.text = "The account already exists. Log in."
        duplicateAccountLabel.font = UIFont.specialFont(size: 9)
        duplicateAccountLabel.textColor = .red
        duplicateAccountLabel.numberOfLines = 1
        
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
