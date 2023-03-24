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
        
        registrationViewController.didFinishRegistrationBlock = { [weak self, weak registrationViewController] login in
            guard let self = self, let registrationViewController = registrationViewController else { return }
            self.close(registrationViewController, login: login)
        }
        
        containerViewController.present(registrationViewController, animated: true)
    }
    
    private func close(_ viewController: RegistrationViewController, login: String?) {
        viewController.dismiss(animated: false) {
            self.onFinish?(login)
        }
    }
}
