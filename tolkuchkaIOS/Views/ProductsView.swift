//
//  SpecialView.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 19.07.2023.
//

import SwiftUI

struct ProductsView: View {
    var model: PAppProductsModel
    
    
    var body: some View {
        Text(model.modelName ?? "")
    }
}

struct SpecialView_Previews: PreviewProvider {
    static var previews: some View   {
        ProductsView(model: AppProductsModel(model: "category", id: 1, modelName: "Электроника"))
    }
}
