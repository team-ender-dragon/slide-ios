import Foundation
import Combine

final class SlideServiceImpl: SlideService {
    private let netRunner: NetRunner

    init(netRunner: NetRunner) {
        self.netRunner = netRunner
    }

    func getSlides(request: GetSlidePageRequest) -> APIPublisher<[SlideResponse]> {
        netRunner.request(SlideEndpoint.getSlides(request), res: [SlideResponse].self)
    }

    func getSlide(id: Int) -> APIPublisher<SlideResponse> {
        netRunner.request(SlideEndpoint.getSlide(id: id), res: SlideResponse.self)
    }

    func postSlide(request: PostSlideRequest) async throws {
        _ = try await netRunner.request(SlideEndpoint.createSlide(request), res: EmptyResponse.self)
    }

    func patchSlide(id: Int, request: PatchSlideRequest) async throws {
        _ = try await netRunner.request(SlideEndpoint.updateSlide(id: id, request), res: EmptyResponse.self)
    }

    func deleteSlide(id: Int) async throws {
        _ = try await netRunner.request(SlideEndpoint.deleteSlide(id: id), res: EmptyResponse.self)
    }
}
