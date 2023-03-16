//
//  LogInAndSignInButton.swift
//  TestApp
//
//  Created by Yulia Ignateva on 15.03.2023.
//

import UIKit

final class LoginAndSignInButton: UIControl {
    private let title: String
    private let label = UILabel()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configureButton()
        configureLabel()
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
        label.font = UIFont.specialFont(size: 13, style: .bold)
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
