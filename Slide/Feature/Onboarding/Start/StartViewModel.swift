import Foundation

class StartViewModel: ObservableObject {
    let signInGoogle = SignInGoogle()
    let signInApple = SignInApple()
    
    @MainActor
    func signInWithApple() async throws -> SignInAppleResult {
        return try await signInApple.signInWithAppleFlow()
    }
    
    @MainActor
    func signInWithGoogle() async throws -> SignInGoogleResult {
        return try await signInGoogle.signInWithGoogleFlow()
    }
}
