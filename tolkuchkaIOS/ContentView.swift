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
    @EnvironmentObject var tabViewModel: TabViewModel
    let dataViewModel = DataViewModel()
    @State private var isSideSheetOpen = false
    @State var categories: [Category] = []
    let buttonImage: CGFloat = 60
    
    @State private var selectedTab: Tab = .home
    @State private var search: String = ""
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack{
                TabView(selection: $selectedTab) {
                    NavigationView {
                        HomeView()
                    }
                    .padding([.leading, .trailing], 6)
                    .tag(Tab.home)
                    .accentColor(.black)
                    NavigationView {
                        CategoriesView()
                    }
                    .padding([.leading, .trailing], 6)
                    .tag(Tab.categories)
                    .accentColor(.black)
                    NavigationView {
                        BrandsView()
                    }
                    .padding([.leading, .trailing], 6)
                    .tag(Tab.brands)
                    .accentColor(.black)
                    NavigationView {
                        Text("comparison")
                    }
                    .padding([.leading, .trailing], 6)
                    .tag(Tab.comparison)
                    .accentColor(.black)
                    NavigationView {
                        Text("cart")
                    }
                    .padding([.leading, .trailing], 6)
                    .tag(Tab.cart)
                    .accentColor(.black)
                    NavigationView {
                        AccountView()
                    }
                    .padding([.leading, .trailing], 6)
                    .tag(Tab.login)
                    .accentColor(.black)
                    NavigationView {
                        Text("menu")
                    }
                    .padding([.leading, .trailing], 6)
                    .tag(Tab.menu)
                    .accentColor(.black)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .navigationViewStyle(StackNavigationViewStyle())
            .textFieldStyle(RoundedBorderTextFieldStyle())
            CustomTabBar(selectedTab: $selectedTab)
        }
        .environmentObject(dataViewModel)
    }
}

struct CustomTabBar: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
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
    
    var body: some View {
        Button(action: {
            selectedTab = tabIndex
        }) {
            VStack {
                FAText(iconName: iconName, size: 30, style: FAStyle.solid)
                    .frame(width: buttonImage, height: buttonImage)
                    .foregroundColor(Color(red: 241.0 / 255.0, green: 140.0 / 255.0, blue: 41.0 / 255.0))
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


