//
//  NewPostView.swift
//  Slide
//
//  Created by hhhello0507 on 4/2/25.
//

import SwiftUI

struct NewPostView: View {
    @State private var text: String = ""
    @State private var selection = 0
    @FocusState private var focused: Int?
    
    var body: some View {
        MyNavigationBar.small(
            title: "새 슬라이드",
            buttons: focused != nil ? [
                .init(.text("닫기")) {
                    focused = nil
                }
            ] : []
        ) { _ in
            VStack(spacing: 0) {
                TabView(selection: $selection) {
                    PageEditor(text: $text)
                        .focused($focused, equals: 0)
                        .tag(0)
                    Button {
                        print("CLICK")
                    } label: {
                        HStack(spacing: 12) {
                            Image.icon(.AddLine)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 24, height: 24)
                            Text("새 페이지 만들기")
                                .myFont(.headlineM)
                                .foregroundStyle(.label(.neutral))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: 300)
                        .background(.background(.normal), in: .rect(cornerRadius: 28))
                        .padding(.horizontal, 32)
                        .padding(.vertical, 48)
                    }
                    .scaledButtonStyle()
                    .tag(1)
                }
                .tabViewStyle(.page)
                HStack {
                    Spacer()
                    MyButton("게시", size: .medium, isRounded: true) {
                        
                    }
                    .padding(.trailing, 12)
                }
                .padding(.vertical, 4)
            }
        }
        .hideKeyboardWhenTap()
        .onChange(of: selection) {
            self.hideKeyboard()
        }
        .onAppear {
            focused = 0
        }
    }
}

struct PageEditor: View {
    @Binding var text: String
    
    var body: some View {
        TextEditor(text: $text)
            .contentMargins(8)
            .myFont(.headlineM)
            .foregroundStyle(.label(.normal))
            .overlay(alignment: .topLeading) {
                if text.isEmpty {
                    Text("여기에 생각을 남겨주세요")
                        .padding(16)
                        .myFont(.headlineM)
                        .foregroundStyle(.label(.assistive))
                }
            }
            .scrollContentBackground(.hidden)
    }
}

#Preview {
    NewPostView()
}
