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
        
        profileViewController.didFinishProfileBlock = { [weak self] login in
            self?.closeProfileViewController(profileViewController, login: login)
        }
        
        containerViewController.embed(profileViewController)
    }
    
    private func closeProfileViewController(_ viewController: ProfileViewController, login: String?) {
        viewController.dismiss(animated: false, completion: { self.onFinish!(login) })
    }
}
