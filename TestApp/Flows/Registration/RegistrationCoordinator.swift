//
//  SignInCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 13.03.2023.
//

import UIKit

final class RegistrationCoordinator: BaseCoordinator {
    let containerViewController: UIViewController
    
    init(containerViewController: UIViewController) {
        self.containerViewController = containerViewController
    }
    
    override func start() {
        let registrationViewModel = RegistrationViewModel()
        
        let registrationViewController = RegistrationViewController(
            registrationViewModel: registrationViewModel,
            didFinishRegistrationBlock: nil
            )
        registrationViewController.modalPresentationStyle = .fullScreen
        
        registrationViewController.didFinishRegistrationBlock = { [weak self] login in
            self?.closeRegistrationViewController(registrationViewController, login: login)
        }
        
        containerViewController.present(registrationViewController, animated: true)
    }
    
    func closeRegistrationViewController(_ viewController: RegistrationViewController, login: String?) {
        viewController.dismiss(animated: false, completion: { self.onFinish!(login) })
    }
}
