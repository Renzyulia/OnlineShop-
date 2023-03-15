//
//  SignInViewModel.swift
//  TestApp
//
//  Created by Yulia Ignateva on 13.03.2023.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

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
    var shouldShowSavingError: Driver<Void>
}

final class RegistrationViewModel {
    
    func bind(_ input: RegistrationViewModelInput) -> RegistrationViewModelOutput {
        let name = input.signInClick
            .withLatestFrom(input.firstName)
            .withLatestFrom(input.lastName, resultSelector: { firstName, lastName in return FullName(firstName: firstName, lastName: lastName) })
        
        let register = input.signInClick
            .withLatestFrom(name)
            .withLatestFrom(input.email, resultSelector: { fullName, email in return RegistrationData(fullName: fullName, email: email) })
            .map { data -> RegistrationResult in
                if !self.isValidEmail(data.email) { //если email неверного формата
                    return .invalidEmail
                } else if self.duplicateAccount(login: data.fullName.firstName) { //проверяем, что нет уже такого аккаунта
                    return .duplicate
                } else {
                    let context = CoreData.shared.viewContext
                    let object = Users(context: context)
                    object.firstName = data.fullName.firstName
                    object.lastName = data.fullName.lastName
                    object.email = data.email
                    do {
                        try context.save()
                        LoginStorage().save(login: data.fullName.firstName)
                        return .success
                    } catch {
                        print("save error")
                        return .savingError
                    }
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
        
        let shouldShowSavingError = register
            .filter({ (result: RegistrationResult) -> Bool in return result == .savingError })
            .map({ (result: RegistrationResult) -> Void in return () })
            .asDriver(onErrorJustReturn: ())
        
        
        return RegistrationViewModelOutput(
            shouldShowInvalidEmailError: shouldShowInvalidEmailError,
            shouldShowExisitingLoginError: shouldShowExistingLoginErrorOnRegistration,
            registrationIsCompleted: eventOnSuccessfulRegistration,
            shouldShowSavingError: shouldShowSavingError)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
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
    
    private func duplicateAccount(login: String) -> Bool {
        let context = CoreData.shared.viewContext
        let fetchResult = fetchData(context)
        
        var duplicate = false
        for user in fetchResult {
            if login == user.firstName {
                duplicate = true
                break
            }
        }
        return duplicate
    }
    
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
        case savingError
        case success
        
    }
}
