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

struct MainPageViewModelInput {
    var viewWillAppear: Observable<Void>
}

struct MainPageViewModelOutput {
    var data: Driver<Result<Data, Error>>
    var photoProfile: Driver<UIImage?>
}

struct Data: Decodable {
    var latest: [Latest]
    var flashSale: [FlashSale]
}

struct LatestResponse: Decodable {
    var latest: [Latest]
}

struct Latest: Decodable {
    let category: String
    let name: String
    let price: Int
    let image_url: URL
}

struct FlashSaleResponse: Decodable {
    var flash_sale: [FlashSale]
}

struct FlashSale: Decodable {
    let category: String
    let name: String
    let price: Double
    let discount: Int
    let image_url: URL
}

enum LoadingError: Error {
    case unknown
}

final class MainPageViewModel {
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
                        var response: LatestResponse? = nil
                        do {
                            response = try jsonDecoder.decode(LatestResponse.self, from: rawData)
                        } catch {
                            print(error)
                        }
                        return response!
                    }
                let dataFlashSale = URLSession.shared.rx.data(request: saleRequest)
                    .map { (rawData: Foundation.Data) throws -> FlashSaleResponse in
                        let jsonDecoder = JSONDecoder()
                        var response: FlashSaleResponse? = nil
                        do {
                            response = try jsonDecoder.decode(FlashSaleResponse.self, from: rawData)
                        } catch {
                            print(error)
                        }
                        return response!
                    }
                
                return Observable.zip(dataLatest, dataFlashSale)
                    .map { (response1: LatestResponse, response2: FlashSaleResponse) -> Data in
                        return Data(latest: response1.latest, flashSale: response2.flash_sale)
                    }
                    .map { (data: Data) -> Result<Data, Error> in
                        return Result.success(data)
                    }
                    .catchAndReturn(Result.failure(LoadingError.unknown))
            }
            .asDriver(onErrorJustReturn: Result.failure(LoadingError.unknown))
        
        let photoProfileInstall = input.viewWillAppear
            .map {() -> UIImage? in
                return self.photoInstalled(login: self.login)
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
        return UIImage(named: "DefaultPhoto")
    }
}
