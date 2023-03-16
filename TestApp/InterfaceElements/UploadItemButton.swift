//
//  UploadItemButton.swift
//  TestApp
//
//  Created by Yulia Ignateva on 16.03.2023.
//

import UIKit

final class UploadItemButton: UIControl {
    private let icon = UIImageView(image: UIImage(named: "UploadItem"))
    private let label = UILabel()
    
    init() {
        super.init(frame: .zero)
        configureButton()
        configureLabel()
        configureIcon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureIcon() {
        self.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
             icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 14.25),
             icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 52.5)])
    }
    
    private func configureButton() {
        self.backgroundColor = UIColor(named: "LoginAndSignInButton")
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 16
    }
    
    private func configureLabel() {
        label.text = "Upload Item"
        label.textColor = .white
        label.font = UIFont.specialFont(size: 15, style: .bold)
        label.numberOfLines = 1
        
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [label.topAnchor.constraint(equalTo: self.topAnchor, constant: 14.19),
             label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 103.3),
             label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12.28),
             label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -103.16)])
    }
}
