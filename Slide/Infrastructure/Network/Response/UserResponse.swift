import Foundation

struct UserResponse: ResponseProtocol {
    let id: Int
    let nickname: String
    let avatarUrl: URL?
    let bio: String
    
    func toModel() -> User {
        User(
            id: id,
            nickname: nickname,
            avatarUrl: avatarUrl,
            bio: bio
        )
    }
}
