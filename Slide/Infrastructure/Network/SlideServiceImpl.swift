import Combine
import Foundation

class SlideServiceImpl: SlideService {
    func getSlides(request: GetSlidePageRequest) -> APIPublisher<[SlideResponse]> {
        return Empty()
            .eraseToAnyPublisher()
    }
    
    func getSlide(id: Int) -> APIPublisher<SlideResponse> {
        Empty()
            .eraseToAnyPublisher()
    }
    
    func postSlide(request: PostSlideRequest) -> APIPublisher<SlideResponse> {
        Empty()
            .eraseToAnyPublisher()
    }
    
    func patchSlide(request: PostSlideRequest) -> APIPublisher<SlideResponse> {
        let response = SlideResponse(
            id: 3,
            like: 1,
            tags: request.tags,
            createdAt: .now,
            pages: request.pages.enumerated().map { index, content in .init(id: index + 10, content: content, page: index) },
            comments: [],
            author: .testUser1
        )
        return Just(response)
            .delay(for: .seconds(3), scheduler: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func deleteSlide(id: Int) -> APIPublisher<Void> {
        Just(())
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
