import Foundation
import PhotosUI
import SwiftUI
import UIKit

final class ProfileEditViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var avatarImageItem: PhotosPickerItem? {
        didSet { loadAvatarImage() }
    }
    @Published var avatarPreview: UIImage?

    var avatarUrl: String = ""
    var isInputValid: Bool {
        !nickname.isEmpty
    }

    @Inject(\.userService) private var userService

    @MainActor
    func editProfile() async throws -> UserResponse {
        let request = EditUserRequest(nickname: nickname, avatarUrl: avatarUrl)
        return try await userService.editMyInfo(request: request)
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
