//
//  SharedBrandView.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 02.07.2023.
//

import SwiftUI

struct SharedBrandView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var brand: Brand
    
    var body: some View {
        AsyncImage(url: getImage(imageFolder: "brand", id: brand.id, imageIndex: 0, version: brand.version)){ image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
//                .frame(maxHeight: sizeClass == .compact ? 25 : 40)
        } placeholder: {
            ProgressView()
        }
    .accentColor(.black)
    .padding(sizeClass == .compact ? 9 : 12)
    .overlay(
        RoundedRectangle(cornerRadius: sizeClass == .compact ? 9 : 16)
            .stroke(Color(red: 241 / 255, green: 140 / 255, blue: 41 / 255))
    )}
}

struct SharedBrandView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14 Pro", "iPad Pro (12.9-inch) (2nd generation)"], id: \.self) { deviceName in
            SharedBrandView(brand: Brand(id: 1, version: 1, name: "Brand Name"))
                .previewDevice(PreviewDevice(rawValue: deviceName))
        }
    }
}
