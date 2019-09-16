//
//  TrackRow.swift
//  GSWSwiftUI
//
//  Created by arhamsoft on 12/09/2019.
//  Copyright © 2019 Muhammad Irfan Zafar. All rights reserved.
//

import SwiftUI
import URLImage
struct TrackItem: View {
    var track: Track
    let width: CGFloat = 50.0
    let height: CGFloat = 50.0
    var body: some View {
        HStack {
            URLImage(URL(string: track.trackArtWork)!)
            .resizable()
            .frame(width: width, height: height)
            Text(verbatim: track.name)
            Spacer()
        }.background(Color.clear)
    }
}

struct TrackRow: View {
    @Binding var items: [Track]
    var body: some View {
        List (items) { item in
            TrackItem(track: item)
            }
    }
}
