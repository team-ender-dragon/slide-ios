final class DIContainer {
    static let shared = DIContainer()

    private var registry: ServiceRegistry?

    private init() {}

    func register(_ registry: ServiceRegistry) {
        self.registry = registry
    }

    func resolve<T>(_ keyPath: KeyPath<ServiceRegistry, T>) -> T {
        guard let registry else {
            fatalError("DIContainer has not been initialized. Call register(_:)")
        }
        return registry[keyPath: keyPath]
    }

    func reset() {
        registry = nil
    }
}
