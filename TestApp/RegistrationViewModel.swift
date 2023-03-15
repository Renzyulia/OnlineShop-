//
//  SignInViewModel.swift
//  TestApp
//
//  Created by Yulia Ignateva on 13.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

struct RegistrationViewModelInput {
    var signInClick: Observable<Void>
    var firstName: Observable<String>
    var lastName: Observable<String>
    var email: Observable<String>
}

struct RegistrationViewModelOutput {
    var shouldShowInvalidEmailError: Driver<Void>
    var shouldShowExisitingLoginError: Driver<Bool>
    var registrationIsCompleted: Driver<Void>
}

final class RegistrationViewModel {
    
    private struct FullName {
        var firstName: String
        var lastName: String
    }
    
    private struct RegistrationData {
        var fullName: FullName
        var email: String
    }
    
    private enum RegistrationResult {
        case invalidEmail
        case duplicate
        case success
    }
    
    func bind(_ input: RegistrationViewModelInput) -> RegistrationViewModelOutput {
        let name = input.signInClick
            .withLatestFrom(input.firstName)
            .withLatestFrom(input.lastName, resultSelector: { firstName, lastName in return FullName(firstName: firstName, lastName: lastName) })
        
        let register = input.signInClick
            .withLatestFrom(name)
            .withLatestFrom(input.email, resultSelector: { fullName, email in return RegistrationData(fullName: fullName, email: email) })
            .map { data -> RegistrationResult in
                if !self.isValidEmail(data.email) { //если email
                    return .invalidEmail
                } else if true { //проверяем, что нет уже такого аккаунта
                    return .duplicate
                } else {
                    return .success
                }
            }
        
        let shouldShowInvalidEmailError = register
            .filter({ (result: RegistrationResult) -> Bool in return result == .invalidEmail })
            .map({ (result: RegistrationResult) -> Void in return () })
            .asDriver(onErrorJustReturn: ())
        
        let shouldShowExistingLoginErrorOnRegistration = register
            .map { (result: RegistrationResult) -> Bool in return result == .duplicate }
            .asDriver(onErrorJustReturn: false)
        
        let eventOnSuccessfulRegistration = register
            .filter({ (result: RegistrationResult) -> Bool in return result == .success })
            .map({ (result: RegistrationResult) -> Void in return () })
            .asDriver(onErrorJustReturn: ())
        
        return RegistrationViewModelOutput(
            shouldShowInvalidEmailError: shouldShowInvalidEmailError,
            shouldShowExisitingLoginError: shouldShowExistingLoginErrorOnRegistration,
            registrationIsCompleted: eventOnSuccessfulRegistration)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
