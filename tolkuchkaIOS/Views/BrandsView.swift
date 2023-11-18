//
//  BrandsView.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 25.08.2023.
//

import SwiftUI

struct BrandsView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State var brands: [Brand] = []


    var columns: [GridItem] {
        switch (horizontalSizeClass, verticalSizeClass) {
        case (.compact, .regular):
            return Array(repeating: .init(.flexible()), count: 3)
        case (.regular, .compact):
            fallthrough
        case (.compact, .compact):
            return Array(repeating: .init(.flexible()), count: 5)
        default:
            return Array(repeating: .init(.flexible()), count: 6)
        }
    }

    
    var body: some View {
        //        ScrollView (.horizontal, showsIndicators: false)
        //        {
        ScrollView (.vertical, showsIndicators: false) {


            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(brands, id: \.id) { brand in
                    VStack {
                        NavigationLink {
                            ProductsView(model: AppProductsModel(model: "brand", id: brand.id, modelName: brand.name))
                        } label: {
                            NavigationLink {
                                ProductsView(model: brand)
                            } label: {
                                SharedBrandView(brand: brand)
                            }
                        }
                        .padding(.bottom, 10)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .padding(.bottom, 55)
            .onAppear {
                let _: [Brand]? = getData("brands", completion: { brands in
                    #if DEBUG
                    print(brands)
                    #endif
                    self.brands = brands
                })
            }
        }
    }
}

struct BrandsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14 Pro", "iPad Pro (12.9-inch) (2nd generation)"], id: \.self) { deviceName in
            BrandsView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
        }
    }
}
