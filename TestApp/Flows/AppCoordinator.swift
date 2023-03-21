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
            //запускаем окно аккаунта
        } else {
            let login = "Satria Adhi Pradana"
            let registrationCoordinator = RegistrationCoordinator(containerViewController: viewController)
            addChildCoordinator(registrationCoordinator)
            registrationCoordinator.start()
        }
    }
}


