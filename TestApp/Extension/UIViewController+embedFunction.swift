//
//  UIViewController + .swift
//  TestApp
//
//  Created by Yulia Ignateva on 19.03.2023.
//

import UIKit

extension UIViewController {
    func embed(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.didMove(toParent: self)
    }
}
