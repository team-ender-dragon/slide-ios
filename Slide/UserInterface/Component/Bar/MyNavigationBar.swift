//
//  InfinityTopBar.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/8/24.
//  Copyright © 2024 molohala. All rights reserved.
//

import SwiftUI

struct TopAppBarButton {
    enum ButtonType {
        case icon(Image)
        case text(String)
    }
    
    let type: ButtonType
    let action: () -> Void
    
    init(_ type: ButtonType, action: @escaping () -> Void) {
        self.type = type
        self.action = action
    }
}

public enum TopAppBarType {
    case `default`
    case small
}

@available(iOS 15.0, macOS 12.0, *)
struct MyNavigationBar<C, TC>: View where C: View, TC: View {
    private let edgeInsets = EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15)
    
    @Environment(\.dismiss) private var dismiss
    
    private let title: String
    private let type: TopAppBarType
    private let background: Color
    private let buttons: [TopAppBarButton]
    private let trailingContent: () -> TC
    private let content: (EdgeInsets) -> C
    
    static func `default`(
        title: String,
        background: Color = .background(.alternative),
        buttons: [TopAppBarButton] = [],
        @ViewBuilder trailingContent: @escaping () -> TC = { EmptyView() },
        @ViewBuilder content: @escaping (EdgeInsets) -> C
    ) -> Self {
        self.init(
            title: title,
            type: .default,
            background: background,
            buttons: buttons,
            trailingContent: trailingContent,
            content: content
        )
    }

    static func small(
        title: String,
        background: Color = .background(.alternative),
        buttons: [TopAppBarButton] = [],
        @ViewBuilder trailingContent: @escaping () -> TC = { EmptyView() },
        @ViewBuilder content: @escaping (EdgeInsets) -> C
    ) -> Self {
        self.init(
            title: title,
            type: .small,
            background: background,
            buttons: buttons,
            trailingContent: trailingContent,
            content: content
        )
    }

    public var body: some View {
        if #available(macOS 13.0, *) {
            makeBody().navigationBarBackButtonHidden()
        } else {
            makeBody()
        }
    }
    
    @ViewBuilder
    private func makeBody() -> some View {
        ZStack {
            // Background
            background
                .ignoresSafeArea()
            
            // Screen
            VStack(spacing: 0) {
                // Top app bar
                HStack(spacing: 0) {
                    if type == .small {
                        Button {
                            dismiss()
                        } label: {
                            Image.icon(.ExpandArrow)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.label(.normal))
                                .frame(width: 24, height: 24)
                                .padding(12)
                        }
                    }
                    
                    if type == .default {
                        Spacer().frame(width: 8)
                    }
                    Text(title)
                        .myFont(type == .default ? .title1B : .headlineM)
                        .foregroundStyle(.label(.normal))
                    Spacer()
                    ForEach(buttons.indices, id: \.self) {
                        makeButton(button: buttons[$0])
                    }
                    trailingContent()
                }
                .frame(height: 54)
                .background(background)
                .padding(.horizontal, 4)
                content(edgeInsets)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                Spacer()
            }
        }
    }
    
    func makeButton(button: TopAppBarButton) -> some View {
        Button {
            button.action()
        } label: {
            switch button.type {
            case .icon(let icon):
                icon
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.primary(.normal))
                    .padding(12)
            case .text(let text):
                Text(text)
                    .myFont(.bodyM)
                    .foregroundStyle(.label(.neutral))
                    .padding(12)
            }
            
        }
        .scaledButtonStyle()
    }
}

#Preview {
    MyNavigationBar.default(
        title: "제목",
        buttons: [
            .init(.icon(.icon(.Person))) {
                
            }
        ]
    ) { _ in
        
    }
    .registerWanted()
}

#Preview {
    MyNavigationBar.small(title: "제목") { _ in
        
    }
    .registerWanted()
    .preferredColorScheme(.dark)
}
