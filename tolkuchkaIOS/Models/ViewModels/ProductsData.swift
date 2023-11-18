//
//  ProductsData.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 27.08.2023.
//

import Foundation

struct ProductsData: Codable {
    var products: [[UIProduct]]
    var lastPage: Int
    var min: Double
    var max: Double
    var brands: BrandsData?
    var types: TypesData?
    var filters: [Filter]?
    var noProduct: String?
}

struct BrandsData: Codable {
    var name: String
    var brands: [Brand]?
}

struct TypesData: Codable {
    var name: String
    var types: [Tipe]?
}

//name Type reserved by swift
struct Tipe: Codable {
    var id: Int
    var name: String
}

struct Filter: Codable {
    var id: Int
    var name: String
    var order: Int
    var isImaged: Bool
    var filterValues: [FilterValue]
}

struct FilterValue: Codable {
    var id: Int
    var name: String
    var image: String?
    var imageVersion: Int
}
