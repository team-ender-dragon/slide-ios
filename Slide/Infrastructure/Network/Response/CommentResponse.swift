import Foundation

struct CommentResponse: ResponseProtocol {
    let id: Int
    let like: Int
    let content: String
    let children: [CommentResponse]?
    let author: UserResponse
    let createdAt: Date
    
    func toModel() -> Comment {
        Comment(
            id: id,
            like: like,
            content: content,
            children: children?.map { $0.toModel() },
            author: author.toModel(),
            createdAt: createdAt
        )
    }
}
