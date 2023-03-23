//
//  LocationLabel.swift
//  TestApp
//
//  Created by Yulia Ignateva on 22.03.2023.
//

import UIKit

final class LocationView: UIView {
    private let label = UILabel()
    private let imageView = UIImageView(image: UIImage(named: "Location"))
    
    init() {
        super.init(frame: .zero)
        configureLabel()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel() {
        label.text = "Location"
        label.textColor = UIColor(named: "LocationLabelColor")
        label.font = UIFont.specialFont(size: 9, style: .medium)
        
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [label.topAnchor.constraint(equalTo: self.topAnchor),
             label.leftAnchor.constraint(equalTo: self.leftAnchor),
             label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12)])
    }
    
    private func configureImageView() {
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
             imageView.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 4.38)])
    }
}
