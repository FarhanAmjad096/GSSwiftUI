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
    var body: some View {
        HStack {
            URLImage(URL(string: track.trackArtWork)!)
                .resizable()
                .frame(width: 50.0, height: 50.0)
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
