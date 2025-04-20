import SwiftUI

struct FirstResponderModifier: ViewModifier {
    @FocusState private var focused: Bool

    func body(content: Content) -> some View {
        content
            .focused($focused)
            .onAppear {
                focused = true
            }
    }
}

extension View {
    func firstResponder() -> some View {
        self.modifier(FirstResponderModifier())
    }
}
