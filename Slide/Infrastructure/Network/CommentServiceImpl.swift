import Combine
import Foundation

class CommentServiceImpl: CommentService {
    func postComment(request: PostCommentRequest) -> APIPublisher<CreatedCommentResponse> {
        Just(CreatedCommentResponse.testCreatedComment1)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func deleteComment(id: Int) -> APIPublisher<Void> {
        Just(())
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
