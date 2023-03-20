//
//  TabBarDelegate.swift
//  TestApp
//
//  Created by Yulia Ignateva on 17.03.2023.
//

import UIKit

final class TabBarDelegate: NSObject, UITabBarControllerDelegate {
    weak var delegate: TabBarCoordinatorDelegate?
    
    init(delegate: TabBarCoordinatorDelegate? = nil) {
        self.delegate = delegate
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch tabBarController.children.firstIndex(of: viewController)! {
        case 0: delegate?.didSelect(item: 0)
        case 1: delegate?.didSelect(item: 1)
        case 2: delegate?.didSelect(item: 2)
        case 3: delegate?.didSelect(item: 3)
        case 4: delegate?.didSelect(item: 4)
        default: return
        }
    }
}

protocol TabBarCoordinatorDelegate: AnyObject {
    func didSelect(item: Int)
}
