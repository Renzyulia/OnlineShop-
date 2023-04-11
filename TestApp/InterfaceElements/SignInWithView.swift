//
//  AuthorizationView.swift
//  TestApp
//
//  Created by Yulia Ignateva on 10.03.2023.
//

import UIKit

final class SignInWithView: UIControl {
    
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
    
    private let company: CompanyDetails
    private let textField = UITextField()
    private let icon = UIImageView()
    
    init(company: CompanyDetails) {
        self.company = company
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        textField.text = company.text
        textField.font = UIFont.specialFont(size: 13, style: .medium)
        icon.image = company.image
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(icon)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 150),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 33.66),
            textField.rightAnchor.constraint(equalTo: rightAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 23.83),
            icon.heightAnchor.constraint(equalToConstant: 26.22),
            icon.leftAnchor.constraint(equalTo: leftAnchor),
            icon.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
