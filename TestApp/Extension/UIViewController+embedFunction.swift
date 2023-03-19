//
//  UIViewController + .swift
//  TestApp
//
//  Created by Yulia Ignateva on 19.03.2023.
//

import UIKit

extension UIViewController {
    func embed(_ viewController: UIViewController) {
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.frame = self.view.bounds
        viewController.didMove(toParent: self)
    }
}
