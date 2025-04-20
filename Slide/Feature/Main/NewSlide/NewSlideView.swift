import SwiftUI

struct NewSlideView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = NewSlideViewModel()
    @State private var selection = 0
    @FocusState private var focused: Int?
    @State private var showCreateSlideConfirmationAlert = false
    @State private var showCreateSlideFailureAlert = false
    
    var body: some View {
        MyNavigationBar.small(
            title: "새 슬라이드",
            buttons: [
                .init(.text("게시")) {
                    showCreateSlideConfirmationAlert = true
                }
            ]
        ) {
            VStack(spacing: 0) {
//                HStack {
//                    Text("현재 페이지 \(selection + 1)")
//                        .myFont(.headlineM)
//                        .foregroundStyle(.label(.normal))
//                    Spacer()
//                    Button {
//                        guard viewModel.pages.count > 1 else { return }
//                        viewModel.pages.remove(at: selection)
//                        selection -= 1
//                    } label: {
//                        Text("삭제")
//                    }
//                }
                TabView(selection: $selection) {
                    ForEach(Array(viewModel.pages.enumerated()), id: \.offset) { index, page in
                        PageEditor(text: $viewModel.pages[index])
                            .focused($focused, equals: index)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page)
                HStack(spacing: 0) {
                    if focused != nil {
                        Button {
                            focused = nil
                        } label: {
                            Text("닫기")
                                .myFont(.bodyM)
                                .foregroundStyle(.label(.normal))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                        }
                        .scaledButton()
                    }
                    Spacer()
                    MyButton("새 페이지", size: .medium, isRounded: true) {
                        viewModel.pages.append("")
                        selection = viewModel.pages.count - 1
                        focused = selection
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
            }
        }
        .navigationBarBackButtonHidden()
        .hideKeyboardWhenTap()
        .onChange(of: selection) {
            focused = nil
        }
        .onAppear {
            focused = 0
        }
        .myAlert("슬라이드를 게시하시겠습니까?", isPresented: $showCreateSlideConfirmationAlert) {
            MyAlertButton("게시", action: handleCreateSlide)
            MyAlertButton("취소")
        }
    }
}

extension NewSlideView {
    func handleCreateSlide() {
        guard !viewModel.fetching else { return }
        Task {
            do {
                _ = try await viewModel.createSlide()
                dismiss()
            } catch {
                showCreateSlideFailureAlert = true
            }
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
                        .padding(.leading, -3)
                        .myFont(.headlineM)
                        .foregroundStyle(.label(.assistive))
                }
            }
            .scrollContentBackground(.hidden)
    }
}

#Preview {
    NewSlideView()
}
