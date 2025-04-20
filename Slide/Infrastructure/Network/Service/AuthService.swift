protocol AuthService {
    func signIn(request: SignInRequest) async throws -> TokenResponse
    func signUp(request: SignUpRequest) async throws -> TokenResponse
    func refreshToken(_ request: RefreshRequest) async throws -> TokenResponse
    func signInWithApple(request: OAuthRequest) async throws -> TokenResponse
    func signInWithGoogle(request: OAuthRequest) async throws -> TokenResponse
}
