import SwiftUI

struct Page {
    enum PageType {
        case icon(Image)
        case add
    }
    
    let content: AnyView
    let type: PageType
    
    @resultBuilder
    struct Builder {
        public static func buildBlock(
            _ components: Page...
        ) -> [Page] {
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
    func page(_ type: Page.PageType) -> Page {
        Page(type: type) { self }
    }
}
