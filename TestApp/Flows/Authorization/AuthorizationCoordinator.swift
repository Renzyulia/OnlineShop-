//
//  AuthorizationCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 14.03.2023.
//

import UIKit

class AuthorizationCoordinator: BaseCoordinator {
    let containerViewController: UIViewController
    
    init(containerViewController: UIViewController) {
        self.containerViewController = containerViewController
    }
    
    override func start() {
        let authorizationViewModel = AuthorizationViewModel()
        
        let authorizationViewController = AuthorizationViewController(
            authorizationViewModel: authorizationViewModel,
            didFinishAuthorizationBlock: nil
        )
        authorizationViewController.modalPresentationStyle = .fullScreen
        
        authorizationViewController.didFinishAuthorizationBlock = { [weak self] in
            self?.closeAuthorizationViewController(authorizationViewController)
        }
        
        containerViewController.present(authorizationViewController, animated: true)
    }
    
    private func closeAuthorizationViewController(_ viewController: AuthorizationViewController) {
        viewController.dismiss(animated: true, completion: { self.onFinish!() })
    }
}
