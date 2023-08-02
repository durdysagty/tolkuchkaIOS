//
//  Brand.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 06.05.2023.
//

import Foundation

struct Brand: PAppProductsModel, MRP {
    var id: Int
    var version: Int
    var name: String
    var model: String?
    var modelName: String?
    var uniqId: Int

    enum CodingKeys: String, CodingKey {
        case id, version, name
    }

    init(id: Int, version: Int, name: String) {
        self.id = id
        self.version = version
        self.name = name
        self.model = "brand"
        self.modelName = name
        self.uniqId = getId()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        version = try container.decode(Int.self, forKey: .version)
        name = try container.decode(String.self, forKey: .name)
        model = "brand"
        name = try container.decode(String.self, forKey: .name)
        uniqId = getId()
    }
}
