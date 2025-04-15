import Foundation

struct CreatedCommentResponse: ResponseProtocol {
    let id: Int
    let slideId: Int
    let parentId: Int?
    let content: String
    let createdAt: Date
}
