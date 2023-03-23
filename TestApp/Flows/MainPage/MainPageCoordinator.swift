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
        
        mainPageViewController.didFinishMainPageBlock = { [weak self] login in
            self?.closeMainPageViewController(mainPageViewController, login: login)
        }
        
        containerViewController.embed(navigationMainPageViewController)
    }
    
    private func closeMainPageViewController(_ viewController: MainPageViewController, login: String?) {
        viewController.dismiss(animated: true, completion: { self.onFinish!(login) })
    }
}
