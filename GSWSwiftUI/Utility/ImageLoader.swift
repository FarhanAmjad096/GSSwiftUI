//
//  ImageLoader.swift
//  GSWSwiftUI
//
//  Created by arhamsoft on 12/09/2019.
//  Copyright © 2019 Muhammad Irfan Zafar. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    var downloadedImage: UIImage?
    let didChange = PassthroughSubject<ImageLoader?, Never>()
    func load(url: String) {
        guard let imageURL = URL(string: url) else {
            fatalError("ImageURL is not correct!")
        }
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                     self.didChange.send(nil)
                }
                return
            }
            self.downloadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.didChange.send(self)
            }
        }.resume()
    }
}
