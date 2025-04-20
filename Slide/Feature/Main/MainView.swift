import SwiftUI


struct MainView: View {
    @EnvironmentObject private var router: Router
    @State private var selection = 0
    
    var body: some View {
        MyBottomBar(selection: $selection) {
            HomeView()
                .page(.icon(selected: .icon(.HomeFill), unselected: .icon(.HomeLine)))
            EmptyView()
                .page(.icon(selected: .icon(.Search), unselected: .icon(.Search)))
            EmptyView()
                .page(.add)
            EmptyView()
                .page(.icon(selected: .icon(.EmailFill), unselected: .icon(.EmailLine)))
            ProfileView()
                .page(.icon(selected: .icon(.PersonFill), unselected: .icon(.PersonLine)))
        } addAction: {
            router.push(.newPost)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    MainView()
}
