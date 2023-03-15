//
//  AuthorizationViewModel.swift
//  TestApp
//
//  Created by Yulia Ignateva on 13.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

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
                if true { //смотрим по базе данных есть ли такой аакаунт
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
}
