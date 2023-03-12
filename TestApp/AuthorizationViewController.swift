//
//  AuthorizationViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 11.03.2023.
//

import UIKit

class AuthorizationViewController: ViewController {
    private let welcomeLabel = UILabel()
    private let nameTextField = DataView(isSecureText: false, placeholder: "First name", securityButton: nil, width: .fullWidth)
    private let passwordTextField = DataView(isSecureText: true, placeholder: "Password", securityButton: UIButton(), width: .shortWidth)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabel()
        congfigureNameTF()
        configurePasswordTF()
        configureButton()
    }
    
    private func configureLabel() {
        welcomeLabel.text = "Welcome back"
        welcomeLabel.font = UIFont.specialFont(size: 19)
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 1
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 158.71),
             welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90.05)])
    }
    
    private func congfigureNameTF() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [nameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 80.82),
             nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44)])
    }
    
    private func configurePasswordTF() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 35),
             passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 43)])
    }
    
    private func configureButton() {
        let loginButton = LoginAndSignInButton(title: "Login")
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [loginButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 99),
             loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 43)])
    }
    
    @objc private func login() {
        //войти в аккаунт если данные такие есть, если нет, то написать, что такой аккаунт еще не зарегистрирован
    }
}

