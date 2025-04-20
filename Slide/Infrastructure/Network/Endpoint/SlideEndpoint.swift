enum SlideEndpoint {
    case getSlide(id: Int)
    case getSlides(GetSlidePageRequest)
    case createSlide(PostSlideRequest)
    case updateSlide(id: Int, PatchSlideRequest)
    case deleteSlide(id: Int)
}

extension SlideEndpoint: MyTarget {
    var host: String { "slide" }

    var route: Route {
        switch self {
        case .getSlide(let id):
            .get("\(id)")

        case .getSlides(let body):
            .get()
            .task(body.toURLParameters())

        case .createSlide(let body):
            .post()
            .task(body.toJSONParameters())

        case .updateSlide(let id, let body):
            .patch("\(id)")
            .task(body.toJSONParameters())

        case .deleteSlide(let id):
            .delete("\(id)")
        }
    }
}
