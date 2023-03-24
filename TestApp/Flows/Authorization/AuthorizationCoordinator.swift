//
//  AuthorizationCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 14.03.2023.
//

import UIKit

final class AuthorizationCoordinator: BaseCoordinator {
    let containerViewController: UIViewController
    
    init(containerViewController: UIViewController) {
        self.containerViewController = containerViewController
    }
    
    override func start() {
        let authorizationViewModel = AuthorizationViewModel()
        
        let authorizationViewController = AuthorizationViewController(
            authorizationViewModel: authorizationViewModel
        )
        authorizationViewController.modalPresentationStyle = .fullScreen
        
        authorizationViewController.didFinishAuthorizationBlock = { [weak self, weak authorizationViewController] login in
            guard let self = self, let authorizationViewController = authorizationViewController else { return }
            self.close(authorizationViewController, login: login)
        }
        
        containerViewController.present(authorizationViewController, animated: false)
    }
    
    private func close(_ viewController: AuthorizationViewController, login: String?) {
        viewController.dismiss(animated: false) { self.onFinish?(login) }
    }
}
