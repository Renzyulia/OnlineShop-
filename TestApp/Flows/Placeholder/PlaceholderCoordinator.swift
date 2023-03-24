//
//  PlaceholderCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 17.03.2023.
//

import UIKit

final class PlaceholderCoordinator: BaseCoordinator {
    let containerViewController: UIViewController
    
    init(containerViewController: UIViewController) {
        self.containerViewController = containerViewController
    }
    
    override func start() {
        super.start()
        let placeholderViewController = PlaceholderViewController(backgroundColor: .lightGray)
        containerViewController.embed(placeholderViewController)
    }
}
