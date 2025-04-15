import ScopeKit
import Foundation

extension CommentResponse {
    static let testComment1 = CommentResponse(
        id: 0,
        like: 3,
        content: "굳",
        children: nil,
        author: .testUser1,
        createdAt: .now.with {
            $0[.hour] -= 10
        }
    )
    static let testComment2 = CommentResponse(
        id: 1,
        like: 2,
        content: "이 글을 보고 많은 도움이 되었습니다. 감사합니다!",
        children: nil,
        author: .testUser2,
        createdAt: .now.with {
            $0[.day] -= 3
        }
    )
}

extension [CommentResponse] {
    // for testSlide1
    static let testComments: [CommentResponse] = [
        .testComment1,
        .testComment2
    ]
}
