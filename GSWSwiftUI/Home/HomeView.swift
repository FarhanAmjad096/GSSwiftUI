//
//  HomeView.swift
//  GSWSwiftUI
//
//  Created by Muhammad Irfan Zafar on 11/09/2019.
//  Copyright © 2019 Muhammad Irfan Zafar. All rights reserved.
//

import SwiftUI
import UIKit
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
                    PageView(vM.Albums.map { CardView(album: $0) })
                    AlbumRow(items: $vM.Albums)
                    TrackRow(items: $vM.Tracks)
                }
                //.background(Image("background").resizable().aspectRatio(contentMode: .fit))
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

struct ScrollViewUIKit : UIViewRepresentable {
    // any data state, if needed
    let child = UIHostingController(rootView: HomeView())
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
        DispatchQueue.main.async {
            self.child.view.translatesAutoresizingMaskIntoConstraints = false
            self.child.view.frame = control.bounds
            control.addSubview(self.child.view)
        }
        return control
    }


    func updateUIView(_ uiView: UIScrollView, context: Context) {
    
        // code to update scroll view from view state, if needed
    }

    class Coordinator: NSObject {
        var control: ScrollViewUIKit

        init(_ control: ScrollViewUIKit) {
            self.control = control
        }
        @objc func handleRefreshControl(sender: UIRefreshControl) {
            // handle the refresh event
            control.child.rootView.vM.requestData()
            sender.endRefreshing()
        }
    }
}
