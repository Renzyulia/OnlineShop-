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
        backgroundColor = UIColor(named: "LoginAndSignInButton")
        layer.masksToBounds = true
        layer.cornerRadius = 17
        contentHorizontalAlignment = .center
    }
    
    private func configureLabel() {
        label.text = title
        label.textColor = .white
        label.font = UIFont.specialFont(size: 13, style: .bold)
        label.numberOfLines = 1
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 16.98),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15.17),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
