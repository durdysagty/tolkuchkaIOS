//
//  Category.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 19.05.2023.
//

import SwiftUI

struct BrandView: View {
    var brand: Brand
    
    var body: some View {
        VStack {
            Text(brand.name)
        }
    }
}

struct BrandView_Previews: PreviewProvider {
    static var previews: some View {
        BrandView(brand: Brand(id: 1, version: 1, name: "Brand Name"))
    }
}
