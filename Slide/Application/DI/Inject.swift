@propertyWrapper
struct Inject<T> {
    private let value: T

    init(_ keyPath: KeyPath<ServiceRegistry, T>) {
        self.value = DIContainer.shared.resolve(keyPath)
    } 

    var wrappedValue: T {
        value
    }
}
