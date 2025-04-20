import Moya

public struct Route {
    struct VoidRes: Decodable {}
    
    public let method: Moya.Method
    public let path: String
    public let task: Moya.Task
    
    private init(method: Moya.Method, path: String, task: Moya.Task) {
        self.method = method
        self.path = path
        self.task = task
    }
    
    public static func connect(_ path: String) -> Self {
        Self.init(method: .connect, path: path, task: .requestPlain)
    }
    
    public static func delete(_ path: String = "") -> Self {
        Self.init(method: .delete, path: path, task: .requestPlain)
    }
    
    public static func get(_ path: String = "") -> Self {
        Self.init(method: .get, path: path, task: .requestPlain)
    }
    
    public static func head(_ path: String = "") -> Self {
        Self.init(method: .head, path: path, task: .requestPlain)
    }
    
    public static func options(_ path: String = "") -> Self {
        Self.init(method: .options, path: path, task: .requestPlain)
    }

    public static func patch(_ path: String = "") -> Self {
        Self.init(method: .patch, path: path, task: .requestPlain)
    }
    
    public static func post(_ path: String = "") -> Self {
        Self.init(method: .post, path: path, task: .requestPlain)
    }
    
    public static func put(_ path: String = "") -> Self {
        Self.init(method: .put, path: path, task: .requestPlain)
    }
    
    public static func query(_ path: String = "") -> Self {
        Self.init(method: .query, path: path, task: .requestPlain)
    }
    
    public static func trace(_ path: String = "") -> Self {
        Self.init(method: .trace, path: path, task: .requestPlain)
    }

    public func task(_ task: Moya.Task) -> Self {
        Self.init(method: method, path: path, task: task)
    }
}
