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
        
        authorizationViewController.didFinishAuthorizationBlock = { [weak self] login in
            self?.closeAuthorizationViewController(authorizationViewController, login: login)
        }
        
        containerViewController.present(authorizationViewController, animated: false)
    }
    
    func closeAuthorizationViewController(_ viewController: AuthorizationViewController, login: String?) {
        viewController.dismiss(animated: false, completion: { self.onFinish!(login) })
    }
}
