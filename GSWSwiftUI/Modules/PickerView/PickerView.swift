//
//  SwiftUIView.swift
//  GSWSwiftUI
//
//  Created by arhamsoft on 18/09/2019.
//  Copyright © 2019 Muhammad Irfan Zafar. All rights reserved.
//

import SwiftUI
struct PickerView : View {
    // 1.
    @State private var selection = 0
    let colors = ["Red","Yellow","Green","Blue"]
    
    var body: some View {
        // 2.
        VStack {
            Picker(selection: $selection, label:
            Text("Picker Name")) {
                ForEach(0 ..< colors.count) { index in
                    Text(self.colors[index]).tag(index)
                }
            }.labelsHidden()
            Text("Your selected Color is " + colors[selection])
        }
    }
}
struct DatePickerView: View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    @State private var birthDate = Date()

    var body: some View {
        VStack {
            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                Text("Select a date")
            }.labelsHidden()
            Text("Date is \(birthDate, formatter: dateFormatter)")
        }
    }
}

struct TypePickerView : View {
    var body: some View {
        VStack {
            DatePickerView()
            PickerView()
        }
    }
}
