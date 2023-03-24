//
//  BaseCoordinator.swift
//  TestApp
//
//  Created by Yulia Ignateva on 10.03.2023.
//

import Foundation

class BaseCoordinator {
    var childCoordinators = [BaseCoordinator]()
    var onFinish: ((String?) -> Void)?
    
    func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        for index in 0..<childCoordinators.count {
            if childCoordinators[index] === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func start() {
    }
}
