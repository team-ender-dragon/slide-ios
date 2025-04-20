struct SignUpRequest: RequestProtocol {
    let email: String
    let password: String
    let nickname: String
    let avatarUrl: String?
}
