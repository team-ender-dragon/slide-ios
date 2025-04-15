struct PageResponse: ResponseProtocol {
    let id: Int
    let content: String
    let page: Int
    
    func toModel() -> Page {
        Page(
            id: id,
            content: content,
            page: page
        )
    }
}
