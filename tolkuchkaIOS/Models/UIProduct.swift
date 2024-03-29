//
//  UIProduct.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 11.07.2023.
//

import Foundation

struct UIProduct: MRP, Hashable {
    var id: Int
    var version: Int
    var name: String
    var price: Float
    var newPrice: Float?
    var imageMain: String
    var recommended: String?
    var new: String?
    var promotions: [Promotion]

    
    static func == (lhs: UIProduct, rhs: UIProduct) -> Bool {
        return lhs.id == rhs.id
    }
}
