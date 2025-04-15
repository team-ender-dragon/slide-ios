import Foundation

class HomeViewModel: ObservableObject {
    @Inject(\.slideService) var slideService
    
    @Published var slides: [Slide]?
    
    func getSlide() {
//        let response = try await PostService.shared.get()
//        self.posts = posts
    }
}
