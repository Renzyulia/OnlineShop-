//
//  AppCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 10.03.2023.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    let window: UIWindow
    
    private let viewController = UIViewController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        window.rootViewController = viewController
        
        if let login = LoginStorage.shared.getLogin() {
            startAuthorizedUserFlow(login: login)
        } else {
            startAuthorizationFlow()
        }
    }
    
    private func startAuthorizedUserFlow(login: String) {
        let tabBarCoordinator = TabBarCoordinator(containerViewController: viewController, login: login)
        tabBarCoordinator.onFinish = { [weak self, weak tabBarCoordinator] login in
            guard let self = self, let tabBarCoordinator = tabBarCoordinator else { return }
            self.removeChildCoordinator(tabBarCoordinator)
            self.startAuthorizationFlow()
        }
        addChildCoordinator(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
    private func startAuthorizationFlow() {
        let registrationCoordinator = RegistrationCoordinator(containerViewController: viewController)
        registrationCoordinator.onFinish = { [weak self, weak registrationCoordinator] login in
            guard let self = self, let registrationCoordinator = registrationCoordinator else { return }
            self.removeChildCoordinator(registrationCoordinator)
            
            if login != nil {
                self.start() // here
            } else {
                let authorizationCoordinator = AuthorizationCoordinator(containerViewController: self.viewController)
                authorizationCoordinator.onFinish = { [weak self, weak authorizationCoordinator] login in
                    guard let self = self, let authorizationCoordinator = authorizationCoordinator else { return }
                    self.removeChildCoordinator(authorizationCoordinator)
                    self.startAuthorizedUserFlow(login: login!) // here
                }
                self.addChildCoordinator(authorizationCoordinator)
                authorizationCoordinator.start()
            }
        }
        addChildCoordinator(registrationCoordinator)
        registrationCoordinator.start()
    }
}


