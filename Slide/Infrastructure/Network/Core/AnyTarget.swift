import Foundation
import Moya

public enum AnyTarget {
    case endpoint(any MyTarget)
    var endpoint: any MyTarget {
        switch self {
        case .endpoint(let endpoint):
            return endpoint
        }
    }
    
    public init(_ endpoint: MyTarget) {
        self = .endpoint(endpoint)
    }
}

extension AnyTarget: MyTarget {
    public var host: String { endpoint.host }
    public var route: Route { endpoint.route }
    public var baseURL: URL { endpoint.baseURL }
}
