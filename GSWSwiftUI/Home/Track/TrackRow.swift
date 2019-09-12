//
//  TrackRow.swift
//  GSWSwiftUI
//
//  Created by arhamsoft on 12/09/2019.
//  Copyright © 2019 Muhammad Irfan Zafar. All rights reserved.
//

import SwiftUI
struct TrackItem: View {
    var track: Track
    let width: CGFloat = 50.0
    let height: CGFloat = 50.0
    var body: some View {
        HStack {
            track.image
                .resizable()
                .frame(width: width, height: height)
            Text(verbatim: track.name)
            Spacer()
        }.background(Color.clear)
    }
}

struct TrackRow: View {
    var items: [Track]
    var body: some View {
        List (items) { item in
            TrackItem(track: item)
        }.background(Color.blue)
    }
}