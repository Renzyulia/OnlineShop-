//
//  TabBarCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 17.03.2023.
//

import UIKit

final class TabBarCoordinator: BaseCoordinator, TabBarCoordinatorDelegate {
    let containerViewController: UIViewController
    let login: String
    let tabBarDelegate = TabBarDelegate()
    
    init(containerViewController: UIViewController, login: String) {
        self.containerViewController = containerViewController
        self.login = login
        super.init()
        tabBarDelegate.delegate = self
    }
    
    override func start() {
        let mainPageViewController = UIViewController()
        let placeholderFirstViewController = UIViewController()
        let placeholderSecondViewController = UIViewController()
        let placeholderThirdViewController = UIViewController()
        let profileViewController = UIViewController()
        
        let mainPageCoordinator = MainPageCoordinator(containerViewController: mainPageViewController)
        let placeholderFirstCoordinator = PlaceholderCoordinator(containerViewController: placeholderFirstViewController)
        let placeholderSecondCoordinator = PlaceholderCoordinator(containerViewController: placeholderSecondViewController)
        let placeholderThirdCoordinator = PlaceholderCoordinator(containerViewController: placeholderThirdViewController)
        let profileCoordinator = ProfileCoordinator(containerViewController: profileViewController, login: login)
        
        addChildCoordinator(mainPageCoordinator)
        addChildCoordinator(placeholderFirstCoordinator)
        addChildCoordinator(placeholderSecondCoordinator)
        addChildCoordinator(placeholderThirdCoordinator)
        addChildCoordinator(profileCoordinator)
        
        let tabBarViewController = TabBarViewController()
        
        tabBarViewController.delegate = tabBarDelegate
        
        tabBarViewController.setViewControllers(
            [mainPageViewController,
             placeholderFirstViewController,
             placeholderSecondViewController,
             placeholderThirdViewController,
             profileViewController],
            animated: false)
        
        guard let viewControllers = tabBarViewController.tabBar.items else { return }

        let icons = ["MainPage", "FirstPlaceholder", "SecondPlaceholder", "ThirdPlaceholder", "Profile"]
        
        for item in 0..<viewControllers.count {
            viewControllers[item].image = UIImage(named: icons[item])
        }
        
        tabBarViewController.modalPresentationStyle = .fullScreen
        containerViewController.present(tabBarViewController, animated: true)
        mainPageCoordinator.start()
    }
    
    func didSelect(item: Int) {
        self.childCoordinators[item].start()
    }
}
