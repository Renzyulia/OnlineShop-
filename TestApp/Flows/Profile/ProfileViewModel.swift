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

final class ProfileViewModel {
    
    private enum LogOutResult {
        case success
    }
    
    private let login: String
    
    init(login: String) {
        self.login = login
    }
    
    func bind(_ input: ProfileViewModelInput) -> ProfileViewModelOutput {
        let handleLogOutTap = input.logOutClick
            .map { _ -> LogOutResult in
                LoginStorage().delete(login: self.login)
                return .success
            }
        
        let viewWillAppear = input.viewWillAppear
            .map { [weak self] _ -> UIImage? in
                guard let self = self else { return nil }
                return self.photoInstalled(login: self.login)
            }
            .asDriver(onErrorJustReturn: nil)
        
        let handleChangePhotoTap = input.changePhotoClick
            .map { [weak self] image in
                guard let self = self else { return image }
                if self.savePhoto(login: self.login, image) {
                    return image
                } else {
                    return UIImage(named: "DefaultPhoto")!
                }
            }
            .asDriver(onErrorJustReturn: UIImage(named: "DefaultPhoto")!)
        
        let eventOnSuccessfulLogOut = handleLogOutTap
            .filter { result in result == .success }
            .map { _ in return () }
            .asDriver(onErrorJustReturn: ())
        
        return ProfileViewModelOutput(
            logOutCompleted: eventOnSuccessfulLogOut,
            photoProfile: viewWillAppear,
            photoProfileChanged: handleChangePhotoTap
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
    
    private func photoInstalled(login: String) -> UIImage? {
        let context = CoreData.shared.viewContext
        let fetchResult = fetchData(context)

        for user in fetchResult {
            if login == user.firstName {
                if let photo = user.photo {
                    return UIImage(data: photo)
                }
            }
        }
        return UIImage(named: "DefaultPhoto")
    }
    
    private func savePhoto(login: String, _ image: UIImage) -> Bool {
        let context = CoreData.shared.viewContext
        let fetchResult = fetchData(context)
        
        for user in fetchResult {
            if login == user.firstName {
                user.photo = image.jpegData(compressionQuality: 0.8)
                do {
                    try context.save()
                    return true
                } catch {
                    print("Save error: \(error)")
                    return false
                }
            }
        }
        
        return false
    }
}
