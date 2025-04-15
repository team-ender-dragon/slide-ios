import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isSignInSheetPresented = false
    
    var body: some View {
        MyNavigationBar.default(
            title: "프로필",
            background: .background(.normal)
        ) {
            Button {
                isSignInSheetPresented = true
            } label: {
                Text("로그인")
            }
        }
        .sheet(isPresented: $isSignInSheetPresented) {
            VStack(spacing: 12) {
                Spacer().frame(height: 16)
                AppleSignInButton {
                    Task {
                        do {
                            try await viewModel.signInWithApple()
                        } catch {
                            print(error)
                        }
                    }
                }
                GoogleSignInButton {
                    Task {
                        do {
                            try await viewModel.signInWithGoogle()
                        } catch {
                            print(error)
                        }
                    }
                }
                MyButton("이메일로 계속하기", expanded: true) {
                    
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .presentationDetents([.height(220)])
        }
    }
}

#Preview {
    ProfileView()
}
