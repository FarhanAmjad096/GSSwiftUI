//
//  Track.swift
//  RxSwiftPractice
//
//  Created by arhamsoft on 24/07/2019.
//  Copyright © 2019 arhamsoft. All rights reserved.
//

import SwiftUI

struct Track: Codable, Identifiable {
    let id, name, trackArtWork, trackAlbum: String
    let artist: String
    @ObservedObject private var imageLoader = ImageLoader()
    enum CodingKeys: String, CodingKey {
        case id, name
        case trackArtWork = "track_art_work"
        case trackAlbum = "track_album"
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
extension Track {
    init?(data: Data) {
        do {
            let me = try JSONDecoder().decode(Track.self, from: data)
            self = me
            self.imageLoader.load(url:me.trackArtWork)
        }
        catch {
            print(error)
            return nil
        }
    }
}
