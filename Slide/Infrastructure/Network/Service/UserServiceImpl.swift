import Foundation
import Combine

final class UserServiceImpl: UserService {
    private let netRunner: NetRunner

    init(netRunner: NetRunner) {
        self.netRunner = netRunner
    }

    func getUser(id: Int) -> APIPublisher<UserResponse> {
        netRunner.request(UserEndpoint.getUser(id: id), res: UserResponse.self)
    }

    func getMyInfo() -> APIPublisher<UserResponse> {
        netRunner.request(UserEndpoint.getMyInfo, res: UserResponse.self)
    }

    func editMyInfo(request: EditUserRequest) async throws -> UserResponse {
        try await netRunner.request(UserEndpoint.editMyInfo(request), res: UserResponse.self)
    }
}
