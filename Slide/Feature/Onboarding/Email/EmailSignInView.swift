import SwiftUI

struct EmailSignInView: View {
    @EnvironmentObject private var router: Router
    @StateObject private var viewModel = EmailSignInViewModel()
    @State private var isAlertPresented = false
    
    var body: some View {
        MyNavigationBar.small(title: "이메일 로그인") {
            VStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 12) {
                    MyTextField("이메일", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .firstResponder()
                    MyTextField("비밀번호", text: $viewModel.password, isSecured: true)
                }
                Spacer()
                VStack(alignment: .center, spacing: 16) {
                    HStack(spacing: 4) {
                        Text("계정이 없으시다면?")
                        Button {
                            router.push(.emailSignUp)
                        } label: {
                            Text("회원가입")
                                .underline()
                        }
                        .scaledButton()
                    }
                    .foregroundStyle(.label(.normal))
                    .myFont(.bodyR)
                    MyButton("로그인", expanded: true) {
                        handleSignIn()
                    }
                    .disabled(!viewModel.isInputValid)
                }
            }
            .padding(16)
        }
        .hideKeyboardWhenTap()
    }
}

private extension EmailSignInView {
    func handleSignIn() {
        Task {
            do {
                try await viewModel.signIn()
                router.toRoot()
            } catch {
                isAlertPresented = true // 실패 시 alert 표시
            }
        }
    }
}
