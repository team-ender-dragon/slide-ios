import Foundation

struct Comment: ModelProtocol, Identifiable {
    let id: Int
    let like: Int
    let content: String
    let children: [Comment]?
    let author: User
    let createdAt: Date
}
