import Foundation

@MainActor
class CommentSheetViewModel: ObservableObject {
    @Published var comment = ""
    @Published var comments: [Comment]? = []
    
    func fetchComments() async throws {
        
    }
    
    func postComment() async throws {
        
    }
}
