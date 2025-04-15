protocol SlideService {
    func getSlides(request: GetSlidePageRequest) -> APIPublisher<[SlideResponse]>
    func getSlide(id: Int) -> APIPublisher<SlideResponse>
    func postSlide(request: PostSlideRequest) -> APIPublisher<SlideResponse>
    func patchSlide(request: PostSlideRequest) -> APIPublisher<SlideResponse>
    func deleteSlide(id: Int) -> APIPublisher<Void>
}
