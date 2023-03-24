//
//  UIImageView+loadImage.swift
//  TestApp
//
//  Created by Yulia Ignateva on 21.03.2023.
//

import UIKit

extension UIImageView {
    func loadImage(with url: URL) {
        ImageManager.shared.loadImage(url: url) { [weak self] image in
            self?.image = image
        }
    }
}
