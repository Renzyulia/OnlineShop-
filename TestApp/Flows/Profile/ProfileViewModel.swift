//
//  ProfileViewModel.swift
//  TestApp
//
//  Created by Yulia Ignateva on 17.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

struct ProfileViewModelInput {
    var logOutClick: Observable<Void>
}

struct ProfileViewModelOutput {
    var logOutCompleted: Driver<Void>
}

class ProfileViewModel {
    private let login: String
    
    init(login: String) {
        self.login = login
    }
    
    func bind(_ input: ProfileViewModelInput) -> ProfileViewModelOutput {
        let handlelogOutTap = input.logOutClick
            .map { () -> LogOutResult in
                LoginStorage().delete(login: self.login)
                return .success
            }
        
        let eventOnSuccessfulLogOut = handlelogOutTap
            .filter({ (result: LogOutResult) -> Bool in return result == .success })
            .map({ (result: LogOutResult) -> Void in return () })
            .asDriver(onErrorJustReturn: ())
        
        return ProfileViewModelOutput(logOutCompleted: eventOnSuccessfulLogOut)
    }
    
    private enum LogOutResult {
        case success
    }
}
