import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Inject(\.userService) private var userService
    
    @MainActor
    func fetchUser() {
        userService.getMyInfo()
            .catchToEmpty()
            .map { $0.toModel() }
            .assign(to: &$user)
    }
}
