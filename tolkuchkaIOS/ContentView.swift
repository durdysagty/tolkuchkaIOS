//
//  ContentView.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 06.05.2023.
//

import SwiftUI
import FASwiftUI

enum Tab {
    case home
    case categories
    case brands
    case comparison
    case cart
    case login
    case menu
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var isSideSheetOpen = false
    @State var categories: [Category] = []
    let buttonImage: CGFloat = 60
    
    @State private var selectedTab: Tab = .home
    @State private var search: String = ""
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationView {
                VStack{
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
                    TabView(selection: $selectedTab) {
                        HomeView()
                            .padding([.leading, .trailing], 6)
                            .tag(Tab.home)
                        CategoriesView()
                            .padding([.leading, .trailing], 6)
                            .tag(Tab.categories)
                        BrandsView()
                            .padding([.leading, .trailing], 6)
                            .tag(Tab.brands)
                        Text("comparison")
                            .padding([.leading, .trailing], 6)
                            .tag(Tab.comparison)
                        Text("cart")
                            .padding([.leading, .trailing], 6)
                            .tag(Tab.cart)
                        AccountView()
                            .padding([.leading, .trailing], 6)
                            .tag(Tab.login)
                        Text("menu")
                            .padding([.leading, .trailing], 6)
                            .tag(Tab.menu)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .navigationViewStyle(StackNavigationViewStyle())
            .textFieldStyle(RoundedBorderTextFieldStyle())
            //            .padding(.bottom, 100)


            //            Button("Open Menu") {
            //                isSideSheetOpen.toggle()
            //            }
            //            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            // Your Draggable Side Sheet

            CustomTabBar(/*isSideMenuOpen: $isSideSheetOpen,*/ selectedTab: $selectedTab)

//            SideSheetView(isOpen: $isSideSheetOpen, maxWidth: 350, minWidth: 50) {
//                // Your Menu Content
//                VStack(alignment: .leading) {
//                    Text("Item 1").padding()
//                    Text("Item 2").padding()
//                    Text("Item 3").padding()
//                    Spacer()
//                }
//            }

        }
        //        .edgesIgnoringSafeArea(.bottom)
    }
}


//struct HandleBar: View {
//    var body: some View {
//        RoundedRectangle(cornerRadius: 2.5)
//            .fill(Color.gray)
//            .frame(width: 40, height: 5)
//            .padding(4)
//    }
//}

struct CustomTabBar: View {
    @Environment(\.horizontalSizeClass) var sizeClass
//    @Binding var isSideMenuOpen: Bool
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
//            TabBarButton(iconName: "bars", tabName: "menu", tabIndex: .menu, selectedTab: $selectedTab/*, isSideMenuOpen: $isSideMenuOpen*/)
//                .frame(maxWidth: .infinity)
            TabBarButton(iconName: "home", tabName: "home", tabIndex: .home, selectedTab: $selectedTab)
                .frame(maxWidth: .infinity)
            TabBarButton(iconName: "align-center", tabName: "cats", tabIndex: .categories, selectedTab: $selectedTab)
                .frame(maxWidth: .infinity)
                TabBarButton(iconName: "copyright", tabName: "brands", tabIndex: .brands, selectedTab: $selectedTab)
                    .frame(maxWidth: .infinity)
            TabBarButton(iconName: "scale-unbalanced", tabName: "comparison", tabIndex: .comparison, selectedTab: $selectedTab)
                .frame(maxWidth: .infinity)
            TabBarButton(iconName: "shopping-cart", tabName: "cart", tabIndex: .cart, selectedTab: $selectedTab)
                .frame(maxWidth: .infinity)
                TabBarButton(iconName: "user-tie", tabName: "login", tabIndex: .login, selectedTab: $selectedTab)
                    .frame(maxWidth: .infinity)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        .shadow(radius: 2)
    }
}

struct TabBarButton: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    let iconName: String
    let tabName: String
    let tabIndex: Tab
    let buttonImage: CGFloat = 45
    @Binding var selectedTab: Tab
//    @Binding var isSideMenuOpen: Bool
//
//    init(iconName: String, tabName: String, tabIndex: Tab, selectedTab: Binding<Tab>, isSideMenuOpen: Binding<Bool> = .constant(false)) {
//        self.iconName = iconName
//        self.tabName = tabName
//        self.tabIndex = tabIndex
//        _selectedTab = selectedTab
//        _isSideMenuOpen = isSideMenuOpen
//    }

    var body: some View {
        Button(action: {
//            if iconName == "bars" {
//                isSideMenuOpen.toggle()
//            } else {
//                selectedTab = tabIndex
//            }
            selectedTab = tabIndex
        }) {
            VStack {
                FAText(iconName: iconName, size: 30, style: FAStyle.solid)
                    .frame(width: buttonImage, height: buttonImage)
                    .foregroundColor(Color(red: 241.0 / 255.0, green: 140.0 / 255.0, blue: 41.0 / 255.0))
                    .cornerRadius(8)
                if sizeClass == .regular {
                    Text(LocalizedStringKey(tabName))
                        .font(.caption)
                        .lineLimit(1)
                }
            }
            .foregroundColor(selectedTab == tabIndex ? .blue : .gray)
        }
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


