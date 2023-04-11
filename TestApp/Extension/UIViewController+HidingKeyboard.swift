//
//  UIViewController+HidingKeyboard.swift
//  TestApp
//
//  Created by Yulia Ignateva on 10.04.2023.
//

import UIKit

extension UIViewController {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}
