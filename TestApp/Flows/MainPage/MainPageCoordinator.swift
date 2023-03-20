//
//  MainPageCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 17.03.2023.
//

import UIKit

final class MainPageCoordinator: BaseCoordinator {
    let containerViewController: UIViewController
    
    init(containerViewController: UIViewController) {
        self.containerViewController = containerViewController
    }
    
    override func start() {
        super.start()
        
        let mainPageViewController = MainPageViewController()
        mainPageViewController.modalPresentationStyle = .fullScreen
        
        let navigationMainPageViewController = UINavigationController(rootViewController: mainPageViewController)
        
        containerViewController.embed(navigationMainPageViewController)
    }
}
