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
    
    private init() {}
    
    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let image = images[url] {
            completion(image)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    guard let data = data, error == nil else {
                        completion(nil)
                        return
                    }
                    self.images[url] = UIImage(data: data)
                    completion(self.images[url]!)
                }
            }.resume()
        }
    }
}
