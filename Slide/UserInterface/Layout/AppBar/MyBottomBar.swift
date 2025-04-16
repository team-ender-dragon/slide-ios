import SwiftUI

struct MyBottomBar: View {
    @Binding private var selection: Int
    private let pages: [PageWrapper]
    private let addAction: () -> Void
    
    init(
        selection: Binding<Int>,
        @PageWrapper.Builder pages: () -> [PageWrapper],
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
            bottomBar
        }
    }
    
    @ViewBuilder
    private var bottomBar: some View {
        HStack(spacing: 0) {
            ForEach(pages.indices, id: \.self) { index in
                let page = pages[index]
                let selected = selection == index
                Button {
                    switch page.type {
                    case .icon:
                        if !selected {
                            selection = index
                        }
                    case .add:
                        addAction()
                    }
                } label: {
                    MyBottomBarItem(page: page, isSelected: selected)
                        .background(.background(.normal))
                }
                .scaledButton()
            }
        }
        .padding(.top, 4)
        .padding(.horizontal, 8)
        .padding(.horizontal, -1)
        .padding(.bottom, -1)
        .background(.background(.normal))
#if canImport(UIKit)
        .onChange(of: selection) { _, _ in
            let impactMed = UIImpactFeedbackGenerator(style: .rigid)
            impactMed.impactOccurred()
        }
#endif
    }
}

struct MyBottomBarItem: View {
    private let page: PageWrapper
    private let isSelected: Bool
    
    init(
        page: PageWrapper,
        isSelected: Bool
    ) {
        self.page = page
        self.isSelected = isSelected
    }
    
    var body: some View {
        HStack {
            Spacer()
            Group {
                switch page.type {
                case let .icon(selectedIcon, unselectedIcon):
                    (isSelected ? selectedIcon : unselectedIcon)
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
                        .background(.background(.alternative), in: .rect(cornerRadius: 10))
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
                    .page(.icon(selected: .icon(.Blank), unselected: .icon(.Blank)))
                Color.blue
                    .page(.icon(selected: .icon(.Blank), unselected: .icon(.Blank)))
                Color.orange
                    .page(.icon(selected: .icon(.Blank), unselected: .icon(.Blank)))
                EmptyView()
                    .page(.icon(selected: .icon(.Blank), unselected: .icon(.Blank)))
                EmptyView()
                    .page(.icon(selected: .icon(.Blank), unselected: .icon(.Blank)))
            } addAction: {
                
            }
        }
    }
    
    return BottomAppBarPreview()
        .registerWanted()
}
