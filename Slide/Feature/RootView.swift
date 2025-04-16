import SwiftUI

struct RootView: View {
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            MainView()
        }
        .environmentObject(router)
    }
}

#Preview {
    RootView()
}
