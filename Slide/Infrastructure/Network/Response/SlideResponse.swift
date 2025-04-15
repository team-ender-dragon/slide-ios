import Foundation

struct SlideResponse: ResponseProtocol {
    let id: Int
    let like: Int
    let tags: [String]
    let createdAt: Date
    let pages: [PageResponse]
    let comments: [CommentResponse]
    let author: UserResponse
    
    func toModel() -> Slide {
        Slide(
            id: id,
            like: like,
            tags: tags,
            createdAt: createdAt,
            pages: pages.map { $0.toModel() },
            comments: comments.map { $0.toModel() },
            author: author.toModel()
        )
    }
}
