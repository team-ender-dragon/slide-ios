import Foundation

public struct Sign {
    
    public static let shared = Sign()
    
    public let store: UserDefaultsStore
    
    public init(store: UserDefaultsStore = .shared) {
        self.store = store
    }
    
    public func login(
        accessToken: String?,
        refreshToken: String?
    ) {
        store.set(accessToken, for: "accessToken")
        KeychainStore.set(refreshToken, for: "refreshToken")
    }
    
    public func logout() {
        store.delete(key: "accessToken")
        KeychainStore.delete(key: "refreshToken")
    }
    
    public func reissue(_ accessToken: String?) {
        store.set(accessToken, for: "accessToken")
    }
    
    public var isLoggedIn: Bool {
        accessToken != nil
    }
    
    public var accessToken: String? {
        try? store.read(key: "accessToken")
    }
    
    public var refreshToken: String? {
        try? KeychainStore.read(key: "refreshToken")
    }
}
