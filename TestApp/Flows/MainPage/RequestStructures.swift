//
//  RequestStructures.swift
//  TestApp
//
//  Created by Yulia Ignateva on 08.04.2023.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

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
