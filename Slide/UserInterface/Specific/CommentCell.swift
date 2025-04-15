import SwiftUI

struct CommentCell: View {
    let comment: Comment
    let action: (Self.Action) -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            AsyncImage(url: comment.author.avatarUrl)
                .clipShape(.circle)
                .frame(width: 24, height: 24)
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .top, spacing: 6) {
                    Text(String(comment.author.nickname))
                        .myFont(.labelM)
                        .foregroundStyle(.label(.normal))
                    Text(comment.createdAt.timeAgoText)
                        .myFont(.labelM)
                        .foregroundStyle(.label(.assistive))
                }
                Text(comment.content)
                    .myFont(.bodyR)
                    .foregroundStyle(.label(.normal))
                Button {
                    action(.replyComment)
                } label: {
                    Text("답장하기")
                        .myFont(.labelM)
                        .foregroundStyle(.label(.alternative))
                }
            }
        }
    }
}

extension CommentCell {
    enum Action {
        case replyComment
    }
}

//#Preview {
//    CommentCell(comment: .dummy1) { _ in
//        
//    }
//}
