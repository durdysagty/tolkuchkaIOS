//
//  Category.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 19.05.2023.
//

import SwiftUI

struct CategoryView: View {
    var category: Category
    
    
    var body: some View {
        VStack {
            Text(getLocalName(ru: category.nameRu, en: category.nameEn, tm: category.nameTm))
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category(id: 1, version: 1, nameRu: "r", nameEn: "n", nameTm: "a"))
    }
}
