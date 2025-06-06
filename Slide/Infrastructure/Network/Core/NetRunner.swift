import Foundation
import Moya
import CombineMoya
import Combine
import ScopeKit

enum MoyaProviderUtil {
    static let myAuthSession = Session(interceptor: AuthInterceptor())
    static let mySession = Session()
    static let myPlugins = [
        NetworkLoggerPlugin(
            configuration: .init(
                logOptions: [
                    .requestMethod,
                    .requestBody,
                    .successResponseBody,
                    .errorResponseBody
                ]
            )
        )
    ]
}

public protocol NetRunner {
    var provider: MoyaProvider<AnyTarget> { get }
    var authProvider: MoyaProvider<AnyTarget> { get }

    func request<DTO: Decodable>(
        _ target: MyTarget,
        res: DTO.Type,
        completion: @escaping (Result<DTO, MoyaError>) -> Void
    )

    func request<DTO: Decodable>(
        _ target: MyTarget,
        res: DTO.Type
    ) -> AnyPublisher<DTO, MoyaError>

    func request<DTO: Decodable>(
        _ target: MyTarget,
        res: DTO.Type
    ) async throws -> DTO
}

class DefaultNetRunner: NetRunner {
    let provider: MoyaProvider<AnyTarget>
    let authProvider: MoyaProvider<AnyTarget>
    let decoder: JSONDecoder

    init(
        provider: MoyaProvider<AnyTarget>,
        authProvider: MoyaProvider<AnyTarget>,
        decoder: JSONDecoder
    ) {
        self.provider = provider
        self.authProvider = authProvider
        self.decoder = decoder
    }

    private func selectProvider(_ target: MyTarget) -> MoyaProvider<AnyTarget> {
        switch target.authorization {
        case .none:
            provider
        case .refresh:
            authProvider
        }
    }

    public func request<DTO>(
        _ target: MyTarget,
        res: DTO.Type,
        completion: @escaping (Result<DTO, Moya.MoyaError>) -> Void
    ) where DTO : Decodable {
        selectProvider(target).request(AnyTarget(target)) { result in
            switch result {
            case .success(let response):
                let response = self.unwrapThrowable {
                    try response.filterSuccessfulStatusCodes()
                        .map(res, using: self.decoder)
                }
                completion(response)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func request<DTO: Decodable>(
        _ target: MyTarget,
        res: DTO.Type
    ) -> AnyPublisher<DTO, MoyaError> {
        return selectProvider(target)
            .requestPublisher(AnyTarget(target))
            .filterSuccessfulStatusCodes() // 200..<300
            .map(DTO.self, using: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    public func request<DTO>(
        _ target: MyTarget,
        res: DTO.Type
    ) async throws -> DTO where DTO : Decodable {
        return try await selectProvider(target)
            .request(AnyTarget(target))
            .filterSuccessfulStatusCodes()
            .map(res, using: decoder)
    }

    private func unwrapThrowable<T>(
        throwable: @escaping () throws -> T
    ) -> Result<T, MoyaError> {
        do {
            return .success(try throwable())
        } catch {
            if let moyaError = error as? MoyaError {
                return .failure(moyaError)
            } else {
                return .failure(.underlying(error, nil))
            }
        }
    }
}
