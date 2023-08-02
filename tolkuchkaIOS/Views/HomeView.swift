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
//                    .frame(minWidth: sizeClass == .compact ? 50 : 120)
                    .accentColor(.black)
                }
                HStack {
                    ForEach(item.products, id: \.count) {
                        ps in
                        Text(String(ps[0].name))
                        Text(String(ps[0].price))
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
