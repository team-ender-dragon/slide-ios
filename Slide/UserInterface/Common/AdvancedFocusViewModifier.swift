import SwiftUI

struct AdvancedFocusViewModifier: ViewModifier {
    @FocusState private var focused: Bool
    
    func body(content: Content) -> some View {
        content
            .focused($focused)
            .onTapGesture {
                focused = true
            }
    }
}

extension View {
    func advancedFocus() -> some View {
        self.modifier(AdvancedFocusViewModifier())
    }
}
