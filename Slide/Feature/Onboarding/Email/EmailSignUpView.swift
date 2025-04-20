import SwiftUI
import PhotosUI

struct EmailSignUpView: View {
    @EnvironmentObject private var router: Router
    @StateObject private var viewModel = EmailSignUpViewModel()
    @State private var isAlertPresented = false

    var body: some View {
        MyNavigationBar.small(title: "회원가입") {
            VStack(spacing: 12) {
                PhotosPicker(selection: $viewModel.avatarImageItem, matching: .images) {
                    ZStack {
                        if let image = viewModel.avatarPreview {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image.icon(.AddLine)
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.label(.normal))
                        }
                    }
                    .frame(width: 88, height: 88)
                    .clipShape(.circle)
                    .strokeBorder(.infinity, content: .line(.normal))
                }

                MyTextField("닉네임", text: $viewModel.nickname)
                MyTextField("이메일", text: $viewModel.email)
                MyTextField("비밀번호", text: $viewModel.password, isSecured: true)

                Spacer()

                MyButton("회원가입", expanded: true) {
                    handleSignUp()
                }
                .disabled(!viewModel.isInputValid)
            }
            .padding(16)
        }
        .hideKeyboardWhenTap()
        .myAlert("회원가입에 실패했습니다", isPresented: $isAlertPresented) {
            MyAlertButton("확인") {}
        }
    }
}

private extension EmailSignUpView {
    func handleSignUp() {
        Task {
            do {
                try await viewModel.signUp()
                router.toRoot()
            } catch {
                isAlertPresented = true
            }
        }
    }
}
