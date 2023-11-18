//
//  HeaderView.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 01.09.2023.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var dataViewModel: DataViewModel
//    @Binding var search: String
//    @Binding var categories: [Category]

    var body: some View {
        VStack {
            HStack{
                if (sizeClass == .regular) {
                    AsyncImage(url: URL(string: "\(host)logo.webp?v=0")){ image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.bottom)
                }
                TextField(
                    "search",
                    text: $dataViewModel.search
                )
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(0)
            }
            .frame(alignment: .bottom)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(dataViewModel.categories, id: \.id) {
                        category in
                        NavigationLink {
                            ProductsView(model: category)
                        } label: {
                            SharedCategoryView(category: category)
                        }
                    }
                }
            }
            .onAppear {
                if dataViewModel.categories.isEmpty {
                    dataViewModel.fetchData()
                }
            }
        }
    }
}


class DataViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var search: String = ""

    func fetchData() {
        let _: [Category]? = getData("main", completion: { categories in
            self.categories = categories
        })
    }
}

//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(["iPhone 14 Pro", "iPad Pro (12.9-inch) (2nd generation)"], id: \.self) { deviceName in
//            HeaderView()
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//        }
//    }
//}
