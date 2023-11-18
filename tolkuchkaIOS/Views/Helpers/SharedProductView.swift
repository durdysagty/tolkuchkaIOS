import SwiftUI
import FASwiftUI

struct SharedProductView: View {
    var products: [UIProduct]
    @State private var displayedIndex = 0
    let buttonImage: CGFloat = 25
    let buttonFontSize: CGFloat = 14

    var body: some View {
        VStack {
            HStack {
                ZStack(alignment: .topLeading) {
                    AsyncImage(
                        url: URL(string: "\(host)\(products[displayedIndex].imageMain)webp?v=\(products[displayedIndex].version)")
                    ) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 155)
                    } placeholder: {
                        ProgressView()
                    }
                    .overlay(
                        HStack {
                            let badges: [BadgeData] = getBadges()
                            GeometryReader { geometryProxy in
                                FlexibleView(
                                    availableWidth: geometryProxy.size.width,
                                    data: badges,
                                    spacing: 2,
                                    alignment: .leading
                                ) { badge in
                                    BadgeView(text: badge.text, backgroundColor: badge.backgroundColor, textColor: badge.textColor)
                                }
                            }
                        }
                    )
                }
                .scaledToFit()
                ScrollView (.vertical, showsIndicators: false) {
                    VStack (spacing: 1) {
                        Button(action: {
                            // Add your heart button action here
                        }) {
                            FAText(iconName: "cart-plus", size: buttonFontSize, style: FAStyle.solid)
                                .frame(width: buttonImage, height: buttonImage)
                                .foregroundColor(.white)
                                .background(Color(red: 241.0 / 255.0, green: 140.0 / 255.0, blue: 41.0 / 255.0))
                                .cornerRadius(3)
                        }
                        Button(action: {
                            // Add your heart button action here
                        }) {
                            FAText(iconName: "heart", size: buttonFontSize, style: FAStyle.solid)
                                .frame(width: buttonImage, height: buttonImage)
                                .foregroundColor(.white)
                                .background(Color(red: 241.0 / 255.0, green: 140.0 / 255.0, blue: 41.0 / 255.0))
                                .cornerRadius(3)
                        }
                        Button(action: {
                            // Add your heart button action here
                        }) {
                            FAText(iconName: "scale-balanced", size: buttonFontSize, style: FAStyle.solid)
                                .frame(width: buttonImage, height: buttonImage)
                                .foregroundColor(.white)
                                .background(Color(red: 241.0 / 255.0, green: 140.0 / 255.0, blue: 41.0 / 255.0))
                                .cornerRadius(3)
                        }
                        if !products.dropFirst().isEmpty {
                            ForEach(products.indices, id: \.self) { index in
                                Button(action: {
                                    displayedIndex = index
                                }) {
                                    AsyncImage(
                                        url: URL(string: "\(host)\(products[index].imageMain)webp?v=\(products[index].version)")
                                    ) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: buttonImage, height: buttonImage)
                                    .foregroundColor(.white)
                                    .background(Color(red: 241.0 / 255.0, green: 140.0 / 255.0, blue: 41.0 / 255.0))
                                    .cornerRadius(3)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 2)
                                            .stroke(index == displayedIndex ? Color.blue : Color.clear, lineWidth: 0.5)
                                    )
                                }
                            }
                        }
                    }
                }
                .frame(height: 160)
            }
            .fixedSize(horizontal: false, vertical: true)
            HStack {
                Text(products[displayedIndex].name)
                    .lineLimit(2)
                    .font(.system(size: 9))
                    .padding(.bottom, 0.2)
            }
            .frame(maxWidth: 190)
            //            .fixedSize(horizontal: true, vertical: false)
            HStack{
                Spacer()
                if (products[displayedIndex].newPrice == nil)
                {
                    Text("TMT \(String(format: "%.2f", products[displayedIndex].price))")
                        .font(.system(size: 10))
                }
                else {
                    Text("\(String(format: "%.2f", products[displayedIndex].price))")
                        .font(.system(size: 8))
                        .strikethrough(true, color: .red)
                    Text("TMT \(String(format: "%.2f", products[displayedIndex].newPrice!))")
                        .font(.system(size: 10))
                }
            }
        }
        .fixedSize(horizontal: true, vertical: true)
                .frame(width: 187, height: 200)
                .padding(.trailing, 5)
                .padding(.bottom, 8)
    }

    struct BadgeData: Identifiable, Hashable, Equatable {
        let id = UUID()
        let text: String
        let backgroundColor: Color
        let textColor: Color
        let model: PAppProductsModel?

        static func == (lhs: BadgeData, rhs: BadgeData) -> Bool {
            return lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }

    func getBadges() -> [BadgeData] {
        var badges: [BadgeData] = []
        let recommendedText = products[displayedIndex].recommended
        if let recommended = recommendedText {
            badges.append(BadgeData(text: recommended, backgroundColor: Color(red: 249/255, green: 225/255, blue: 229/255), textColor: .black, model: AppProductsModel(model: "recommended", id: 0, modelName: "recommended")))
        }

        let newText = products[displayedIndex].new
        if let newBadge = newText {
            badges.append(BadgeData(text: newBadge, backgroundColor: Color(red: 255/255, green: 255/255, blue: 141/255), textColor: Color(red: 110/255, green: 2/255, blue: 177/255), model: AppProductsModel(model: "novelties", id: 0, modelName: "novelties")))
        }

        for promotion in products[displayedIndex].promotions {
            badges.append(BadgeData(text: promotion.name, backgroundColor: Color(red: 222 / 255.0, green: 241 / 255.0, blue: 247 / 255.0), textColor: Color(red: 28 / 255.0, green: 101 / 255.0, blue: 125 / 255.0), model: promotion))
        }

        return badges
    }
}




