//
//  View.swift
//  TestApp
//
//  Created by Yulia Ignateva on 16.03.2023.
//

import UIKit

final class PhotoView: UIView {
    let button = UIButton()
    
    var photo: UIImage? {
        didSet {
            photoView.image = photo
        }
    }
    
    private let photoView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        configurePhoto()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePhoto() {
        photoView.image = UIImage(named: "DefaultPhoto")
        photoView.frame = CGRect(x: 100, y: 100, width: 60.07, height: 60.06)
        photoView.layer.cornerRadius = 0.5 * photoView.bounds.size.width
        photoView.layer.masksToBounds = true
        
        addSubview(photoView)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoView.widthAnchor.constraint(equalToConstant: 60.07),
            photoView.heightAnchor.constraint(equalToConstant: 60.06),
            photoView.topAnchor.constraint(equalTo: topAnchor),
            photoView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            photoView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ])
    }
    
    private func configureButton() {
        button.setTitle("Change photo", for: .normal)
        button.setTitleColor(UIColor(named: "ChangePhoto"), for: .normal)
        button.titleLabel?.font = UIFont.specialFont(size: 9, style: .medium)

        addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 7.54),
            button.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 8.5),
            button.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
