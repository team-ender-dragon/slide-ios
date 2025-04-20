protocol UserService {
    func getUser(id: Int) -> APIPublisher<UserResponse>
    func getMyInfo() -> APIPublisher<UserResponse>
    func editMyInfo(request: EditUserRequest) async throws -> UserResponse
}
