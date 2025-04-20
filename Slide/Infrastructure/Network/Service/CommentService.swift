protocol CommentService {
    func getComments(slideId: Int) -> APIPublisher<[CommentResponse]>
    func postComment(request: PostCommentRequest) async throws -> CreatedCommentResponse
    func deleteComment(id: Int) async throws
}
