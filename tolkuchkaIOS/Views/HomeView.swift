//
//  Home.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 13.05.2023.
//

import SwiftUI
import WebKit

struct HomeView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State var index: Index = Index(categories: [], brands: [], slides: [], appIndexItems: [])
    
    var body: some View {
        ScrollView (.vertical){
            ScrollView (.horizontal, showsIndicators: false) {
                HStack (alignment: .top){
                    ForEach(self.index.brands, id: \.id) {
                        brand in
                        NavigationLink {
                            BrandView(brand: brand)
                        } label: {
                            SharedBrandView(brand: brand)
                                .frame(maxHeight: sizeClass == .compact ? 50 : 80)
                        }
                    }
                }
            }
            if (sizeClass == .compact) {
                VStack {
                    ForEach(self.index.slides, id: \.id) {
                        slide in
                        SharedSlideView(slide: slide)
                            .cornerRadius(7)
                    }
                }
            }
            else {
                HStack {
                    ForEach(self.index.slides, id: \.id) {
                        slide in
                        SharedSlideView(slide: slide)
                            .cornerRadius(16)
                    }
                }
            }
            ForEach(self.index.appIndexItems, id: \.productsModel.uniqId) {
                item in
                NavigationLink {
                    ProductsView(model: item.productsModel)
                } label: {
                    HStack {
                        AsyncImage(url: URL(string: item.productsModel.model == "novelties" || item.productsModel.model == "recommended" ? "\(host)svgs/\(item.productsModel.model!).png" :  "\(host)svgs/\(item.productsModel.model!)/\(item.productsModel.id).png")){ image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: sizeClass == .compact ? 15 : 25)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(item.productsModel.modelName ?? "")
                        Spacer()
                    }
                    .accentColor(.black)
                }
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack (alignment: .top){
                        ForEach(0..<item.products.count, id: \.self) { index in
                            let ps = item.products[index]
                            HStack {
                                SharedProductView(products: ps)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            let _: Index? = getData("items", completion: { index in
                self.index = index
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14 Pro", "iPad Pro (12.9-inch) (2nd generation)"], id: \.self) { deviceName in
            HomeView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
        }
    }
}
