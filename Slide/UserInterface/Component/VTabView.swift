import SwiftUI

struct VTabView<Content, SelectionValue>: View where Content: View, SelectionValue: Hashable {
    private let selection: Binding<SelectionValue>?
    private let indexPosition: IndexPosition
    private let content: () -> Content
    
    /// Creates an instance that selects from content associated with
    /// `Selection` values.
    init(
        selection: Binding<SelectionValue>?,
        indexPosition: IndexPosition = .leading,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = selection
        self.indexPosition = indexPosition
        self.content = content
    }
    
    private var flippingAngle: Angle {
        switch indexPosition {
        case .leading:
            .degrees(0)
        case .trailing:
            .degrees(180)
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            TabView(selection: selection) {
                Group {
                    content()
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                .rotationEffect(.degrees(-90))
                .rotation3DEffect(flippingAngle, axis: (x: 1, y: 0, z: 0))
            }
            .frame(width: proxy.size.height, height: proxy.size.width)
            .rotation3DEffect(flippingAngle, axis: (x: 1, y: 0, z: 0))
            .rotationEffect(.degrees(90), anchor: .topLeading)
            .offset(x: proxy.size.width)
        }
    }
    
    public enum IndexPosition {
        case leading
        case trailing
    }
}
