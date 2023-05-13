//
//  Home.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 13.05.2023.
//

import SwiftUI

struct Home: View {
    @State var brands: [Brand] = []
    
    var body: some View {
        VStack {
            ForEach(self.brands, id: \.id) { brand in
                Text("\(brand.name)")
            }
        }
        .onAppear {
        let _: Brand? = getData("items", completion: { brands in
                self.brands = brands
                print(self.brands)
            })
        }
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
