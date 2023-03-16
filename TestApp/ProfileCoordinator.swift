//
//  ProfileCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 16.03.2023.
//

import UIKit

final class ProfileCoordinator: BaseCoordinator {
    let rootViewController: UIViewController
    let login: String
    
    init(rootViewController: UIViewController, login: String) {
        self.rootViewController = rootViewController
        self.login = login
    }
    
    override func start() {
        super.start()
        
        let profileViewController = ProfileViewController(
            login: login,
            didFinishProfileBlock: nil)
        
        profileViewController.modalPresentationStyle = .fullScreen
        
        profileViewController.didFinishProfileBlock = { [weak self] in
            self?.closeProfileViewController(profileViewController)
        }
        
        rootViewController.present(profileViewController, animated: true)
    }
    
    func closeProfileViewController(_ viewController: ProfileViewController) {
        viewController.dismiss(animated: true, completion: { self.onFinish!() })
    }
}
