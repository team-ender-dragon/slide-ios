import SwiftUI
import ScopeKit

let isTest = false

@main
struct SlideApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    init() {
        let netRunner = DefaultNetRunner(
            provider: .init(
                session: MoyaProviderUtil.mySession,
                plugins: MoyaProviderUtil.myPlugins
            ),
            authProvider: .init(
                session: MoyaProviderUtil.myAuthSession,
                plugins: MoyaProviderUtil.myPlugins
            ),
            decoder: .decoder
        )
        DIContainer.shared.register(
            .init(
                slideService: SlideServiceImpl(netRunner: netRunner),
                commentService: CommentServiceImpl(netRunner: netRunner),
                userService: UserServiceImpl(netRunner: netRunner),
                authService: AuthServiceImpl(netRunner: netRunner)
            )
        )
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
                    .task {
                        try? await NotificationManager.shared.tryRequestNotificationPermission()
                    }
            }
        }
    }
}
