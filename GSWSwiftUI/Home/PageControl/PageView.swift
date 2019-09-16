/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view for bridging a UIPageViewController.
*/

import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    init(_ views: [Page]) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage).padding(.top, 200).padding(.trailing, 20)
        }
    }
}
struct CardView: View {
    var album: Album
    var body: some View {
        album.image
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
    }
}
//
//struct PageView_Previews: PreviewProvider {
//    static var previews: some View {
//        PageView(features.map { FeatureCard(landmark: $0) })
//    }
//}
