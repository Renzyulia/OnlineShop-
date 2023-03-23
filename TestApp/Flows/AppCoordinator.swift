//
//  AppCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 10.03.2023.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let viewController = UIViewController()
        window.rootViewController = viewController
        
        if LoginStorage.shared.getLogin() != nil {
            let login = LoginStorage.shared.getLogin()
            let tabBarCoordinator = TabBarCoordinator(containerViewController: viewController, login: login!)
            tabBarCoordinator.onFinish = { [weak self] login in
                self?.removeChildCoordinator(tabBarCoordinator)
                self?.start()
            }
            addChildCoordinator(tabBarCoordinator)
            tabBarCoordinator.start()
        } else {
            let registrationCoordinator = RegistrationCoordinator(containerViewController: viewController)
            registrationCoordinator.onFinish = { [weak self] login in
                self?.removeChildCoordinator(registrationCoordinator)
                
                if login != nil {
                    self?.start()
                } else {
                    let authorizationCoordinator = AuthorizationCoordinator(containerViewController: viewController)
                    authorizationCoordinator.onFinish = { [weak self] login in
                        self?.removeChildCoordinator(authorizationCoordinator)
                        self?.start()
                    }
                    self?.addChildCoordinator(authorizationCoordinator)
                    authorizationCoordinator.start()
                }
            }
            addChildCoordinator(registrationCoordinator)
            registrationCoordinator.start()
        }
    }
}


