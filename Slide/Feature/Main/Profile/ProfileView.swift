import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var router: Router
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                infos
            }
        }
        .background(.background(.normal))
        .refreshable {
            viewModel.fetchUser()
        }
        .task {
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    private var infos: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 24) {
                // Info
                VStack(alignment: .leading, spacing: 8) {
                    if let user = viewModel.user {
                        HStack(spacing: 8) {
                            //                        HStack(alignment: .top, spacing: 8) {
                            MyAvatar(url: user.avatarUrl, type: .larger)
                            VStack(alignment: .leading, spacing: 8) {
                                Text(user.nickname)
                                    .myFont(.title3B)
                                    .foregroundStyle(.label(.normal))
                                //                                Text(user.username)
                                //                                    .myFont(.labelM)
                                //                                    .foregroundStyle(.label(.normal))
                            }
                        }
                        Text(user.bio)
                            .myFont(.labelM)
                            .foregroundStyle(.label(.normal))
                    }
                }
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Button {
                    router.push(.setting)
                } label: {
                    Image.icon(.Setting)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.label(.assistive))
                        .frame(width: 28, height: 28)
                }
                .scaledButton()
            }
            
            //                Text("\(user.followerCount) followers")
            //                    .myFont(.labelR)
            //                    .foregroundStyle(.label(.alternative))
            
            HStack(alignment: .top, spacing: 12) {
                MyButton("프로필 수정", size: .medium, role: .assistive, expanded: true) {
                    router.push(.profileEdit)
                }
                MyButton("프로필 공유", size: .medium, role: .assistive, expanded: true) {
                    // 공유 로직
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 8)
    }
}

#Preview {
    ProfileView()
}
