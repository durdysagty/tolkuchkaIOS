//
//  CategoriesView.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 18.08.2023.
//

import SwiftUI

struct CategoriesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State var categoryTree: [CategoryTree] = []

    var columns: [GridItem] {
        switch (horizontalSizeClass, verticalSizeClass) {
        case (.compact, .regular):
            return Array(repeating: .init(.flexible()), count: 1)
        case (.regular, .compact):
            fallthrough
        case (.compact, .compact):
            return Array(repeating: .init(.flexible()), count: 2)
        default:
            return Array(repeating: .init(.flexible()), count: 3)
        }
    }

    var body: some View {
        ScrollView {
            ForEach(categoryTree, id: \.id) { category in
                let cat: AppProductsModel = AppProductsModel(model: "category", id: category.id, modelName: category.name)
                VStack {
                    NavigationLink {
                        ProductsView(model: AppProductsModel(model: "category", id: category.id, modelName: category.name))
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: "\(host)svgs/\(cat.model!)/\(cat.id).png")){ image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: horizontalSizeClass == .compact ? 20 : 30)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(cat.modelName!)
                                .padding(.bottom, 1)
                                .font(.system(size: 28))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //second level
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(category.list!, id: \.id) { category in
                            let cat: AppProductsModel = AppProductsModel(model: "category", id: category.id, modelName: category.name)
                            VStack {
                                NavigationLink {
                                    ProductsView(model: AppProductsModel(model: "category", id: category.id, modelName: category.name))
                                } label: {
                                    Text(cat.modelName!)
                                        .font(.system(size: 20))
                                        .accentColor(.black)
                                }
                                .padding(.leading, 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                // third level
                                ForEach(category.list!, id: \.id) { category in
                                    let cat: AppProductsModel = AppProductsModel(model: "category", id: category.id, modelName: category.name)
                                    VStack {
                                        NavigationLink {
                                            ProductsView(model: AppProductsModel(model: "category", id: category.id, modelName: category.name))
                                        } label: {
                                            Text(cat.modelName!)
                                                .accentColor(.black)
                                                .lineLimit(1)
                                        }
                                        .padding(.leading, 35)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.bottom, 12)
                        }
                    }
                }
            }
            .padding(.bottom, 55)
            .padding(.top, 15)
        }
        .onAppear {
            let _: [CategoryTree]? = getData("categories", completion: { categories in
                print(categories)
                self.categoryTree = categories
            })
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14 Pro", "iPad Pro (12.9-inch) (2nd generation)"], id: \.self) { deviceName in
            CategoriesView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
        }
    }
}
