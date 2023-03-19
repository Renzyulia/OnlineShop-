//
//  ProfileCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 16.03.2023.
//

import UIKit

final class ProfileCoordinator: BaseCoordinator {
    let containerViewController: UIViewController
    let login: String
    
    init(containerViewController: UIViewController, login: String) {
        self.containerViewController = containerViewController
        self.login = login
    }
    
    override func start() {
        super.start()
        
        let profileViewModel = ProfileViewModel(login: login)
        
        let profileViewController = ProfileViewController(
            login: login,
            didFinishProfileBlock: nil,
            viewModel: profileViewModel)
        
        profileViewController.modalPresentationStyle = .fullScreen
        
        profileViewController.didFinishProfileBlock = { [weak self] in
            self?.closeProfileViewController(profileViewController)
        }
        
        containerViewController.embed(profileViewController)
    }
    
    func closeProfileViewController(_ viewController: ProfileViewController) {
        viewController.dismiss(animated: true, completion: { self.onFinish!() })
    }
}
