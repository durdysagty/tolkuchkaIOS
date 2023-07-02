//
//  Home.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 13.05.2023.
//

import SwiftUI
import WebKit

struct HomeView: View {
    @State var index: Index = Index(categories: [], brands: [])
    
    
    var body: some View {
        ScrollView (.vertical){
            VStack(alignment: .leading) {
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack (alignment: .top){
                        ForEach(self.index.categories, id: \.id) {
                            category in
                            NavigationLink {
                                CategoryView(category: category)
                            } label: {
                                VStack {
                                    AsyncImage(url: URL(string: "\(host)svgs/category/\(category.id).png")){ image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxHeight: 25)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Text(getLocalName(ru: category.nameRu, en: category.nameEn, tm: category.nameTm))
                                        .padding(.top, -12)
                                }
                            }
                            .accentColor(.black)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack (alignment: .top){
                            ForEach(self.index.brands, id: \.id) {
                                brand in
                                NavigationLink {
                                    BrandView(brand: brand)
                                } label: {
                                    AsyncImage(url: URL(string: "\(host)images/brand/\(brand.id)-0.webp?v=\(brand.version)")){ image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxHeight: 40)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                .accentColor(.black)
                                .padding()
                                //.border(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 241 / 255, green: 140 / 255, blue: 41 / 255))
                                )
                            }
                        }
                    }
                }
                .padding(.top, 10)
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
        HomeView()
    }
}
