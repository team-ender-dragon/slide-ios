import Foundation

struct User: ModelProtocol {
    let id: Int
    let nickname: String
    let avatarUrl: URL?
    let bio: String
}
