final class CommentServiceImpl: CommentService {
    private let netRunner: NetRunner

    init(netRunner: NetRunner) {
        self.netRunner = netRunner
    }

    func getComments(slideId: Int) -> APIPublisher<[CommentResponse]> {
        netRunner.request(CommentEndpoint.getComments(slideId: slideId), res: [CommentResponse].self)
    }

    func postComment(request: PostCommentRequest) async throws -> CreatedCommentResponse {
        try await netRunner.request(CommentEndpoint.postComment(request), res: CreatedCommentResponse.self)
    }

    func deleteComment(id: Int) async throws {
        _ = try await netRunner.request(CommentEndpoint.deleteComment(id: id), res: EmptyResponse.self)
    }
}
