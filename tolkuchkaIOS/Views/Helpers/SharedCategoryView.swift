//
//  SharedCategoryView.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 04.07.2023.
//

import SwiftUI

struct SharedCategoryView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var category: PAppProductsModel
    
    var body: some View {
            VStack {
                AsyncImage(url: URL(string: "\(host)svgs/category/\(String(format: "%d", category.id)).png")){ image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: sizeClass == .compact ? 15 : 25)
                } placeholder: {
                    ProgressView()
                }
                Text(category.modelName ?? "")
            }
            .frame(minWidth: sizeClass == .compact ? 50 : 120)
            .accentColor(.black)
    }
}

struct SharedCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14 Pro", "iPad Pro (12.9-inch) (2nd generation)"], id: \.self) { deviceName in
            SharedCategoryView(category: Category(id: 1, version: 1, nameRu: "r", nameEn: "n", nameTm: "a"))
                .previewDevice(PreviewDevice(rawValue: deviceName))
        }
    }
}
