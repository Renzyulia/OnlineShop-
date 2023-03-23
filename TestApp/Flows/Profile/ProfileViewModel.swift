//
//  ProfileViewModel.swift
//  TestApp
//
//  Created by Yulia Ignateva on 17.03.2023.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

struct ProfileViewModelInput {
    var logOutClick: Observable<Void>
    var viewWillAppear: Observable<Void>
    var changePhotoClick: Observable<UIImage>
}

struct ProfileViewModelOutput {
    var logOutCompleted: Driver<Void>
    var photoProfile: Driver<UIImage?>
    var photoProfileChanged: Driver<UIImage>
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
        
        let viewWillAppear = input.viewWillAppear
            .map {() -> UIImage? in
                return self.photoInstalled(login: self.login)
            }
            .asDriver(onErrorJustReturn: UIImage())
        
        let handleChangePhotoTap = input.changePhotoClick
            .map { (image: UIImage) -> UIImage in
                if self.savePhoto(login: self.login, image) {
                    return image
                } else {
                    return UIImage(named: "DefaultPhoto")!
                }
            }
            .asDriver(onErrorJustReturn: UIImage(named: "DefaultPhoto")!)
        
        let eventOnSuccessfulLogOut = handlelogOutTap
            .filter({ (result: LogOutResult) -> Bool in return result == .success })
            .map({ (result: LogOutResult) -> Void in return () })
            .asDriver(onErrorJustReturn: ())
        
        return ProfileViewModelOutput(logOutCompleted: eventOnSuccessfulLogOut, photoProfile: viewWillAppear, photoProfileChanged: handleChangePhotoTap)
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
    
    private func photoInstalled(login: String) -> UIImage? {
        let context = CoreData.shared.viewContext
        let fetchResult = fetchData(context)

        for user in fetchResult {
            if login == user.firstName {
                if user.photo != nil {
                    return UIImage(data: user.photo!)
                }
            }
        }
        return UIImage(named: "DefaultPhoto")
    }
    
    private func savePhoto(login: String, _ image: UIImage) -> Bool {
        let context = CoreData.shared.viewContext
        let fetchResult = fetchData(context)
        
        var success = false
        
        for user in fetchResult {
            if login == user.firstName {
                user.photo = image.jpegData(compressionQuality: 0.8)
                do {
                    try context.save()
                    success = true
                } catch {
                    print("save error")
                    success = false
                }
            }
        }
        return success
    }
    
    private enum LogOutResult {
        case success
    }
}
