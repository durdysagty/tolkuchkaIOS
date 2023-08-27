
import SwiftUI


struct LeftSideMenuView: View {
    @State private var isMenuOpen = false

    var body: some View {
        ZStack {
            // Main Content
            NavigationView {
                List {
                    ForEach(0..<20) { item in
                        Text("Item \(item)")
                    }
                }
                .navigationBarTitle("Main Content")
////                .navigationBarItems(leading: Button(action: {
//                    withAnimation {
//                        isMenuOpen.toggle()
//                    }
//                }) {
//                    Image(systemName: "line.horizontal.3")
//                })
            }
            .offset(x: isMenuOpen ? 250 : 0)
//            .disabled(isMenuOpen)  // Disable interaction when menu is open
            .overlay(
                // Add a dimmed background view when menu is open
                Rectangle()
                    .fill(Color.black.opacity(isMenuOpen ? 0.5 : 0))
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen.toggle()
                        }
                    }
            )

            // Side Menu
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Button(action: { /* Navigate to view */ }) {
                        Text("Menu Item 1")
                    }
                    Button(action: { /* Navigate to view */ }) {
                        Text("Menu Item 2")
                    }
                    Spacer()
                }
                .padding()
                .frame(width: 250)
//                .background(Color.blue)
                .offset(x: isMenuOpen ? 0 : -250)
                Spacer()
            }
        }
        .gesture(DragGesture().onEnded { value in
            withAnimation {
                // Change this threshold if needed
                if value.translation.width > 100 {
                    isMenuOpen = true
                } else if value.translation.width < -100 {
                    isMenuOpen = false
                }
            }
        })
    }
}


struct TLeftSideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        LeftSideMenuView()
    }
}
