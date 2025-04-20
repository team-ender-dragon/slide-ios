import Foundation

final class EmailSignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""

    @Inject(\.authService) private var authService: AuthService

    var isInputValid: Bool {
        !email.isEmpty && !password.isEmpty
    }

    @MainActor
    func signIn() async throws {
        let request = SignInRequest(email: email, password: password)
        let token = try await authService.signIn(request: request)
        Sign.shared.login(
            accessToken: token.accessToken,
            refreshToken: token.refreshToken
        )
    }
}
