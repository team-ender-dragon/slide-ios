protocol SlideService {
    func getSlides(request: GetSlidePageRequest) -> APIPublisher<[SlideResponse]>
    func getSlide(id: Int) -> APIPublisher<SlideResponse>
    func postSlide(request: PostSlideRequest) async throws
    func patchSlide(id: Int, request: PatchSlideRequest) async throws
    func deleteSlide(id: Int) async throws
}
