//
//  CustomBackButtonView.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 31.08.2023.
//

import SwiftUI

struct CustomBackButtonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var title: String

    var body: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.backward") // SF Symbol for a left-pointing arrow
                    Text(title)
                }
                .foregroundColor(Color(red: 241.0 / 255.0, green: 140.0 / 255.0, blue: 41.0 / 255.0))
            }
        }
    }
}

