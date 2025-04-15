import SwiftUI

struct PageWrapper {
    enum PageType {
        case icon(selected: Image, unselected: Image)
        case add
    }
    
    let content: AnyView
    let type: PageType
    
    @resultBuilder
    struct Builder {
        public static func buildBlock(
            _ components: PageWrapper...
        ) -> [PageWrapper] {
            return components
        }
    }
    
    init<C: View>(
        type: PageType,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.type = type
        self.content = AnyView(content())
    }
}

extension View {
    func page(_ type: PageWrapper.PageType) -> PageWrapper {
        PageWrapper(type: type) { self }
    }
}
