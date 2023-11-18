import SwiftUI
import FASwiftUI

struct ProductsView: View {
    @State private var isMenuShown: Bool = false
    var model: PAppProductsModel
    @State var categories: [Category] = []
    @State var products: [[UIProduct]] = []
    @State var productsOnly: Bool = false
    @State var page: Int = 0
    @State var lastPage = 0
    @State var min: Double = -1
    @State var max: Double = 100
    @State var minp: Double = -1
    @State var maxp: Double = 100
    @State var brands: BrandsData? = nil
    @State var types: TypesData? = nil
    @State var filters: [Filter]? = nil
    @State var b: [Int] = []
    @State var t: [Int] = []
    @State var v: [String] = []
    @State var nextFetchIndex: Int = 0
    @State var toFetch: Bool = true
    @State var noProduct: String? = nil
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    func fetch() {
        var q: String = "products/?model=\(model.model!)&id=\(model.id)&productsOnly=\(productsOnly)&page=\(page)"
        if minp > -1 {
            q = q + "&minp=\(Int(minp))&maxp=\(Int(maxp))"
#if DEBUG
            print(q)
#endif
        }
        if !t.isEmpty {
            for i in t {
                q = q + "&t=\(i)"
            }
        }
        if !b.isEmpty {
            for i in b {
                q = q + "&b=\(i)"
            }
        }
        if !v.isEmpty {
            for i in v {
                q = q + "&v=\(i)"
            }
        }
        let _: ProductsData? = getData(q, completion: { data in
            //#if DEBUG
            //            print(data)
            //#endif
            if productsOnly {
                self.products.append(contentsOf: data.products)
                self.lastPage = data.lastPage
                self.filters = data.filters
                self.noProduct = data.noProduct
            } else {
                self.products = data.products
                self.lastPage = data.lastPage
                self.min = data.min
                self.max = data.max
                self.minp = data.min
                self.maxp = data.max
                self.brands = data.brands
                self.types = data.types
                self.filters = data.filters
                self.productsOnly = true
                self.noProduct = data.noProduct
            }
        })
        //#if DEBUG
        //        print("Last page: \(lastPage) Got page: \(page)")
        //#endif
        page += 1
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            nextFetchIndex += 50
        } else {
            nextFetchIndex += 30
        }
        toFetch = false
    }
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var menuWidth: CGFloat {
        switch (horizontalSizeClass, verticalSizeClass) {
        case (.compact, .regular):
            return 250
        default:
            return 480
        }
    }
    
    var columns: [GridItem] {
        switch (horizontalSizeClass, verticalSizeClass) {
        case (.compact, .regular):
            return Array(repeating: .init(.flexible()), count: 2)
        default:
            return Array(repeating: .init(.flexible()), count: 5)
        }
    }

    func isChecked(id: Int, in set: Binding<[Int]>) -> Binding<Bool> {
        Binding<Bool>(
            get: { set.wrappedValue.contains(id) },
            set: { newValue in
                if newValue {
                    set.wrappedValue.append(id)
                } else {
                    set.wrappedValue.removeAll { $0 == id }
                }
            }
        )
    }

    func isChecked(id: String, in set: Binding<[String]>) -> Binding<Bool> {
        Binding<Bool>(
            get: { set.wrappedValue.contains(id) },
            set: { newValue in
                if newValue {
                    set.wrappedValue.append(id)
                } else {
                    set.wrappedValue.removeAll { $0 == id }
                }
            }
        )
    }

    var body: some View {
        GeometryReader { geometry in

            ZStack(alignment: .leading) {
                VStack {
                    if (model.model == "category") {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(categories, id: \.id) {
                                    category in
                                    NavigationLink {
                                        ProductsView(model: category)
                                    } label: {
                                        Text(category.modelName!)
                                            .padding(.horizontal, 9)
                                            .padding(.vertical, 2)
                                            .background(Color.gray.opacity(0.1))
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                    }
                                }
                            }
                        }
                        .onAppear {
                            let _: [Category]? = getData("childcategories/\(model.id)", completion: { data in
                                //#if DEBUG
                                //            print(data)
                                //#endif
                                self.categories = data
                            })
                        }
                    }
                    if noProduct != nil && products.count == 0 {
                        VStack {
                            Spacer() // Spacer to push the text to the center vertically
                            Text(noProduct!)
                                .multilineTextAlignment(.center) // Center the text horizontally
                            Spacer() // Spacer to push the text to the center vertically
                        }
                    }
                    else if products.count == 0 {
                            Spacer()
                            ProgressView()
                                .scaleEffect(2)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .onAppear {
                                    fetch()
                                }
                            Spacer()
                    }
                    else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(0..<products.count, id: \.self) { index in
                                    let ps = products[index]
                                    HStack {
                                        SharedProductView(products: ps)
                                            .onAppear {
                                                if (page <= lastPage) {
                                                    if index == nextFetchIndex - 1 {
                                                        fetch()
                                                    }
                                                }
                                            }
                                    }
                                }
                            }
                            .padding(.bottom, 55)
                        }
                        .onAppear {
                            fetch()
                        }
                    }
                }
                .padding(.top, 40)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButtonView(title: model.modelName!))
                .navigationViewStyle(StackNavigationViewStyle())
                .blur(radius: isMenuShown ? 10 : 0)
                .onTapGesture {
                    if isMenuShown {
                        isMenuShown = false
                        if toFetch {
                            self.products = []
                            self.page = 0
                            self.nextFetchIndex = 0
                            self.noProduct = nil
                            fetch()
                        }
                    }
                }


                // Slide-out menu
                if isMenuShown {
                    VStack (alignment: .leading) {
                        ScrollView (.vertical) {
                            VStack (alignment: .leading) {
                                Text("\(getLocalName(ru:"Цена", en: "Price", tm: "Bahasy")) TMT")
                                RangeSlider(lowerValue: $minp, upperValue: $maxp, minimum: $min, maximum: $max)
                                    .padding()
                                if brands?.brands?.count ?? 0 > 1 {
                                    Text("\(brands!.name)")
                                        .font(.system(size: 20))
                                        .frame(height: 6)
                                    ScrollView (.vertical) {
                                        ForEach(brands!.brands!, id: \.id) { brand in
                                            GeometryReader { geometry in
                                                HStack {
                                                    Text(brand.name)
                                                    Spacer()
                                                    Toggle("", isOn: isChecked(id: brand.id, in: $b))
                                                        .scaleEffect(0.69)
                                                        .frame(width: geometry.size.width * 0.4)
                                                }
                                            }
                                            .frame(height: 18)
                                        }
                                    }
                                    .frame(maxHeight: 200)
                                    .padding(.bottom, 13)
                                }
                                if types?.types?.count ?? 0 > 1 {
                                    Text("\(types!.name)")
                                        .font(.system(size: 20))
                                        .frame(height: 6)
                                    ScrollView (.vertical) {
                                        ForEach(types!.types!, id: \.id) { type in
                                            GeometryReader { geometry in
                                                HStack {
                                                    Text(type.name)
                                                    Spacer()
                                                    Toggle("", isOn: isChecked(id: type.id, in: $t))
                                                        .scaleEffect(0.69)
                                                        .frame(width: geometry.size.width * 0.4)
                                                }
                                            }
                                            .frame(height: 18)
                                        }
                                    }
                                    .frame(maxHeight: 200)
                                    .padding(.bottom, 13)
                                }
                                if filters != nil {
                                    ForEach(filters!, id: \.id) { f in
                                        if f.filterValues.count > 1 {
                                            Text(f.name)
                                                .font(.system(size: 20))
                                                .frame(height: 6)
                                            if f.isImaged {
                                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 20))], spacing: 8) {
                                                    ForEach(f.filterValues, id: \.id) { fv in
                                                        let idString = "\(f.id),\(fv.id)"
                                                        let isImageChecked = isChecked(id: idString, in: $v)
                                                        Button (action: {
                                                            if v.contains(idString) {
                                                                v.removeAll { $0 == idString }
                                                            } else {
                                                                v.append(idString)
                                                            }
                                                        }) {
                                                            AsyncImage(url: getImageByString(path: fv.image!, versionString: fv.imageVersion)) { image in
                                                                image
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .scaledToFit()
                                                                    .padding(-2)
                                                            } placeholder: {
                                                                ProgressView()
                                                            }
                                                        }
                                                        .padding(2)
                                                        .border(isImageChecked.wrappedValue ? orangeT : Color.clear, width: 4)
                                                    }
                                                }
                                            }
                                            else {
                                                VStack {
                                                    ForEach(f.filterValues, id: \.id) { fv in
                                                        GeometryReader { geometry in
                                                            HStack {
                                                                Text(fv.name)
                                                                Spacer()
                                                                Toggle("", isOn: isChecked(id: "\(f.id),\(fv.id)", in: $v))
                                                                    .scaleEffect(0.69)
                                                                    .frame(width: geometry.size.width * 0.4)
                                                            }
                                                        }
                                                        .frame(height: 18)
                                                    }
                                                }
                                                .padding(.bottom, 13)
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                    .background(Color.white)
                    .frame(width: menuWidth, height: geometry.size.height)
                    .transition(.move(edge: .leading))
                }
                // Menu button
                VStack {
                    Spacer()
                    Button(action: {
                        if isMenuShown {
                            if toFetch {
                                self.products = []
                                self.page = 0
                                self.nextFetchIndex = 0
                                self.noProduct = nil
                                fetch()
                            }
                        }
                        withAnimation {
                            self.isMenuShown.toggle()
                        }
                    }) {
                        ZStack {
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                            FAText(iconName: "filter", size: 30, style: FAStyle.solid)
                                .foregroundColor(orangeT)
                        }
                        .shadow(radius: 10)
                    }
                }
                .padding(.leading, isMenuShown ? menuWidth : 10)
                .padding(.bottom, 72)
            }
            .onChange(of: minp) { newValue in
                // Handle the change in minp
                toFetch = true
            }
            .onChange(of: maxp) { newValue in
                // Handle the change in maxp
                toFetch = true
            }
            .onChange(of: b) { newValue in
                // Handle the change in b
                toFetch = true
            }
            .onChange(of: t) { newValue in
                // Handle the change in t
                toFetch = true
            }
            .onChange(of: v) { newValue in
                // Handle the change in b
                toFetch = true
            }
        }
    }
}

