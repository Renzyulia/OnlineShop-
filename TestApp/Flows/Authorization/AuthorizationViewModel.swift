//
//  AuthorizationViewModel.swift
//  TestApp
//
//  Created by Yulia Ignateva on 13.03.2023.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

final class AuthorizationViewModel {
    
    private struct AuthorizationData {
        var firstName: String
        var password: String
    }
    
    private enum AuthorizationResult {
        case success(login: String)
        case accountIsNotRegistered
    }
    
    func bind(_ input: AuthorizationViewModelInput) -> AuthorizationViewModelOutput {
        let logIn = input.loginClick
            .withLatestFrom(input.firstName)
            .withLatestFrom(input.password) { AuthorizationData(firstName: $0, password: $1) }
            .map { [weak self] data -> AuthorizationResult in
                guard let self = self else { return .accountIsNotRegistered }
                if self.accountIsRegistered(login: data.firstName) {//смотрим по базе данных есть ли такой аакаунт
                    LoginStorage.shared.save(login: data.firstName)
                    return .success(login: data.firstName)
                } else {
                    return .accountIsNotRegistered
                }
            }
        
        let eventOnSuccessfulAuthorization = logIn
            .filter { result in
                switch result {
                case .success:
                    return true
                case .accountIsNotRegistered:
                    return false
                }
            }
            .map { result -> String in
                switch result {
                case let .success(login: login):
                    return login
                case .accountIsNotRegistered:
                    fatalError("Incorrect case")
                }
            }
            .asDriver(onErrorJustReturn: "")
        
        let shouldShowExistingLoginError = logIn
            .map { result in
                switch result {
                case .success:
                    return false
                case .accountIsNotRegistered:
                    return true
                }
            }
            .asDriver(onErrorJustReturn: false)
        
        return AuthorizationViewModelOutput(
            logInCompleted: eventOnSuccessfulAuthorization,
            shouldShowAccountIsNotRegistered: shouldShowExistingLoginError
        )
    }
    
    private func fetchData(_ context: NSManagedObjectContext) -> [Users] {
        var usersData = [Users]()
        do {
            usersData = try context.fetch(Users.fetchRequest())
        } catch {
            print("Error: \(error)")
        }
        return usersData
    }
    
    private func accountIsRegistered(login: String) -> Bool {
        let context = CoreData.shared.viewContext
        let fetchResult = fetchData(context)
        
        for user in fetchResult {
            if login == user.firstName {
                return true
            }
        }
        return false
    }
}
