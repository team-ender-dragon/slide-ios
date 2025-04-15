protocol CommentService {
    func postComment(request: PostCommentRequest) -> APIPublisher<CreatedCommentResponse>
    func deleteComment(id: Int) -> APIPublisher<Void>
}
