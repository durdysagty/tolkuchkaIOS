//
//  Products.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 20.07.2023.
//

import Foundation

protocol PAppProductsModel: Codable {
    var model: String? {get set}
    var id: Int {get set}
    var modelName: String? {get set}
    var uniqId: Int {get set}
}

struct AppProductsModel: PAppProductsModel {
    var model: String?
    var id: Int
    var modelName: String?
    var uniqId: Int

    enum CodingKeys: String, CodingKey {
        case model, id, modelName
    }

    init(model: String?, id: Int, modelName: String?) {
        self.model = model
        self.id = id
        self.modelName = modelName
        self.uniqId = getId()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        model = try container.decode(String.self, forKey: .model)
        id = try container.decode(Int.self, forKey: .id)
        modelName = try container.decode(String.self, forKey: .modelName)
        uniqId = getId()
    }
}
