////
////  NetRunner.swift
////  Slide
////
////  Created by hhhello0507 on 4/2/25.
////
//
//import Foundation
//import Moya
//import CombineMoya
//import Combine
//import ScopeKit
//
//enum MoyaProviderUtil {
//    static let myAuthSession = Session(interceptor: AuthInterceptor())
//    static let mySession = Session()
//    static let myPlugins = [
//        NetworkLoggerPlugin(
//            configuration: .init(
//                logOptions: [
//                    .requestMethod,
//                    .requestBody,
//                    .successResponseBody,
//                    .errorResponseBody
//                ]
//            )
//        )
//    ]
//}
//
//let runner = DefaultNetRunner(
//    provider: .init(
//        session: MoyaProviderUtil.mySession,
//        plugins: MoyaProviderUtil.myPlugins
//    ),
//    authProvider: .init(
//        session: MoyaProviderUtil.myAuthSession,
//        plugins: MoyaProviderUtil.myPlugins
//    )
//)
//
//public protocol NetRunner {
//    var provider: MoyaProvider<AnyTarget> { get }
//    var authProvider: MoyaProvider<AnyTarget> { get }
//    
//    func request<DTO: Decodable>(
//        _ target: MyTarget,
//        res: DTO.Type,
//        completion: @escaping (Result<DTO, MoyaError>) -> Void
//    )
//    
//    func request<DTO: Decodable>(
//        _ target: MyTarget,
//        res: DTO.Type
//    ) -> AnyPublisher<DTO, MoyaError>
//    
//    func request<DTO: Decodable>(
//        _ target: MyTarget,
//        res: DTO.Type
//    ) -> AnyPublisher<Result<DTO, MoyaError>, Never>
//    
//    func request<DTO: Decodable>(
//        _ target: MyTarget,
//        res: DTO.Type
//    ) async -> Result<DTO, MoyaError>
//    
//    func request<DTO: Decodable>(
//        _ target: MyTarget,
//        res: DTO.Type
//    ) async throws -> DTO
//}
//
//class DefaultNetRunner: NetRunner {
//    let provider: MoyaProvider<AnyTarget>
//    let authProvider: MoyaProvider<AnyTarget>
//    let decoder: JSONDecoder
//    
//    init(
//        provider: MoyaProvider<AnyTarget> = .init(),
//        authProvider: MoyaProvider<AnyTarget> = .init(),
//        decoder: JSONDecoder = .decoder
//    ) {
//        self.provider = provider
//        self.authProvider = authProvider
//        self.decoder = decoder
//    }
//    
//    private func selectProvider(_ target: MyTarget) -> MoyaProvider<AnyTarget> {
//        switch target.authorization {
//        case .none:
//            provider
//        case .refresh:
//            authProvider
//        }
//    }
//    
//    public func request<DTO>(
//        _ target: MyTarget,
//        res: DTO.Type,
//        completion: @escaping (Result<DTO, Moya.MoyaError>) -> Void
//    ) where DTO : Decodable {
//        selectProvider(target).request(AnyTarget(target)) { result in
//            switch result {
//            case .success(let response):
//                let response = self.unwrapThrowable {
//                    try response.filterSuccessfulStatusCodes()
//                        .map(res, using: self.decoder)
//                }
//                completion(response)
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//    
//    public func request<DTO: Decodable>(
//        _ target: MyTarget,
//        res: DTO.Type
//    ) -> AnyPublisher<DTO, MoyaError> {
//        return selectProvider(target)
//            .requestPublisher(AnyTarget(target))
//            .filterSuccessfulStatusCodes() // 200..<300
//            .map(DTO.self, using: decoder)
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//    
//    public func request<DTO>(
//        _ target: MyTarget,
//        res: DTO.Type
//    ) -> AnyPublisher<Result<DTO, Moya.MoyaError>, Never> where DTO : Decodable {
//        return selectProvider(target)
//            .requestPublisher(AnyTarget(target))
//            .filterSuccessfulStatusCodes()
//            .map(DTO.self, using: decoder)
//            .map {  Result.success($0) }
//            .catch { Just(Result.failure($0)) }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//    
//    public func request<DTO>(
//        _ target: MyTarget,
//        res: DTO.Type
//    ) async -> Result<DTO, MoyaError> where DTO : Decodable {
//        return await selectProvider(target)
//            .request(AnyTarget(target))
//            .flatMap { response in
//                unwrapThrowable {
//                    try response
//                        .filterSuccessfulStatusCodes()
//                        .map(res, using: self.decoder)
//                }
//            }
//    }
//    
//    public func request<DTO>(
//        _ target: MyTarget,
//        res: DTO.Type
//    ) async throws -> DTO where DTO : Decodable {
//        return try await selectProvider(target)
//            .request(AnyTarget(target))
//            .filterSuccessfulStatusCodes()
//            .map(res, using: decoder)
//    }
//    
//    private func unwrapThrowable<T>(
//        throwable: @escaping () throws -> T
//    ) -> Result<T, MoyaError> {
//        do {
//            return .success(try throwable())
//        } catch {
//            if let moyaError = error as? MoyaError {
//                return .failure(moyaError)
//            } else {
//                return .failure(.underlying(error, nil))
//            }
//        }
//    }
//}
