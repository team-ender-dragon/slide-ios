import Foundation
import PhotosUI
import SwiftUI
import UIKit

final class EmailSignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var nickname: String = ""
    @Published var avatarImageItem: PhotosPickerItem? {
        didSet { loadAvatarImage() }
    }
    @Published var avatarPreview: UIImage?

    var avatarUrl: String = ""
    var isInputValid: Bool {
        !email.isEmpty && !password.isEmpty && !nickname.isEmpty
    }

    @Inject(\.authService) private var authService: AuthService

    @MainActor
    func signUp() async throws {
        let request = SignUpRequest(
            email: email,
            password: password,
            nickname: nickname,
            avatarUrl: avatarUrl.isEmpty ? nil : avatarUrl
        )
        let token = try await authService.signUp(request: request)
        Sign.shared.login(
            accessToken: token.accessToken,
            refreshToken: token.refreshToken
        )
    }

    private func loadAvatarImage() {
        guard let item = avatarImageItem else { return }
        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                self.avatarPreview = image
                // TODO: 실제 업로드하고 URL 저장 필요
                self.avatarUrl = "https://example.com/fake/\(UUID().uuidString).jpg"
            }
        }
    }
}
