//
//  MainPageViewModel.swift
//  TestApp
//
//  Created by Yulia Ignateva on 20.03.2023.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

final class MainPageViewModel {
    
    enum LoadingError: Error {
        case unknown
    }
    
    private let login: String
    
    init(login: String) {
        self.login = login
    }
    
    func bind(_ input: MainPageViewModelInput) -> MainPageViewModelOutput {
        let latestRequest = URLRequest(url: URL(string: "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7")!)
        let saleRequest = URLRequest(url: URL(string: "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac")!)
        
        let viewWillAppear = input.viewWillAppear
            .flatMapLatest { _ -> Observable<Result<Data, Error>> in
                let dataLatest = URLSession.shared.rx.data(request: latestRequest)
                    .map { (rawData: Foundation.Data) throws -> LatestResponse in
                        let jsonDecoder = JSONDecoder()
                        let response = try jsonDecoder.decode(LatestResponse.self, from: rawData)
                        return response
                    }
                let dataFlashSale = URLSession.shared.rx.data(request: saleRequest)
                    .map { (rawData: Foundation.Data) throws -> FlashSaleResponse in
                        let jsonDecoder = JSONDecoder()
                        let response = try jsonDecoder.decode(FlashSaleResponse.self, from: rawData)
                        return response
                    }
                
                return Observable.zip(dataLatest, dataFlashSale)
                    .map { (response1: LatestResponse, response2: FlashSaleResponse) -> Data in
                        return Data(latest: response1.latest, flashSale: response2.flash_sale)
                    }
                    .map { data in
                        return Result.success(data)
                    }
                    .catchAndReturn(.failure(LoadingError.unknown))
            }
            .asDriver(onErrorJustReturn: .failure(LoadingError.unknown))
        
        let photoProfileInstall = input.viewWillAppear
            .map { [weak self] in
                guard let self = self else { return UIImage(named: "DefaultPhoto")! }
                return self.photoInstalled(login: self.login) ?? UIImage(named: "DefaultPhoto")!
            }
            .asDriver(onErrorJustReturn: UIImage())
        
        return MainPageViewModelOutput(data: viewWillAppear, photoProfile: photoProfileInstall)
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
        return nil
    }
}
