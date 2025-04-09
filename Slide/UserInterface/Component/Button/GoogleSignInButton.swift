//
//  GoogleLoginButton.swift
//  Slide
//
//  Created by hhhello0507 on 4/8/25.
//

import SwiftUI

struct GoogleSignInButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(.google)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Google로 계속하기")
                    .font(.body)
                    .foregroundStyle(Color(uiColor: .label))
            }
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .background(.gray.opacity(0.1))
            .clipShape(.rect(cornerRadius: 8))
        }
    }
}
