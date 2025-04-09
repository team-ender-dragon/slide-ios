//
//  ProfileFeature.swift
//  Slide
//
//  Created by hhhello0507 on 4/8/25.
//

import Foundation

class ProfileViewModel: ObservableObject {
    let signInGoogle = SignInGoogle()
    let signInApple = SignInApple()
    
    func signInWithApple() async throws {
        let appleResult = try await signInApple.signInWithAppleFlow()
        print(appleResult)
    }
    
    func signInWithGoogle() async throws {
        let googleResult = try await signInGoogle.signInWithGoogleFlow()
        print(googleResult)
    }
}
