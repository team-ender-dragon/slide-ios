enum AuthEndpoint {
    case signIn(SignInRequest)
    case signUp(SignUpRequest)
    case refresh(RefreshRequest)
    case signInWithApple(OAuthRequest)
    case signInWithGoogle(OAuthRequest)
}

extension AuthEndpoint: MyTarget {
    var host: String { "auth" }

    var route: Route {
        switch self {
        case .signIn(let body):
            .post("signin")
            .task(body.toJSONParameters())

        case .signUp(let body):
            .post("signup")
            .task(body.toJSONParameters())

        case .refresh(let body):
            .post("refresh")
            .task(body.toJSONParameters())

        case .signInWithApple(let body):
            .post("apple")
            .task(body.toJSONParameters())

        case .signInWithGoogle(let body):
            .post("google")
            .task(body.toJSONParameters())
        }
    }
    
    var authorization: Authorization {
        .none
    }
}
