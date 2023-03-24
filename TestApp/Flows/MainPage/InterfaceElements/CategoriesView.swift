//
//  CategoriesView.swift
//  TestApp
//
//  Created by Yulia Ignateva on 19.03.2023.
//

import UIKit

final class CategoriesView: UIView {
    
    enum Categories {
        case phones
        case headPhones
        case games
        case cars
        case furniture
        case kids
    }
    
    struct Category {
        let image: UIImage
        var text: String
        
        init(category: Categories) {
            switch category {
            case .phones:
                image = UIImage(named: "Phones")!
                text = "Phones"
            case .headPhones:
                image = UIImage(named: "Headphones")!
                text = "Headphones"
            case .games:
                image = UIImage(named: "Games")!
                text = "Games"
            case .cars:
                image = UIImage(named: "Cars")!
                text = "Cars"
            case .furniture:
                image = UIImage(named: "Furniture")!
                text = "Furniture"
            case .kids:
                image = UIImage(named: "Kids")!
                text = "Kids"
            }
        }
    }
    
    private let category: Category
    private let icon = UIImageView()
    private let label = UILabel()
    
    init(category: Category) {
        self.category = category
        super.init(frame: .zero)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        icon.image = category.image
        
        label.text = category.text
        label.textAlignment = .center
        label.textColor = UIColor(named: "CategoryColor")
        label.font = UIFont.specialFont(size: 9, style: .medium)
        
        addSubview(icon)
        addSubview(label)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 42.11),
            icon.heightAnchor.constraint(equalToConstant: 38),
            icon.topAnchor.constraint(equalTo: topAnchor),
            icon.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            icon.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 7),
            label.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 12.98),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
