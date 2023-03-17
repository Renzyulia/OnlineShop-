//
//  View.swift
//  TestApp
//
//  Created by Yulia Ignateva on 16.03.2023.
//

import UIKit

final class PhotoView: UIView {
    let photo: UIImage?
    private let photoView = UIImageView()
    let button = UIButton()
    
    init(photo: UIImage?) {
        self.photo = photo
        super.init(frame: .zero)
        configurePhoto()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePhoto() {
        photoView.frame = CGRect(x: 100, y: 100, width: 60.07, height: 60.06)
        photoView.layer.cornerRadius = 0.5 * photoView.bounds.size.width
        photoView.layer.masksToBounds = true
        
        if photo != nil {
            photoView.image = photo
        } else {
            photoView.image = UIImage(named: "DefaultPhoto")
        }
        
        self.addSubview(photoView)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [photoView.widthAnchor.constraint(equalToConstant: 60.07),
             photoView.heightAnchor.constraint(equalToConstant: 60.06),
             photoView.topAnchor.constraint(equalTo: self.topAnchor),
             photoView.leftAnchor.constraint(equalTo: self.leftAnchor)])
    }
    
    func configureButton() {
        button.setTitle("Change photo", for: .normal)
        button.setTitleColor(UIColor(named: "ChangePhoto"), for: .normal)
        button.titleLabel?.font = UIFont.specialFont(size: 9, style: .medium)
        
        self.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [button.heightAnchor.constraint(equalToConstant: 7.54),
             button.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 8.5)])
    }
    
    
}
