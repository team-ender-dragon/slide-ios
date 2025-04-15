struct GetSlidePageResponse: ResponseProtocol {
    let amount: Int
    let nextPage: Int
    let slides: [SlideResponse]
}
