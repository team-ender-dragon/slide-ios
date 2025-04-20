import CryptoKit
import GoogleSignIn

struct SignInGoogleResult {
    let idToken: String
    let nonce: String
}

class SignInGoogle {
    @MainActor
    func signInWithGoogleFlow() async throws -> SignInGoogleResult {
        guard let topVC = UIApplicationUtil.rootViewController else {
            throw NSError()
        }
        let nonce = Nonce.randomNonceString()
        let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        let user = signInResult.user
        
        guard let idToken = user.idToken else {
            throw NSError()
        }
        
        return .init(idToken: idToken.tokenString, nonce: nonce)
    }
}
