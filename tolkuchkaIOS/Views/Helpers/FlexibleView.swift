//
//  FlexibleView.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 07.08.2023.
//

import SwiftUI

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let availableWidth: CGFloat
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let hStackAlignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    @State private var elementsSize: [Data.Element: CGSize] = [:]
    let onLastItemAppear: (() -> Void)?

    init(availableWidth: CGFloat, data: Data, spacing: CGFloat = 0, alignment: HorizontalAlignment, hStackAlignment: HorizontalAlignment = .leading, content: @escaping (Data.Element) -> Content, onLastItemAppear: (() -> Void)? = nil) {
        self.availableWidth = availableWidth
        self.data = data
        self.spacing = spacing
        self.alignment = alignment
        self.hStackAlignment = hStackAlignment
        self.content = content
        self.onLastItemAppear = onLastItemAppear
    }

    

    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { rowElements in
                HStack(spacing: spacing) {
                    switch hStackAlignment {
                    case .trailing:
                        Spacer(minLength: 0)
                    case .center:
                        let totalWidth = rowElements.reduce(CGFloat(0)) { acc, element in
                            acc + (elementsSize[element, default: CGSize(width: 0, height: 1)].width + spacing)
                        }
                        Spacer(minLength: (availableWidth - totalWidth) / 2)
                    default:
                        EmptyView()
                    }
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                            .fixedSize()
                            .readSize { size in
                                elementsSize[element] = size
                            }
//                            .onAppear {
//                                print("ok")
//                            }
                        //                            .background(
                        //                                GeometryReader { _ in
                        //                                    // If the callback exists and the current element is the last element, execute onAppear.
                        //                                    if let callback = onLastItemAppear {
                        //                                        Color.clear.onAppear(perform: callback)
                        //                                    } else {
                        //                                        Color.clear
                        //                                    }
                        //                                }
                        //                            )
                        //                        if onLastItemAppear != nil {
                        //                            if data[data.index(before: data.endIndex)] == element {
                        //                                content(element)
                        //                                    .fixedSize()
                        //                                    .readSize { size in
                        //                                        elementsSize[element] = size
                        //                                    }
                        //                                    .background(GeometryReader { _ in Color.clear.onAppear(perform: onLastItemAppear) })
                        //                            } else {
                        //                                content(element)
                        //                                    .fixedSize()
                        //                                    .readSize { size in
                        //                                        elementsSize[element] = size
                        //                                    }
                        //                            }
                        //                        }
                        //                        else {
                        //                            content(element)
                        //                                .fixedSize()
                        //                                .readSize { size in
                        //                                    elementsSize[element] = size
                        //                                }
                        //                        }
                    }
                    switch hStackAlignment {
                    case .leading:
                        Spacer(minLength: 0)
                    case .center:
                        let totalWidth = rowElements.reduce(CGFloat(0)) { acc, element in
                            acc + (elementsSize[element, default: CGSize(width: 0, height: 1)].width + spacing)
                        }
                        Spacer(minLength: (availableWidth - totalWidth) / 2)
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }

    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth

        for element in data {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]

            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = availableWidth
            }

            remainingWidth = remainingWidth - (elementSize.width + spacing)
        }

        return rows
    }
}

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
