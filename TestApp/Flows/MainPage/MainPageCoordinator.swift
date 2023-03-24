//
//  MainPageCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 17.03.2023.
//

import UIKit

final class MainPageCoordinator: BaseCoordinator {
    let containerViewController: UIViewController
    
    private let login: String
    
    init(containerViewController: UIViewController, login: String) {
        self.containerViewController = containerViewController
        self.login = login
    }
    
    override func start() {
        super.start()
        
        let mainPageViewModel = MainPageViewModel(login: login)
        
        let mainPageViewController = MainPageViewController(mainPageViewModel: mainPageViewModel)
        
        let navigationMainPageViewController = UINavigationController(rootViewController: mainPageViewController)
        
        mainPageViewController.didFinishMainPageBlock = { [weak self] login in
            self?.onFinish?(login)
        }
        
        containerViewController.embed(navigationMainPageViewController)
    }
}
