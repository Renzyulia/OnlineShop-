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
        
        let mainPageViewModel = MainPageViewModel()
        
        let mainPageViewController = MainPageViewController(mainPageViewModel: mainPageViewModel)
        mainPageViewController.modalPresentationStyle = .fullScreen
        
        let navigationMainPageViewController = UINavigationController(rootViewController: mainPageViewController)
        
        mainPageViewController.didFinishMainPageBlock = { [weak self] in
            self?.closeProfileViewController(mainPageViewController)
        }
        
        containerViewController.embed(navigationMainPageViewController)
    }
    
    private func closeProfileViewController(_ viewController: MainPageViewController) {
        viewController.dismiss(animated: true, completion: { self.onFinish!() })
    }
}
