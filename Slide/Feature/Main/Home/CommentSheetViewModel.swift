import Foundation

@MainActor
class CommentSheetViewModel: ObservableObject {
    @Published var comment = ""
    @Published var comments: [Comment]? = nil
    
    func fetchComments() {
        
    }
    
    func postComment() async throws {
        
    }
}
