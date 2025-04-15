import Foundation

struct Slide: ModelProtocol, Identifiable {
    let id: Int
    let like: Int
    let tags: [String]
    let createdAt: Date
    let pages: [Page]
    let comments: [Comment]
    let author: User
}
