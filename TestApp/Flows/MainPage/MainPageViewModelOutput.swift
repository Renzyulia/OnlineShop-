//
//  MainPageViewModelOutput.swift
//  TestApp
//
//  Created by Yulia Ignateva on 07.04.2023.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

struct MainPageViewModelOutput {
    var data: Driver<Result<Data, Error>>
    var photoProfile: Driver<UIImage>
}
