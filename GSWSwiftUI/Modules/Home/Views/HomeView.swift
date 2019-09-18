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
            }
            else if vM.viewState == .dataAvail {
                // Without listView Sections
                /*
                 ScrollView(.vertical, showsIndicators: false) {
                 VStack {
                 PageView(vM.Albums.map { CardView(album: $0) }).frame(height: 250)
                 AlbumRow(items: $vM.Albums)
                 
                 ForEach(vM.Tracks) { item in
                 TrackItem(track: item)
                 }.padding(.leading, 20)
                 }
                 }*/
                
                // With listView Sections
                NavigationView {
                    List {
                        PageView(vM.Albums.map { CardView(album: $0) }).frame(height: 250)
//                        Section(header: Text("New Albums")) {
//                            ScrollView (.horizontal, showsIndicators: false) {
//                                HStack {
//                                    ForEach(vM.Albums) { item in
//                                        NavigationLink (destination: AlbumDetail(item: item)) {
//                                            AlbumItem(album: item)
//                                        }
//                                    }
//                                    //    AlbumRow(items: $vM.Albums)
//                                }
//                            }
//                        }
                        Section(header: Text("Albums")) {
                            AlbumRow(items: $vM.Albums)
                        }
                        Section(header: Text("Tracks")) {
                            ForEach(vM.Tracks) { item in
                                NavigationLink (destination: TrackDetail(item: item)){
                                    TrackItem(track: item).frame(height: 50)
                                }
                            }
                        }
                    }
                }.navigationBarTitle(Text("Featured"))
                    //.foregroundColor(.black))
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
