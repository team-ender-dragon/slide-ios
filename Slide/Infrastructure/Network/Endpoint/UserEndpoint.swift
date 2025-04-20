enum UserEndpoint {
    case getUser(id: Int)
    case getMyInfo
    case editMyInfo(EditUserRequest)
}

extension UserEndpoint: MyTarget {
    var host: String { "user" }

    var route: Route {
        switch self {
        case .getUser(let id):
            .get("\(id)")

        case .getMyInfo:
            .get()

        case .editMyInfo(let body):
            .patch()
            .task(body.toJSONParameters())
        }
    }
}
