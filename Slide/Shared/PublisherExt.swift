import Combine
import Moya

extension Publisher where Failure == MoyaError {
    func catchToEmpty() -> AnyPublisher<Output, Never> {
        self
            .catch { _ in Empty<Output, Never>() }
            .eraseToAnyPublisher()
    }
    
    func sink(
        receiveValue: @escaping (Output) -> Void,
        failure: @escaping (Failure) -> Void
    ) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                failure(error)
            }
        }, receiveValue: receiveValue)
    }
}
