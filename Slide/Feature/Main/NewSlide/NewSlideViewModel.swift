import Foundation

class NewSlideViewModel: ObservableObject {
    @Published var pages: [String] = [""] // 한 페이지는 기본 값
    @Published var tags: [String] = []
    @Published var fetching = false
    @Inject(\.slideService) private var slideService
    
    @MainActor
    func createSlide() async throws {
        fetching = true
        defer { fetching = false }
        if pages.contains(where: { $0.isEmpty }) {
            throw NewSlideError.emptyPage
        }
        
        let request = PostSlideRequest(pages: pages, tags: tags)
        try await slideService.postSlide(request: request)
    }
}
