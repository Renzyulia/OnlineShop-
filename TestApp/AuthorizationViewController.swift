//
//  AuthorizationViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 11.03.2023.
//

import UIKit

class AuthorizationViewController: ViewController {
    let securityButton = UIButton()
    
    override func viewDidLoad() {
        configureLabel()
        congfigureNameTF()
        configurePasswordTF()
        configureButton()
    }
    
    func configureLabel() {
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome back"
        welcomeLabel.font = UIFont(name: "Montserrat", size: 19)
        welcomeLabel.textAlignment = .center
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [welcomeLabel.widthAnchor.constraint(equalToConstant: 195.63),
             welcomeLabel.heightAnchor.constraint(equalToConstant: 19.47),
             welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 158.71),
             welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90.05)])
    }
    
    func congfigureNameTF() {
        let nameTextField = DataView(isSecureText: false, placeholder: "First name", securityButton: nil, width: .fullWidth)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [nameTextField.widthAnchor.constraint(equalToConstant: 289), //нужно ли здесь указываать ширину и высоту? Или он сам посчитает?
             nameTextField.heightAnchor.constraint(equalToConstant: 29),
             nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 259),
             nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 44)])
    }
    
    func configurePasswordTF() {
        let passwordTextField = DataView(isSecureText: true, placeholder: "Password", securityButton: securityButton, width: .shortWidth)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [passwordTextField.widthAnchor.constraint(equalToConstant: 289),
             passwordTextField.heightAnchor.constraint(equalToConstant: 29),
             passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 43),
             passwordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 323)])
    }
    
    func configureButton() {
        let loginButton = LoginAndSignUpButton(title: "Login")
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [loginButton.widthAnchor.constraint(equalToConstant: 289),
             loginButton.heightAnchor.constraint(equalToConstant: 46),
             loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 451),
             loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 43)])
    }
    
    @objc func login() {
        
    }
}

