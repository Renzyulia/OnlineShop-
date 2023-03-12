//
//  AuthorizationView.swift
//  TestApp
//
//  Created by Yulia Ignateva on 10.03.2023.
//

import UIKit

extension UIFont {
    static func specialFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat", size: size)!
    }
}

final class LoginAndSignInButton: UIControl {
    private let title: String
    private let label = UILabel()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        self.backgroundColor = UIColor(named: "LoginAndSignInButton")
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 23
        self.contentHorizontalAlignment = .center
    }
    
    private func configureLabel() {
        label.text = title
        label.textColor = .white
        label.font = UIFont.specialFont(size: 13)
        label.numberOfLines = 1
        
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [label.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.98),
             label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 121.05),
             label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15.17),
             label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -120.63)])
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
        textField.font = UIFont.specialFont(size: 23)
        textField.backgroundColor = UIColor(named: "DataTextField")
        textField.layer.cornerRadius = 14.5
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = isSecuryText
        
        self.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [textField.widthAnchor.constraint(equalToConstant: width.rawValue),
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        button.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        if textField.isSecureTextEntry {
            textField.isSecureTextEntry = false
            securityButton?.setImage(UIImage(named: "SecurityOff"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            securityButton?.setImage(UIImage(named: "SecurityOn"), for: .normal)
        }
    }
    
    enum Width: CGFloat {
        case fullWidth = 289
        case shortWidth = 259
    }
}

final class SignInWithView: UIControl {
    let company: CompanyDetails
    let textField = UITextField()
    let icon = UIImageView()
    
    init(company: CompanyDetails) {
        self.company = company
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        textField.text = company.text
        textField.font = UIFont.specialFont(size: 11)
        icon.image = company.image
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(textField)
        self.addSubview(icon)
        
        NSLayoutConstraint.activate(
            [textField.widthAnchor.constraint(equalToConstant: 112.82)])
        
        NSLayoutConstraint.activate(
            [icon.widthAnchor.constraint(equalToConstant: 23.83),
             icon.heightAnchor.constraint(equalToConstant: 24.22),
             icon.rightAnchor.constraint(equalTo: textField.leftAnchor, constant: 11.66)
        ])
    }
    
    enum Company {
        case apple
        case google
    }
    
    struct CompanyDetails {
        let image: UIImage
        var text: String
        
        init(company: Company) {
            switch company {
            case .apple:
                image = UIImage(named: "AppleIcon")!
                text = "Sign in with Apple"
            case .google:
                image = UIImage(named: "GoogleIcon")!
                text = "Sign in with Google"
            }
        }
    }
}
