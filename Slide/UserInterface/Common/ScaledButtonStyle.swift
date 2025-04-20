import SwiftUI

public extension Button {
    func scaledButton<S>(_ shape: S = .rect(cornerRadius: 8)) -> some View where S: Shape {
        self.buttonStyle(ScaledButtonStyle(shape: shape))
    }
    
    struct ScaledButtonStyle<S: Shape>: ButtonStyle {
        let shape: S
        
        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .contentShape(shape)
                .scaleEffect(configuration.isPressed ? 0.96 : 1)
                .background(Color.black.opacity(configuration.isPressed ? 0.05 : 0))
                .clipShape(shape)
                .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
        }
    }
}
