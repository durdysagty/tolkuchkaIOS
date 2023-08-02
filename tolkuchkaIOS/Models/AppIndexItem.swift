//
//  AppIndexItem.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 17.07.2023.
//

import Foundation

//enum AppItemModel: Int, Codable { case Category, Special }

struct AppIndexItem: Codable {
    var productsModel: AppProductsModel
    var products: [[UIProduct]]
}
