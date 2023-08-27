//
//  CategoryTree.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 18.08.2023.
//

import Foundation


struct CategoryTree: Codable, Identifiable {
    var id: Int
    var name: String
    var list: [CategoryTree]?
}
