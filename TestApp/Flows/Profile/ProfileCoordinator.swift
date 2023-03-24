//
//  ProfileCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 16.03.2023.
//

import UIKit

final class ProfileCoordinator: BaseCoordinator {
    let containerViewController: UIViewController
    private let login: String
    
    init(containerViewController: UIViewController, login: String) {
        self.containerViewController = containerViewController
        self.login = login
    }
    
    override func start() {
        super.start()
        
        let profileViewModel = ProfileViewModel(login: login)
        
        let profileViewController = ProfileViewController(login: login, viewModel: profileViewModel)
        
        profileViewController.didFinishProfileBlock = { [weak self] login in
            self?.onFinish?(login)
        }
        
        containerViewController.embed(profileViewController)
    }
}
