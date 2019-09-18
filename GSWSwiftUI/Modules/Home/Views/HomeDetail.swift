//
//  HomeDetail.swift
//  GSWSwiftUI
//
//  Created by arhamsoft on 17/09/2019.
//  Copyright © 2019 Muhammad Irfan Zafar. All rights reserved.
//

import SwiftUI
import URLImage
struct TrackDetail: View {
    var item: Track
    var body: some View {
        URLImage(URL(string: item.trackArtWork)!)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
struct AlbumDetail: View {
    var item: Album
    var body: some View {
        URLImage(URL(string: item.albumArtWork)!)
            .resizable()
            .frame(width: 155.0, height: 155.0)
            .cornerRadius(5.0)
    }
}
