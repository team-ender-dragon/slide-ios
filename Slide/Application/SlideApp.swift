import SwiftUI
import ScopeKit

let isTest = false

@main
struct SlideApp: App {
    
    init() {
//        if isTest {
//            DIContainer.shared.register(
//                .init(
//                    slideService: TestSlideService(),
//                    commentService: CommentServiceImpl()
//                )
//            )
//        } else {
        DIContainer.shared.register(
            .init(
                slideService: SlideServiceImpl(),
                commentService: CommentServiceImpl()
            )
        )
//        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
        }
    }
}
