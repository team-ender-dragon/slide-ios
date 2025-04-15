import SwiftUI

struct CommentSheetView: View {
    @StateObject private var viewModel = CommentSheetViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 20)
            Text("댓글")
                .myFont(.bodyB)
            MyDivider()
                .padding(.top, 12)
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        if let comments = viewModel.comments {
                            ForEach(comments) { comment in
                                CommentCell(comment: comment) { action in
                                    switch action {
                                    case .replyComment:
                                        break
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, 16)
                }
                CommentInput(comment: $viewModel.comment) {
                    Task {
                        try await viewModel.postComment()
                    }
                }
                .padding(.bottom, 8)
            }
            .padding(.horizontal, 12)
        }
    }
}
struct CommentInput: View {
    @Binding var comment: String
    let sendAction: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            TextField("생각을 남겨보세요.", text: $comment)
                .padding(12)
                .advancedFocus()
            if !comment.isEmpty {
                Button(action: sendAction) {
                    Image.icon(.Send)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 28, height: 28)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 2)
                        .background(.primary(.normal), in: .rect(cornerRadius: .infinity))
                }
                .scaledButton()
                .padding(.trailing, 8)
            }
        }
        .strokeBorder(.infinity, content: .line(.normal))
    }
}
