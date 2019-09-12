//
//  HomeView.swift
//  GSWSwiftUI
//
//  Created by Muhammad Irfan Zafar on 11/09/2019.
//  Copyright © 2019 Muhammad Irfan Zafar. All rights reserved.
//

import SwiftUI
import Combine
struct HomeView: View {
    @ObservedObject var vM = HomeVM()
    var body: some View {
        VStack {
             AlbumRow(items: vM.Albums)
             TrackRow(items: vM.Tracks).background(Color.clear)
        }.background(Image("background").resizable().aspectRatio(contentMode: .fit))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
