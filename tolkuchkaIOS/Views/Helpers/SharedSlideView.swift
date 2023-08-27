//
//  SharedSlideView.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 09.07.2023.
//

import SwiftUI

struct SharedSlideView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var slide: Slide
    
    var body: some View {
        Link (destination: URL(string: slide.link)!) {
            AsyncImage(url: getImage(imageFolder: "slide", id: slide.id, imageIndex: getLocalNumber(), version: slide.version)){ image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
        }
    }
}

struct SharedSlideView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 14 Pro", "iPad Pro (12.9-inch) (2nd generation)"], id: \.self) { deviceName in
            SharedSlideView(slide: Slide(id: 3, version: 1, link: "https://tolkuchka.bar"))
                .previewDevice(PreviewDevice(rawValue: deviceName))
        }
    }
}
