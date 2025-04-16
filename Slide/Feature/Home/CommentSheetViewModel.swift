import Foundation

let testComments = [CommentResponse].testComments.map { $0.toModel() }

@MainActor
class CommentSheetViewModel: ObservableObject {
    @Published var comment = ""
    @Published var comments: [Comment]? = testComments
    
    func fetchComments() async throws {
        
    }
    
    func postComment() async throws {
        
    }
}
