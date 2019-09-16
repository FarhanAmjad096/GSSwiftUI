//
//  AlbumView.swift
//  GSWSwiftUI
//
//  Created by arhamsoft on 12/09/2019.
//  Copyright © 2019 Muhammad Irfan Zafar. All rights reserved.
//

import SwiftUI

struct AlbumRow: View {
    @Binding var items: [Album]
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
        VStack(alignment: .leading) {
            album.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(album.name)
                .foregroundColor(.white)
                .font(.caption)
        }
        .padding(.leading, 15)

    }
}

/*
struct AlbumRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(
            categoryName: landmarkData[0].category.rawValue,
            items: Array(landmarkData.prefix(4))
        )
        .environmentObject(UserData())
    }
}*/
