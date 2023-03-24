//
//  DataView.swift
//  TestApp
//
//  Created by Yulia Ignateva on 15.03.2023.
//

import UIKit

final class DataTextField: UIView {
    let textField = UITextField()
    let securityButton: UIButton?
    
    private var isSecureText: Bool
    private var placeholder: String
    
    init(isSecureText: Bool, placeholder: String, securityButton: UIButton?) {
        self.isSecureText = isSecureText
        self.placeholder = placeholder
        self.securityButton = securityButton
        super.init(frame: .zero)
        configureTextFieldView()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextFieldView() {
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.font = UIFont.specialFont(size: 11, style: .medium)
        textField.backgroundColor = UIColor(named: "DataTextField")
        textField.layer.cornerRadius = 14.5
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = isSecureText
        
        self.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 294),
            textField.heightAnchor.constraint(equalToConstant: 29),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
    
    private func configureButton() {
        guard let button = securityButton else { return }
        
        button.setImage(UIImage(named: "SecurityOn"), for: .normal)
        
        addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 15),
            button.heightAnchor.constraint(equalToConstant: 15),
            button.topAnchor.constraint(equalTo: textField.topAnchor, constant: 7),
            button.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -7),
            button.rightAnchor.constraint(equalTo: textField.rightAnchor, constant: -15)
        ])
        
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
}
