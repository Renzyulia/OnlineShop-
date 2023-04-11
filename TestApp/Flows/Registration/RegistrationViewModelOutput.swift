//
//  RegistrationViewModelOutput.swift
//  TestApp
//
//  Created by Yulia Ignateva on 07.04.2023.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

struct RegistrationViewModelOutput {
    var shouldShowInvalidEmailError: Driver<Void>
    var shouldShowExistingLoginError: Driver<Bool>
    var registrationIsCompleted: Driver<Void>
    var shouldShowSavingError: Driver<Void>
}
