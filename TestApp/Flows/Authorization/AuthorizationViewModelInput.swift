//
//  AuthorizationViewModelInput.swift
//  TestApp
//
//  Created by Yulia Ignateva on 07.04.2023.
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
