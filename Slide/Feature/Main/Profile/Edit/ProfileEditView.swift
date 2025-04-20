import SwiftUI
import PhotosUI

struct ProfileEditView: View {
    @StateObject private var viewModel = ProfileEditViewModel()
    
    var body: some View {
        MyNavigationBar.small(title: "프로필 수정") {
            VStack(alignment: .center) {
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
                        MyTextField("닉네임", text: $viewModel.nickname)
                    }
                    Spacer()
                    // Alternating Views and Spacers
                    MyButton("수정") {
                        
                    }
                }
                .padding(16)
            }
        }
    }
}

#Preview {
    ProfileEditView()
}
