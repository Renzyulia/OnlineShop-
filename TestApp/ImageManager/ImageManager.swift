//
//  ImageManager.swift
//  TestApp
//
//  Created by Yulia Ignateva on 21.03.2023.
//

import UIKit

final class ImageManager {
    static let shared = ImageManager()
    
    private var images = [URL: UIImage]()
    
    init() {}
    
    func loadImage(url: URL, completion: @escaping (UIImage) -> ()) {
        if let image = images[url] {
            completion(image)
        } else {
            getData(from: url, completion: { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.images[url] = UIImage(data: data)
                    completion((self?.images[url])!)
                }
            })
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Foundation.Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
