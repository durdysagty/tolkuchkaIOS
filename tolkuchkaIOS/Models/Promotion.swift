//
//  Promotion.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 13.07.2023.
//

import Foundation

enum Tp: Int, Codable { case discount, quantityDiscount, quantityFree, qroductFree, set, setDiscount, specialSetDiscount, special }

struct Promotion: PAppProductsModel, MRP {
    var id: Int
    var version: Int
    var type: Tp
    var volume: Float?
    var quantity: Int?
    var subjectId: Int?
    var name: String
    var desc: String?
    var model: String?
    var modelName: String?
    var uniqId: Int

    enum CodingKeys: String, CodingKey {
        case id, version, type, volume, quantity, subjectId, name, desc
    }

    init(id: Int, version: Int, type: Tp, volume: Float?, quantity: Int?, subjectId: Int?, name: String, desc: String?) {
        self.id = id
        self.version = version
        self.type = type
        self.volume = volume
        self.quantity = quantity
        self.subjectId = subjectId
        self.name = name
        self.desc = desc
        self.model = "promotion"
        self.modelName = name
        self.uniqId = getId()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        version = try container.decode(Int.self, forKey: .version)
        type = try container.decode(Tp.self, forKey: .type)
        volume = try container.decode(Float.self, forKey: .volume)
        quantity = try container.decode(Int?.self, forKey: .quantity)
        subjectId = try container.decode(Int?.self, forKey: .subjectId)
        name = try container.decode(String.self, forKey: .name)
        desc = try container.decode(String?.self, forKey: .desc)
        model = "promotion"
        modelName = try container.decode(String.self, forKey: .name)
        self.uniqId = getId()
    }
}
