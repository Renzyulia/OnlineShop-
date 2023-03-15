//
//  SignInCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 13.03.2023.
//

import UIKit

final class RegistrationCoordinator: BaseCoordinator {
    let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() {
        let registrationViewModel = RegistrationViewModel()
        
        let registrationViewController = RegistrationViewController(
            registrationViewModel: registrationViewModel,
            didFinishRegistrationBlock: nil
            )
        
        registrationViewController.didFinishRegistrationBlock = { [weak self] in
            self?.closeRegistrationViewController(registrationViewController)
        }
        
        rootViewController.present(registrationViewController, animated: true)
    }
    
    func closeRegistrationViewController(_ viewController: RegistrationViewController) {
        viewController.dismiss(animated: true, completion: { self.onFinish!() })
    }
}