struct RangeSlider: View {
    @Binding var lowerValue: Double
    @Binding var upperValue: Double
    @Binding var minimum: Double
    @Binding var maximum: Double

    private func positionForValue(_ value: Double, in geometry: GeometryProxy) -> CGFloat {
        CGFloat((value - minimum) / (maximum - minimum)) * geometry.size.width
    }

    private func valueForPosition(_ position: CGFloat, in geometry: GeometryProxy) -> Double {
        Double(position / geometry.size.width) * (maximum - minimum) + minimum
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 2)

                Rectangle()
                    .fill(Color(red: 241.0 / 255.0, green: 140.0 / 255.0, blue: 41.0 / 255.0))
                    .frame(width: positionForValue(upperValue, in: geometry) - positionForValue(lowerValue, in: geometry), height: 2)
                    .offset(x: positionForValue(lowerValue, in: geometry))

                Text("\(Int(lowerValue))")
                    .padding(4)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(red: 241.0 / 255.0, green: 140.0 / 255.0, blue: 41.0 / 255.0)))
                    .offset(x: positionForValue(lowerValue, in: geometry) - 12, y: -30)
                Circle()
                    .fill(Color(red: 241.0 / 255.0, green: 140.0 / 255.0, blue: 41.0 / 255.0))
                    .frame(width: 24, height: 24)
                    .offset(x: positionForValue(lowerValue, in: geometry) - 12)
                    .gesture(DragGesture()
                        .onChanged({ value in
                            let newValue = valueForPosition(value.location.x, in: geometry)
                            if newValue < upperValue && newValue >= minimum {
                                self.lowerValue = newValue
                            }
                        })
                    )

                Text("\(Int(upperValue))")
                    .padding(4)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(red: 241.0 / 255.0, green: 140.0 / 255.0, blue: 41.0 / 255.0)))
                    .offset(x: positionForValue(upperValue, in: geometry) - 12, y: -30)
                Circle()
                    .fill(Color(red: 241.0 / 255.0, green: 140.0 / 255.0, blue: 41.0 / 255.0))
                    .frame(width: 24, height: 24)
                    .offset(x: positionForValue(upperValue, in: geometry) - 12)
                    .gesture(DragGesture()
                        .onChanged({ value in
                            let newValue = valueForPosition(value.location.x, in: geometry)
                            if newValue > lowerValue && newValue <= maximum {
                                self.upperValue = newValue
                            }
                        })
                    )
            }
        }
        .frame(height: 44)
    }
}


struct SpecialView_Previews: PreviewProvider {
    static var previews: some View   {
        ForEach(["iPhone 14 Pro", "iPad Pro (12.9-inch) (2nd generation)"], id: \.self) { deviceName in
            ProductsView(model: AppProductsModel(model: "brand", id: 1, modelName: "Apple"))
                .previewDevice(PreviewDevice(rawValue: deviceName))
        }
    }
}
