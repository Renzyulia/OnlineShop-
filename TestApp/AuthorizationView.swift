//
//  AuthorizationView.swift
//  TestApp
//
//  Created by Yulia Ignateva on 10.03.2023.
//

import UIKit

final class LoginAndSignUpButton: UIControl {
    private let button = UIButton()
    private let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        button.backgroundColor = UIColor(named: "AuthButtonColor")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 23
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
    }
}

final class DataView: UIView {
    private let textField = UITextField()
    private let securityButton: UIButton?
    private let width: Width
    private var isSecuryText: Bool
    private var placeholder: String
    
    init(isSecureText: Bool, placeholder: String, securityButton: UIButton?, width: Width) {
        self.isSecuryText = isSecureText
        self.placeholder = placeholder
        self.securityButton = securityButton
        self.width = width
        super.init(frame: .zero)
        configurePasswordView()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePasswordView() {
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.backgroundColor = UIColor(named: "LoginAndPasswordColor")
        textField.layer.cornerRadius = 14.5
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = isSecuryText
        
        self.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [textField.widthAnchor.constraint(equalToConstant: width.rawValue),
             textField.heightAnchor.constraint(equalToConstant: 29),
             textField.topAnchor.constraint(equalTo: self.topAnchor),
             textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             textField.leftAnchor.constraint(equalTo: self.leftAnchor)])
    }
    
    private func configureButton() {
        guard let button = securityButton else { return }
        
        button.setImage(UIImage(named: "SecurityOn"), for: .normal)
        
        self.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [button.widthAnchor.constraint(equalToConstant: 15),
             button.heightAnchor.constraint(equalToConstant: 15),
             button.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
             button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7),
             button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15)])
    }
    
    enum Width: CGFloat {
        case fullWidth = 289
        case shortWidth = 259
    }
}
