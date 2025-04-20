final class AuthServiceImpl: AuthService {
    let netRunner: NetRunner
    
    init(netRunner: NetRunner) {
        self.netRunner = netRunner
    }
    
    func signIn(request: SignInRequest) async throws -> TokenResponse {
        try await netRunner.request(AuthEndpoint.signIn(request), res: TokenResponse.self)
    }

    func signUp(request: SignUpRequest) async throws -> TokenResponse {
        try await netRunner.request(AuthEndpoint.signUp(request), res: TokenResponse.self)
    }

    func refreshToken(_ request: RefreshRequest) async throws -> TokenResponse {
        try await netRunner.request(AuthEndpoint.refresh(request), res: TokenResponse.self)
    }

    func signInWithApple(request: OAuthRequest) async throws -> TokenResponse {
        try await netRunner.request(AuthEndpoint.signInWithApple(request), res: TokenResponse.self)
    }

    func signInWithGoogle(request: OAuthRequest) async throws -> TokenResponse {
        try await netRunner.request(AuthEndpoint.signInWithGoogle(request), res: TokenResponse.self)
    }
}
