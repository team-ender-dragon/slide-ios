import Combine
import Moya

typealias APIPublisher<T> = AnyPublisher<T, MoyaError>
