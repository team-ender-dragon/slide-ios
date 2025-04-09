import Foundation
import AuthenticationServices

struct SignInAppleResult {
    let idToken: String
    let nonce: String
}

class SignInApple: NSObject {
    typealias CompletionHandler = ((Result<SignInAppleResult, Error>) -> Void)
    
    private var currentNonce: String?
    private var completionHandler: CompletionHandler?
    
    func signInWithAppleFlow() async throws -> SignInAppleResult {
        try await withCheckedThrowingContinuation { [weak self] continuation in
            self?.signInWithAppleFlow { result in
                continuation.resume(with: result)
                return
            }
        }
    }
    
    func signInWithAppleFlow(completion: @escaping CompletionHandler) {
        guard let topVC = UIApplicationUtil.rootViewController else {
            completion(.failure(NSError()))
            return
        }
        
        let nonce = Nonce.randomNonceString()
        currentNonce = nonce
        completionHandler = completion
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest().apply {
            $0.requestedScopes = [.fullName, .email]
            $0.nonce = Nonce.sha256(nonce)
        }
        
        ASAuthorizationController(authorizationRequests: [request]).let {
            $0.delegate = self
            $0.presentationContextProvider = topVC
            $0.performRequests()
        }
    }
}

extension SignInApple: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor(frame: .zero)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce, let completion = completionHandler else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                completion(.failure(NSError()))
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                completion(.failure(NSError()))
                return
            }
            
            let appleResult = SignInAppleResult(idToken: idTokenString, nonce: nonce)
            completion(.success(appleResult))
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
}

extension UIViewController: @retroactive ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
