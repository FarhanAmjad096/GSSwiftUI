//
//  AlbumView.swift
//  GSWSwiftUI
//
//  Created by arhamsoft on 12/09/2019.
//  Copyright © 2019 Muhammad Irfan Zafar. All rights reserved.
//

import SwiftUI
import URLImage
struct AlbumRow: View {
    @Binding var items: [Album]
    @ObservedObject var imageLoader = ImageLoader()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(self.items) { item in
                    AlbumItem(album: item)
                }
            }
        }
        .frame(height: 185)
    }
}

struct AlbumItem: View {
    var album: Album
    var body: some View {
        VStack (alignment: .leading) {
            URLImage(URL(string: album.albumArtWork)!)
                .resizable()
                .cornerRadius(5.0)
            Text(album.name)
                .foregroundColor(.black)
                .font(.caption)
        }
        .padding(.leading, 15)
        
    }
}
