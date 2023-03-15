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

struct AuthorizationViewModelInput {
    var loginClick: Observable<Void>
    var firstName: Observable<String>
    var password: Observable<String>
}

struct AuthorizationViewModelOutput {
    var logInCompleted: Driver<Void>
    var shouldShowAccountIsNotRegistered: Driver<Bool>
}

final class AuthorizationViewModel {
    
    private struct AuthorizationData {
        var firstName: String
        var password: String
    }
    
    private enum AuthorizationResult {
        case success
        case accountIsNotRegistered
    }
    
    func bind(_ input: AuthorizationViewModelInput) -> AuthorizationViewModelOutput {
        let logIn = input.loginClick
            .withLatestFrom(input.firstName)
            .withLatestFrom(input.password, resultSelector: { firstName, password in return AuthorizationData(firstName: firstName, password: password) })
            .map{ data -> AuthorizationResult in
                if self.accountIsRegistered(login: data.firstName) { //смотрим по базе данных есть ли такой аакаунт
                    return .success
                } else {
                    return .accountIsNotRegistered
                }
            }
        
        let eventOnSuccessfulAuthorization = logIn
            .filter({ (result: AuthorizationResult) -> Bool in return result == .success })
            .map({ (result: AuthorizationResult) -> Void in return () })
            .asDriver(onErrorJustReturn: ())
        
        let shouldShowExistingLoginError = logIn
            .map({ (result: AuthorizationResult) -> Bool in return result == .accountIsNotRegistered })
            .asDriver(onErrorJustReturn: false)
        
        return AuthorizationViewModelOutput(
            logInCompleted: eventOnSuccessfulAuthorization,
            shouldShowAccountIsNotRegistered: shouldShowExistingLoginError)
    }
    
    private func fetchData(_ context: NSManagedObjectContext) -> [Users] {
        var usersData = [Users]()
        do {
            usersData = try context.fetch(Users.fetchRequest())
        } catch {
            print("error")
        }
        return usersData
    }
    
    private func accountIsRegistered(login: String) -> Bool {
        let context = CoreData.shared.viewContext
        let fetchResult = fetchData(context)
        
        var isRegistered = false
        for user in fetchResult {
            if login == user.firstName {
                isRegistered = true
                break
            }
        }
        return isRegistered
    }
}
