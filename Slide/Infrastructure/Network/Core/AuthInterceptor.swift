import Foundation
import Combine
import Alamofire

enum AuthError: Error {
    case refreshFailure
}

final class AuthInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        guard let accessToken = Sign.shared.accessToken else {
            completion(.success(urlRequest))
            return
        }
        print("✅ AuthInterceptor - Set token \(accessToken)")
        var modifiedRequest = urlRequest
        modifiedRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(modifiedRequest))
    }

    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            DispatchQueue.main.async {
                completion(.doNotRetryWithError(error))
            }
            return
        }
        
        guard request.retryCount <= 2 else {
            print("❌ AuthInterceptor - RetryCount가 2보다 큽니다")
            DispatchQueue.main.async {
                completion(.doNotRetryWithError(AuthError.refreshFailure))
            }
            return
        }
        
        print("❌ AuthInterceptor - statusCode: \(response.statusCode)")
        
        let tokenExpiredStatusCode = 401
        guard response.statusCode == tokenExpiredStatusCode else {
            print("❌ AuthInterceptor - HTTP statusCode is not \(tokenExpiredStatusCode)")
            DispatchQueue.main.async {
                completion(.doNotRetryWithError(error))
            }
            return
        }
        guard let refreshToken = Sign.shared.refreshToken else {
            print("❌ AuthInterceptor - refreshToken is nil")
            DispatchQueue.main.async {
                completion(.doNotRetryWithError(AuthError.refreshFailure))
            }
            return
        }
        
        @Inject(\.authService) var authService
        
        Task {
            do {
                let token = try await authService.refreshToken(.init(refreshToken: refreshToken))
                Sign.shared.reissue(token.accessToken)
                completion(.retry)
            } catch {
                completion(.doNotRetryWithError(AuthError.refreshFailure))
            }
        }
    }
}
