import ScopeKit

extension SlideResponse {
    static let testSlide1 = SlideResponse(
        id: 0,
        like: 10,
        tags: ["과학", "철학", "물리학", "생각", "관념"],
        createdAt: .now.with {
            $0[.hour] -= 3
        },
        pages: .testPages1,
        comments: .testComments,
        author: .testUser1
    )
}

extension [SlideResponse] {
    static var testSlides: Self = [.testSlide1]
}
