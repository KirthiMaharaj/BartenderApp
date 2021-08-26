//
//  ImageExtension.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/26.
//

import Foundation
import UIKit

var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        if let img = imageCache.object(forKey: url.absoluteString as NSString)
        {
            self.image = img
        }
        else
        {
            contentMode = mode
            URLSession.shared.dataTask(with: url)
            { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                }
            }.resume()
        }
        
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
