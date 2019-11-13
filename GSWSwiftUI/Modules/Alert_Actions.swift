//
//  Alert_Actions.swift
//  GSWSwiftUI
//
//  Created by arhamsoft on 18/09/2019.
//  Copyright © 2019 Muhammad Irfan Zafar. All rights reserved.
//

import SwiftUI

struct Alert_Actions: View {
    var body: some View {
        VStack {
            Action_Sheet()
            _Alert().offset(y: 5)
            context_Menu()
        }.padding(.bottom, 20)
    }
}

struct Alert_Actions_Previews: PreviewProvider {
    static var previews: some View {
        Alert_Actions()
    }
}

struct Action_Sheet: View {
    @State private var showingSheet = false
     var body: some View {
           Button(action: {
               self.showingSheet = true
           }) {
               Text("Show Action Sheet")
           }
           .actionSheet(isPresented: $showingSheet) {
            ActionSheet(title: Text("What do you want to do?"), message: Text("There's only one choice..."), buttons: [.default(Text("Dismiss Action Sheet")), .destructive(Text("Delete")), .cancel()])
           }
       }
}

struct _Alert: View {
    @State private var showingAlert = false

    var body: some View {
        Button(action: {
            self.showingAlert = true
        }) {
            Text("Show Alert")
        }
        .alert(isPresented:$showingAlert) {
            Alert(title: Text("Are you sure you want to delete this?"), message: Text("There is no undo"), primaryButton: .destructive(Text("Delete")) {
                    print("Deleting...")
            }, secondaryButton: .cancel())
        }
    }
}

struct context_Menu: View {
    var body: some View {
        Text("Tap 3d")
            .contextMenu {
                Button(action: {
                    // change country setting
                }) {
                    Text("Choose Country")
                    Image(systemName: "globe")
                }

                Button(action: {
                    // enable geolocation
                }) {
                    Text("Detect Location")
                    Image(systemName: "location.circle")
                }
            }
    }
}