struct BadgeView: View {
    var text: String
    var backgroundColor: Color
    var textColor: Color

    var body: some View {
        Text(text)
            .font(.system(size: 12))
            .foregroundColor(textColor)
            .padding(0.5)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 2))
    }
}


struct SharedProductView_Previews: PreviewProvider {
    static var previews: some View {
        SharedProductView(products: [
            UIProduct(id: 5140, version: 0, name: "Мобильный телефон Xiaomi Mi Mix Fold 2 12ГБ 256ГБ Черный", price: 25799, newPrice: nil, imageMain: "/images/product/5140-0.", recommended: "рекомендуем", new: "новинка", promotions: [
                Promotion(
                    id: 1,
                    version: 1,
                    type: .discount,
                    volume: 10.0,
                    quantity: 5,
                    subjectId: 1,
                    name: "Promotion 1",
                    desc: "Description for Promotion 1"
                ),
                Promotion(
                    id: 2,
                    version: 1,
                    type: .discount,
                    volume: 20.0,
                    quantity: 10,
                    subjectId: 2,
                    name: "Promotion 2",
                    desc: "Description for Promotion 2"
                ),
                Promotion(
                    id: 3,
                    version: 1,
                    type: .discount,
                    volume: 30.0,
                    quantity: 15,
                    subjectId: 3,
                    name: "Promotion 3",
                    desc: "Description for Promotion 3"
                ),
                Promotion(
                    id: 4,
                    version: 1,
                    type: .discount,
                    volume: 40.0,
                    quantity: 20,
                    subjectId: 4,
                    name: "Promotion 4",
                    desc: "Description for Promotion 4"
                ),
                Promotion(
                    id: 5,
                    version: 1,
                    type: .discount,
                    volume: 50.0,
                    quantity: 25,
                    subjectId: 5,
                    name: "Promotion 5",
                    desc: "Description for Promotion 5"
                )
            ]),
            UIProduct(id: 5141, version: 0, name: "Мобильный телефон Xiaomi Mi Mix Fold 2 12ГБ 256ГБ Золотой", price: 25799, newPrice: 24299, imageMain: "/images/product/5141-0.", recommended: "рекомендуем", new: nil, promotions: []),
            UIProduct(id: 5142, version: 0, name: "Мобильный телефон Xiaomi Mi Mix Fold 2 12ГБ 256ГБ Серый", price: 25799, newPrice: nil, imageMain: "/images/product/5142-0.", recommended: "рекомендуем", new: "новинка", promotions: []),
            UIProduct(id: 5142, version: 0, name: "Мобильный телефон Xiaomi Mi Mix Fold 2 12ГБ 256ГБ Серый", price: 25799, newPrice: nil, imageMain: "/images/product/5142-0.", recommended: "рекомендуем", new: "новинка", promotions: []),
            UIProduct(id: 5142, version: 0, name: "Мобильный телефон Xiaomi Mi Mix Fold 2 12ГБ 256ГБ Серый", price: 25799, newPrice: nil, imageMain: "/images/product/5142-0.", recommended: "рекомендуем", new: "новинка", promotions: []),
            UIProduct(id: 5142, version: 0, name: "Мобильный телефон Xiaomi Mi Mix Fold 2 12ГБ 256ГБ Серый", price: 25799, newPrice: nil, imageMain: "/images/product/5142-0.", recommended: "рекомендуем", new: "новинка", promotions: []),
            UIProduct(id: 5142, version: 0, name: "Мобильный телефон Xiaomi Mi Mix Fold 2 12ГБ 256ГБ Серый", price: 25799, newPrice: nil, imageMain: "/images/product/5142-0.", recommended: "рекомендуем", new: "новинка", promotions: []),
            UIProduct(id: 5142, version: 0, name: "Мобильный телефон Xiaomi Mi Mix Fold 2 12ГБ 256ГБ Серый", price: 25799, newPrice: nil, imageMain: "/images/product/5142-0.", recommended: "рекомендуем", new: "новинка", promotions: []),
            UIProduct(id: 5142, version: 0, name: "Мобильный телефон Xiaomi Mi Mix Fold 2 12ГБ 256ГБ Серый", price: 25799, newPrice: nil, imageMain: "/images/product/5142-0.", recommended: "рекомендуем", new: "новинка", promotions: [])
        ])
    }
}
