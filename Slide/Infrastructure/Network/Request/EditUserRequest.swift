import Foundation

struct EditUserRequest: RequestProtocol {
    let nickname: String
    let avatarUrl: String?
}
