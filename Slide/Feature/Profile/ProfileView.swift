//
//  ProfileView.swift
//  Slide
//
//  Created by hhhello0507 on 4/8/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isSignInSheetPresented = false
    
    var body: some View {
        MyNavigationBar.default(title: "프로필") { _ in
            Button {
                isSignInSheetPresented = true
            } label: {
                Text("로그인")
            }
        }
        .sheet(isPresented: $isSignInSheetPresented) {
            VStack(spacing: 12) {
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
            .padding(.horizontal, 12)
            .presentationDetents([.height(200)])
        }
    }
}

#Preview {
    ProfileView()
}
