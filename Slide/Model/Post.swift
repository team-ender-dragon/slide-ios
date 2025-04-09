struct Post: ModelProtocol {
    let id: Int
    let content: String
    let author: Int
    let tags: [String]
}
