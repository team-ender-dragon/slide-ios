import Foundation
import Combine

class TestSlideService: SlideService {
    func getSlides(request: GetSlidePageRequest) -> APIPublisher<[SlideResponse]> {
        Empty()
            .eraseToAnyPublisher()
    }
    
    func getSlide(id: Int) -> APIPublisher<SlideResponse> {
        Empty()
            .eraseToAnyPublisher()
//        Just()
//            .delay(for: .seconds(3), scheduler: DispatchQueue.main)
    }
    
    func postSlide(request: PostSlideRequest) -> APIPublisher<SlideResponse> {
        Empty()
            .eraseToAnyPublisher()
    }
    
    func patchSlide(request: PostSlideRequest) -> APIPublisher<SlideResponse> {
        Empty()
            .eraseToAnyPublisher()
    }
    
    func deleteSlide(id: Int) -> APIPublisher<Void> {
        Empty()
            .eraseToAnyPublisher()
    }
}
