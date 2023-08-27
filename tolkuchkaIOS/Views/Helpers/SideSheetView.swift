//
//  SideSheetView.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 13.08.2023.
//

import SwiftUI
// not used yet
struct SideSheetView<Content: View>: View {
    @Binding var isOpen: Bool
    let maxWidth: CGFloat
    let minWidth: CGFloat
    let content: Content

    @GestureState private var translation: CGFloat = 0

    init(isOpen: Binding<Bool>, maxWidth: CGFloat, minWidth: CGFloat, @ViewBuilder content: () -> Content) {
        self._isOpen = isOpen
        self.maxWidth = maxWidth
        self.minWidth = minWidth
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            HStack {
                self.content
                    .frame(width: self.isOpen ? self.maxWidth : self.minWidth, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                Spacer()
            }
            .offset(x: min(self.isOpen ? 0 : self.minWidth - self.maxWidth + self.translation, 0))
            .animation(.interactiveSpring(), value: isOpen)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let snapDistance = self.maxWidth * 0.25
                    guard abs(value.translation.width) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.width > 0
                }
            )
        }
    }
}
