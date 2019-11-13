//
//  ScoreView.swift
//  GSWSwiftUI
//
//  Created by arhamsoft on 18/09/2019.
//  Copyright © 2019 Muhammad Irfan Zafar. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var comment: Comments
    var body: some View {
        VStack {
            Button(action: {
                self.comment.count += 1
            }) {
                Text("Your Video count: \(self.comment.count)")
            }
            NavigationLink(destination: ScoreView().environmentObject(comment)) {
                Text("Show Detail View")
            }
            Spacer()
        }
    }
}
