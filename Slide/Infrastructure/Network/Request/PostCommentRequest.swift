struct PostCommentRequest: RequestProtocol {
    let slideId: Int
    let content: String
    let parentId: Int?
}
