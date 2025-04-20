enum CommentEndpoint {
    case getComments(slideId: Int)
    case postComment(PostCommentRequest)
    case deleteComment(id: Int)
}

extension CommentEndpoint: MyTarget {
    var host: String { "comment" }

    var route: Route {
        switch self {
        case .getComments(let slideId):
            .get("\(slideId)")

        case .postComment(let request):
            .post()
            .task(request.toJSONParameters())

        case .deleteComment(let id):
            .delete("\(id)")
        }
    }
}
