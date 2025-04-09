//
//  ScaledButtonStyle.swift
//  Slide
//
//  Created by hhhello0507 on 4/2/25.
//

import SwiftUI

public extension Button {
    func scaledButtonStyle() -> some View {
        self.buttonStyle(ScaledButtonStyle())
    }
    
    struct ScaledButtonStyle: ButtonStyle {
        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .contentShape(Rectangle())
                .scaleEffect(configuration.isPressed ? 0.96 : 1)
                .background(Color.black.opacity(configuration.isPressed ? 0.05 : 0))
                .clipShape(.rect(cornerRadius: 8))
                .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
        }
    }
}
