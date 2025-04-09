import SwiftUI

struct MyBottomBar: View {
    @Binding private var selection: Int
    private let pages: [Page]
    private let addAction: () -> Void
    
    init(
        selection: Binding<Int>,
        @Page.Builder pages: () -> [Page],
        addAction: @escaping () -> Void
    ) {
        self._selection = selection
        self.pages = pages()
        self.addAction = addAction
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                ForEach(pages.indices, id: \.self) { index in
                    pages[index].content
                        .opacity(index == selection ? 1 : 0)
                }
            }
            bottomBarBar
        }
    }
    
    @ViewBuilder
    private var bottomBarBar: some View {
        HStack(spacing: 0) {
            ForEach(pages.indices, id: \.self) { idx in
                let page = pages[idx]
                let selected = selection == idx
                Button {
                    switch page.type {
                    case .icon:
                        if !selected {
                            selection = idx
                        }
                    case .add:
                        addAction()
                    }
                    
                } label: {
                    MyBottomBarItem(page: page, isSelected: selected)
                        .background(.background(.alternative))
                }
                .scaledButtonStyle()
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        .padding(.horizontal, -1)
        .padding(.bottom, -1)
        .background(.background(.alternative))
#if canImport(UIKit)
        .onChange(of: selection) { _, _ in
            let impactMed = UIImpactFeedbackGenerator(style: .rigid)
            impactMed.impactOccurred()
        }
#endif
    }
}

struct MyBottomBarItem: View {
    private let page: Page
    private let isSelected: Bool
    
    init(
        page: Page,
        isSelected: Bool
    ) {
        self.page = page
        self.isSelected = isSelected
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 0) {
                switch page.type {
                case .icon(let icon):
                    icon
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(isSelected ? .label(.normal) : .label(.assistive))
                        .frame(width: 34, height: 34)
                case .add:
                    Image.icon(.AddLine)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.label(.alternative))
                        .frame(width: 24, height: 24)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.background(.normal), in: .rect(cornerRadius: 10))
                }
            }
            .padding(.vertical, 4)
            Spacer()
        }
    }
}

#Preview {
    struct BottomAppBarPreview: View {
        @State private var selection = 0
        
        var body: some View {
            MyBottomBar(selection: $selection) {
                Text("WOW")
                    .page(.icon(.icon(.Blank)))
                Color.blue
                    .page(.icon(.icon(.Blank)))
                Color.orange
                    .page(.icon(.icon(.Blank)))
                EmptyView()
                    .page(.icon(.icon(.Blank)))
                EmptyView()
                    .page(.icon(.icon(.Blank)))
            } addAction: {
                
            }
        }
    }
    
    return BottomAppBarPreview()
        .registerWanted()
}
