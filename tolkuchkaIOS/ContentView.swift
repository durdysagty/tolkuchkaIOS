//
//  ContentView.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 06.05.2023.
//

import SwiftUI
//import GetData

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State var categories: [Category] = []
    
    @State private var selection: Tab = .home
    enum Tab {
        case home
        case categories
        case brands
        case comparison
        case cart
        case login
        case menu
    }
    @State private var search: String = ""
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    if (sizeClass == .compact){
                        NavigationLink {
                            AccountView()
                        } label: {
                            Label("", systemImage: "person.fill")
                                .accentColor(.black)
                        }
                        .navigationTitle("back")
                        .navigationBarHidden(true)
                    }
                    else {
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
                        text: $search
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(0)
                }
                .frame(alignment: .bottom)
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack (){
                        ForEach(self.categories, id: \.id) {
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
                    let _: [Category]? = getData("main", completion: { categories in
                        self.categories = categories
                    })
                }
                TabView(selection: $selection) {
                    HomeView()
                        .padding([.leading, .trailing], 6)
                        .tabItem {
                            Label("home", systemImage: "house.fill")
                        }
                        .tag(Tab.home)
                    Text("cats")
                        .padding([.leading, .trailing], 6)
                        .tabItem {
                            Label("cats", systemImage: "list.dash.header.rectangle")
                        }
                        .tag(Tab.categories)
                    if (sizeClass == .regular){
                        Text("brands")
                            .padding([.leading, .trailing], 6)
                            .tabItem {
                                Label("brands", systemImage: "star.circle.fill")
                            }
                            .tag(Tab.brands)
                    }
                    Text("comparison")
                        .padding([.leading, .trailing], 6)
                        .tabItem {
                            Label("comparison", systemImage: "uiwindow.split.2x1")
                        }
                        .tag(Tab.brands)
                    Text("cart")
                        .padding([.leading, .trailing], 6)
                        .tabItem {
                            Label("cart", systemImage: "cart")
                        }
                        .tag(Tab.brands)
                    if (sizeClass == .regular){
                        AccountView()
                            .padding([.leading, .trailing], 6)
                            .tabItem {
                                Label("login", systemImage: "person.fill")
                            }
                            .tag(Tab.brands)
                    }
                    Text("menu")
                        .padding([.leading, .trailing], 6)
                        .tabItem {
                            Label("menu", systemImage: "list.bullet")
                        }
                        .tag(Tab.brands)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14 Pro", "iPad Pro (12.9-inch)"], id: \.self) { deviceName in
            ContentView()
                .environment(\.locale, .init(identifier: "tk"))
                .previewDevice(PreviewDevice(rawValue: deviceName))
        }
    }
}
