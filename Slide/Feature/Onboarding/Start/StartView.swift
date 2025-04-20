import SwiftUI

struct StartView: View {
    @EnvironmentObject private var router: Router
    @StateObject private var viewModel = StartViewModel()
    @State private var isSignInSheetPresented = false
    
    var body: some View {
        VStack(alignment: .center) {
            Image(.slide)
                .resizable()
                .scaledToFill()
                .frame(width: 128, height: 144)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            VStack(alignment: .center, spacing: 64) {
                VStack(alignment: .center, spacing: 8) {
                    Text("시작하기")
                        .myFont(.title2B)
                        .foregroundStyle(.label(.normal))
                    Text("생각을 넘겨보세요.\n짧은 글에서 깊은 이야기를 만납니다")
                        .myFont(.bodyM)
                        .foregroundStyle(.label(.normal))
                        .multilineTextAlignment(.center)
                }
                Button {
                    isSignInSheetPresented = true
                } label: {
                    Image.icon(.NormalArrow)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.primary(.onPrimary))
                        .frame(width: 24, height: 24)
                        .rotationEffect(.degrees(180))
                        .padding(20)
                        .background(.primary(.normal))
                        .clipShape(.circle)
                }
                .scaledButton(.circle)
                .shadow(color: .primary(.normal).opacity(0.4), radius: 12, x: 0, y: 4)
            }
            .padding(.vertical, 64)
            .frame(maxWidth: .infinity, alignment: .top)
            .background(.background(.alternative))
            .clipShape(.rect(cornerRadius: 44))
        }
        .padding(16)
        .sheet(isPresented: $isSignInSheetPresented) {
            VStack(spacing: 12) {
                Spacer().frame(height: 16)
                AppleSignInButton {
                    handleAppleSignIn()
                }
                GoogleSignInButton {
                    handleGoogleSignIn()
                }
                MyButton("이메일로 계속하기", role: .assistive, expanded: true) {
                    router.push(.emailSignIn)
                    isSignInSheetPresented = false
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .presentationDetents([.height(220)])
        }
    }
}

extension StartView {
    private func handleAppleSignIn() {
        Task {
            do {
                let result = try await viewModel.signInWithApple()
            } catch {
                print(error)
            }
        }
    }

    private func handleGoogleSignIn() {
        Task {
            do {
                let result = try await viewModel.signInWithGoogle()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    StartView()
}

