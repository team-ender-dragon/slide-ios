import Foundation

extension UserResponse {
    static let testUser1 = UserResponse(id: 0, nickname: "노영재", avatarUrl: URL(string: "https://dthezntil550i.cloudfront.net/o8/latest/o81609031955192330001399635/1280_960/50727b96-e35e-4b32-a264-adafcf51de7c.png"))
    static let testUser2 = UserResponse(id: 1, nickname: "박병준", avatarUrl: URL(string: "https://raw.githubusercontent.com/github/explore/8baf984947f4d9c32006bd03fa4c51ff91aadf8d/topics/android/android.png"))
}

extension [UserResponse] {
    static var testUsers: [UserResponse] = [
        .testUser1,
        .testUser2
    ]
}
