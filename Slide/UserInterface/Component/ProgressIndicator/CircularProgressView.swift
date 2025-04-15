import SwiftUI

public struct MyCircularProgressView: View {
    
    @State private var animatedProgress: CGFloat = 0
    
    private let progress: CGFloat
    private let background: Color?
    private let isEnabled: Bool
    
    private var foregroundColor: Color {
        isEnabled ? .primary(.normal) : .label(.alternative)
    }
    
    public init(
        progress: CGFloat,
        background: Color? = nil,
        isEnabled: Bool = true
    ) {
        self.progress = progress
        self.background = background
        self.isEnabled = isEnabled
    }
    
    public func background(_ background: Color) -> Self {
        .init(
            progress: self.progress,
            background: background,
            isEnabled: self.isEnabled
        )
    }
    
    public func disabled(_ condition: Bool = true) -> Self {
        .init(
            progress: self.progress,
            background: self.background,
            isEnabled: !condition
        )
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .foregroundStyle(background ?? .line(.normal))
            Circle()
                .trim(from: 0, to: min(animatedProgress, 1))
                .stroke(
                    style:
                        StrokeStyle(
                            lineWidth: 10,
                            lineCap: .round,
                            lineJoin: .round
                        )
                )
                .foregroundStyle(foregroundColor)
                .rotationEffect(.degrees(270))
                .animation(.linear, value: progress)
                .opacity(isEnabled ? 1 : 0.4)
        }
        .frame(width: 70, height: 70)
        .onChange(of: progress) { newValue in
            animatedProgress = newValue
        }
        .onAppear {
            withAnimation(.spring) {
                animatedProgress = progress
            }
        }
    }
}

private struct MyCircularProgressPreview: View {
    
    @State private var progress: CGFloat = 0.5
    
    var body: some View {
        VStack(spacing: 20) {
            MyCircularProgressView(progress: progress)
            MyCircularProgressView(progress: progress)
                .disabled(true)
        }
        .padding()
        .registerWanted()
    }
}

#Preview {
    MyCircularProgressPreview()
}
#Preview {
    MyCircularProgressPreview()
        .preferredColorScheme(.dark)
}
