//
//  SearchCell.swift
//  TestApp
//
//  Created by Yulia Ignateva on 21.03.2023.
//

import UIKit

final class SearchCell: UITableViewCell {
    private let textField = UITextField()
    private let icon = UIImageView(image: UIImage(named: "Search"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        textField.backgroundColor = UIColor(named: "TextFieldCell")
        textField.placeholder = "What are you looking for?"
        textField.font = UIFont.specialFont(size: 11, style: .medium)
        textField.textColor = .black
        textField.textAlignment = .center
        textField.layer.cornerRadius = 14.5
        textField.layer.masksToBounds = true
        
        contentView.addSubview(textField)
        contentView.addSubview(icon)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [textField.topAnchor.constraint(equalTo: contentView.topAnchor),
             textField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 57),
             textField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -56),
             textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
        
        NSLayoutConstraint.activate(
            [icon.widthAnchor.constraint(equalToConstant: 9),
             icon.heightAnchor.constraint(equalToConstant: 9),
             icon.rightAnchor.constraint(equalTo: textField.rightAnchor, constant: -17.5),
             icon.topAnchor.constraint(equalTo: textField.topAnchor, constant: 7.5),
             icon.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -7.5)])
    }
}
