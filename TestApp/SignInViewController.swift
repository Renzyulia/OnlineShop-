//
//  SignInViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 11.03.2023.
//

import UIKit

class SignInViewController: ViewController {
    private let signInLabel = UILabel()
    private let firstNameTextField = DataView(isSecureText: false, placeholder: "First name", securityButton: nil, width: .fullWidth)
    private let lastNameTextField = DataView(isSecureText: false, placeholder: "Last name", securityButton: nil, width: .fullWidth)
    private let emailTextField = DataView(isSecureText: false, placeholder: "Email", securityButton: nil, width: .fullWidth)
    private let signInButton = LoginAndSignInButton(title: "Sign in")
    private let haveAccountLabel = UILabel()
    private let logInButton = UIButton()
    private let signInWithGoogleButton = SignInWithView(company: .init(company: .google))
    private let signInWithAppleButton = SignInWithView(company: .init(company: .apple))
    
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
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [signInButton.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 35),
             signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 43)])
    }
    
    @objc private func signIn() {
        //сделать вход в аккаунт или если неверно введен email, то выдать ошибку
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
        //сделать переход на экран авторизации
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
}
