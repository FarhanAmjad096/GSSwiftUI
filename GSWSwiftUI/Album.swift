//
//  Album.swift
//  RxSwiftPractice
//
//  Created by arhamsoft on 24/07/2019.
//  Copyright © 2019 arhamsoft. All rights reserved.
//

import Foundation
import SwiftUI
struct Album: Codable, Identifiable {
    @ObservedObject private var imageLoader = ImageLoader()
    let id, name, albumArtWork, artist: String
    enum CodingKeys: String, CodingKey {
        case id, name
        case albumArtWork = "album_art_work"
        case artist
    }
    var image: Image {
        if let uiImage = self.imageLoader.downloadedImage {
            return Image(uiImage: uiImage)
        } else {
            return Image("background")
        }
    }
}
// MARK: Convenience initializers

extension Album {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Album.self, from: data) else { return nil }
        self = me
        self.imageLoader.load(url:me.albumArtWork)
    }
}
