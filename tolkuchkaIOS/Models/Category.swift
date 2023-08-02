//
//  Category.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 16.05.2023.
//

import Foundation

struct Category: PAppProductsModel, MRP {
    var id: Int
    var version: Int
    var nameRu: String
    var nameEn: String
    var nameTm: String
    var model: String?
    var modelName: String?
    var uniqId: Int

    enum CodingKeys: String, CodingKey {
        case id, version, nameRu, nameEn, nameTm
    }

    init(id: Int, version: Int, nameRu: String, nameEn: String, nameTm: String) {
        self.id = id
        self.version = version
        self.nameRu = nameRu
        self.nameEn = nameEn
        self.nameTm = nameTm
        self.model = "category"
        self.modelName = getLocalName(ru: nameRu, en: nameEn, tm: nameTm)
        self.uniqId = getId()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        version = try container.decode(Int.self, forKey: .version)
        nameRu = try container.decode(String.self, forKey: .nameRu)
        nameEn = try container.decode(String.self, forKey: .nameEn)
        nameTm = try container.decode(String.self, forKey: .nameTm)
        model = "category"
        modelName = getLocalName(ru: nameRu, en: nameEn, tm: nameTm)
        self.uniqId = getId()
    }
}
