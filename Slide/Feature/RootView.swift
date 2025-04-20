import SwiftUI

struct RootView: View {
    @StateObject private var router = Router()
    @AppStorage("accessToken", store: UserDefaultsStore.shared.userDefaults) var accessToken: String?
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                if accessToken == nil {
                    StartView()
                } else {
                    MainView()
                }
            }
            .navigationDestination(for: NavGroup.self) { navGroup in
                Group {
                    switch navGroup {
                    case .newPost:
                        NewSlideView()
                    case .emailSignIn:
                        EmailSignInView()
                    case .emailSignUp:
                        EmailSignUpView()
                    case .setting:
                        SettingView()
                    case .profileEdit:
                        ProfileEditView()
                    }
                }
                .environmentObject(router)
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    RootView()
}
