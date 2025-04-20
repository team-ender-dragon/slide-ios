import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var router: Router
    @StateObject private var viewModel = SettingViewModel()
    
    var body: some View {
        MyNavigationBar.small(title: "설정") {
            LazyVStack(spacing: 4) {
                ListCell(title: "로그아웃") {
                    Sign.shared.logout()
                    router.toRoot()
                }
                ListCell(title: "회원탈퇴") {
                    // TODO:
                }
                MyDivider(type: .medium)
                ListCell(title: "개인정보 처리 방침") {
                    // TODO:
                }
                ListCell(title: "서비스 운영 정책") {
                    // TODO:
                }
            }
        }
    }
}



#Preview {
    SettingView()
}
