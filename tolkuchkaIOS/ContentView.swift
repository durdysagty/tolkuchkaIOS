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
    //    let p = Task {
    //        await getData("items")
    //
    //    }
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    if (sizeClass == .compact){
                        NavigationLink {
                            Account()
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
//                                .frame(maxWidth:)
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
                Spacer()
                VStack{
                    //            HStack {
                    //                Button("info@tolkuchka.bar", action:{
                    //                    let mail = "mailto:info@tolkuchka.bar"
                    //                    let url = URL(string: mail)!
                    //                    UIApplication.shared.open(url)
                    //                })
                    //                .accentColor(.black)
                    //                sizeClass == .compact ? Spacer() : nil
                    //                Button("+99365-561427", action:{
                    //                    let phone = "tel://+99365561427"
                    //                    let url = URL(string: phone)!
                    //                    UIApplication.shared.open(url)
                    //                })
                    //                .foregroundColor(.black)
                    //                sizeClass == .regular ? Spacer() : nil
                    //            }
                    //            if (sizeClass == .compact) {
                    //                VStack {
                    //                    AsyncImage(url: URL(string: "\(host)logo.webp?v=0")){ image in
                    //                        image
                    //                            .resizable()
                    //                            .scaledToFit()
                    //                    } placeholder: {
                    //                        ProgressView()
                    //                    }
                    //                }
                    //                Spacer()
                    //            }
                    //            else {
                    //                HStack {
                    //                    AsyncImage(url: URL(string: "\(host)logo.webp?v=0")){ image in
                    //                        image
                    //                            .resizable()
                    //                            .scaledToFit()
                    //                    } placeholder: {
                    //                        ProgressView()
                    //                    }
                    //                    .frame(maxWidth: 300)
                    //                    Spacer()
                    //                }
                    //                Spacer()
                    //            }
                    TabView(selection: $selection) {
                        Home()
                            .tabItem {
                                Label("home", systemImage: "house.fill")
                            }
                            .tag(Tab.home)
                        Text("cats")
                            .tabItem {
                                Label("cats", systemImage: "list.dash.header.rectangle")
                            }
                            .tag(Tab.categories)
                        if (sizeClass == .regular){
                            Text("brands")
                                .tabItem {
                                    Label("brands", systemImage: "star.circle.fill")
                                }
                                .tag(Tab.brands)
                        }
                        Text("comparison")
                            .tabItem {
                                Label("comparison", systemImage: "uiwindow.split.2x1")
                            }
                            .tag(Tab.brands)
                        Text("cart")
                            .tabItem {
                                Label("cart", systemImage: "cart")
                            }
                            .tag(Tab.brands)
                        if (sizeClass == .regular){
                            Account()
                                .tabItem {
                                    Label("login", systemImage: "person.fill")
                                }
                                .tag(Tab.brands)
                        }
                        Text("menu")
                            .tabItem {
                                Label("menu", systemImage: "list.bullet")
                            }
                            .tag(Tab.brands)
                    }
                }
            }
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14 Pro", "iPad Pro (12.9-inch)"], id: \.self) { deviceName in
            ContentView()
                .environment(\.locale, .init(identifier: "ru"))
                .previewDevice(PreviewDevice(rawValue: deviceName))
        }
    }
}
