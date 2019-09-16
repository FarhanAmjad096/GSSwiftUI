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
        HStack {
            if vM.viewState == .loading {
                ActivityIndicator(isAnimating: $vM.isLoading)
                //Text("Loading")
            }
            else if vM.viewState == .dataAvail {
                VStack {
                    AlbumRow(items: $vM.Albums)
                    TrackRow(items: $vM.Tracks)
                }.background(Image("background").resizable().aspectRatio(contentMode: .fit))
            }
            else if vM.viewState == .error  {
                Text(vM.didError.error)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct LegacyScrollView : UIViewRepresentable {
    // any data state, if needed

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        //let view = HomeView()
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator, action:
            #selector(Coordinator.handleRefreshControl),
                                          for: .valueChanged)

        // Simply to give some content to see in the app
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.text = "Scroll View Content"
        control.addSubview(label)

        return control
    }


    func updateUIView(_ uiView: UIScrollView, context: Context) {
    
        // code to update scroll view from view state, if needed
    }

    class Coordinator: NSObject {
        var control: LegacyScrollView

        init(_ control: LegacyScrollView) {
            self.control = control
        }

        @objc func handleRefreshControl(sender: UIRefreshControl) {
            // handle the refresh event

            sender.endRefreshing()
        }
    }
}
