extension CreatedCommentResponse {
    static let testCreatedComment1 = CreatedCommentResponse(
        id: CommentResponse.testComment1.id,
        slideId: 0,
        parentId: nil,
        content: CommentResponse.testComment1.content,
        createdAt: CommentResponse.testComment1.createdAt
    )
}
